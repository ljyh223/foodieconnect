
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import '../constants/app_constants.dart';
import 'auth_service.dart';
import '../utils/token_storage.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;
  final String _baseUrl = AppConstants.baseUrl;
  bool _isRefreshing = false;
  final List<Completer<void>> _refreshCompleters = [];

  void setToken(String token) {
    // Normalize: if token includes a "Bearer " prefix, remove it to avoid double-prefixing
    final normalized = token.startsWith('Bearer ') ? token.substring(7) : token;
    _token = normalized;
    // debug help: log token presence (don't log full token in production)
    try {
      logger.log('ApiService.setToken: token set, length=${normalized.length}');
    } catch (_) {}
  }

  void clearToken() {
    _token = null;
    try {
      logger.log('ApiService.clearToken called');
    } catch (_) {}
  }

  Map<String, String> _getHeaders({bool requireAuth = false}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      logger.log('ApiService._getHeaders: hasToken=${_token != null}, requireAuth=$requireAuth');
    } catch (_) {}

    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    } else if (requireAuth) {
      // 如果需要认证但没有token，抛出异常
      throw ApiException('NO_TOKEN', '用户未登录，请先登录', 401);
    }

    return headers;
  }

  /// 处理token刷新
  Future<void> _refreshToken() async {
    if (_isRefreshing) {
      // 如果已经在刷新，等待刷新完成
      final completer = Completer<void>();
      _refreshCompleters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;
    try {
      logger.log('开始刷新token...');
      
      // 从存储中获取refresh token
      final refreshToken = await TokenStorage.readRefreshToken();
      
      if (refreshToken == null || refreshToken.isEmpty) {
        throw ApiException('TOKEN_EXPIRED', '刷新令牌不存在，请重新登录', 401);
      }
      
      // 调用AuthService刷新token
      await AuthService.refresh(refreshToken);
      
      logger.log('token刷新成功');
      
      // 通知所有等待的请求
      for (final completer in _refreshCompleters) {
        completer.complete();
      }
    } catch (e) {
      logger.log('token刷新失败: $e');
      
      // 刷新失败，清除所有token
      await TokenStorage.deleteAll();
      clearToken();
      
      // 通知所有等待的请求刷新失败
      for (final completer in _refreshCompleters) {
        completer.completeError(e);
      }
      rethrow;
    } finally {
      _isRefreshing = false;
      _refreshCompleters.clear();
    }
  }

  /// 处理HTTP响应，包含token过期自动刷新
  Future<Map<String, dynamic>> _handleResponse(http.Response response, {bool isRetry = false}) async {
    try {
      // 使用UTF-8编码解码响应体，解决中文字符乱码问题
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      final Map<String, dynamic> parsed = decoded is Map<String, dynamic>
          ? decoded
          : {'data': decoded};

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // 如果返回包含 success 字段，遵循 success/data 结构
        if (parsed.containsKey('success')) {
          if (parsed['success'] == true) {
            return parsed;
          } else {
            final errorMessage =
                parsed['error']?['message'] ??
                parsed['error']?['details'] ??
                'Request failed';
            throw ApiException(
              parsed['error']?['code'] ?? 'REQUEST_FAILED',
              errorMessage,
              response.statusCode,
            );
          }
        }

        // 否则直接返回解析后的顶层对象（方便兼容不包含 success 的接口）
        return parsed;
      } else {
        // 处理token过期 (401)
        if (response.statusCode == 401 && !isRetry) {
          final errorCode = parsed['error']?['code'] ?? 'TOKEN_EXPIRED';
          if (errorCode == 'TOKEN_EXPIRED' || errorCode == 'INVALID_TOKEN') {
            logger.log('检测到token过期，尝试刷新...');
            await _refreshToken();
            // 刷新成功后重试请求
            throw RetryRequestException();
          }
        }

        final errorMessage =
            parsed['error']?['message'] ??
            parsed['error']?['details'] ??
            'Network request failed';
        throw ApiException(
          parsed['error']?['code'] ?? 'NETWORK_ERROR',
          errorMessage,
          response.statusCode,
        );
      }
    } on FormatException catch (e) {
      throw ApiException(
        'PARSE_ERROR',
        '响应解析失败: ${e.message}',
        response.statusCode,
      );
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(
        'UNKNOWN_ERROR',
        '未知错误: ${e.toString()}',
        response.statusCode,
      );
    }
  }

  /// 发送HTTP请求，支持token过期自动重试
  Future<Map<String, dynamic>> _sendRequest(
    Future<http.Response> Function() requestFn,
  ) async {
    try {
      final response = await requestFn();
      return await _handleResponse(response);
    } on RetryRequestException {
      // 重试请求（token已刷新）
      logger.log('重试请求...');
      final response = await requestFn();
      return await _handleResponse(response, isRetry: true);
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    bool requireAuth = true, // 默认需要认证
  }) async {
    final uri = Uri.parse(
      '$_baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    final headers = _getHeaders(requireAuth: requireAuth);
    try {
      final authHeader = headers['Authorization'];
      if (authHeader != null) {
        final token = authHeader.split(' ').last;
        logger.log('ApiService.GET -> $uri | Authorization=$token');
      } else {
        logger.log('ApiService.GET -> $uri | Authorization=none');
      }
    } catch (_) {}

    return _sendRequest(() async {
      return await http
          .get(uri, headers: headers)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('请求超时', const Duration(seconds: 30));
            },
          );
    });
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requireAuth = true, // 默认需要认证
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders(requireAuth: requireAuth);
    try {
      final masked = headers['Authorization'] != null
          ? 'Bearer ${headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*')}'
          : 'none';
      final encodedBody = body != null ? json.encode(body) : 'null';
      final truncatedBody = encodedBody.length > 200
          ? encodedBody.substring(0, 200)
          : encodedBody;
      logger.log(
        'ApiService.POST -> $uri | Authorization=$masked | body=$truncatedBody',
      );
    } catch (_) {}

    return _sendRequest(() async {
      return await http
          .post(
            uri,
            headers: headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('请求超时', const Duration(seconds: 30));
            },
          );
    });
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    bool requireAuth = true, // 默认需要认证
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders(requireAuth: requireAuth);
    try {
      final masked = headers['Authorization'] != null
          ? 'Bearer ${headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*')}'
          : 'none';
      logger.log('ApiService.PUT -> $uri | Authorization=$masked');
    } catch (_) {}

    return _sendRequest(() async {
      return await http
          .put(
            uri,
            headers: headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('请求超时', const Duration(seconds: 30));
            },
          );
    });
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    bool requireAuth = true, // 默认需要认证
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders(requireAuth: requireAuth);
    try {
      final masked = headers['Authorization'] != null
          ? 'Bearer ${headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*')}'
          : 'none';
      logger.log('ApiService.DELETE -> $uri | Authorization=$masked');
    } catch (_) {}

    return _sendRequest(() async {
      return await http
          .delete(uri, headers: headers)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('请求超时', const Duration(seconds: 30));
            },
          );
    });
  }

  /// 将相对路径图片URL转换为完整URL
  /// 如果传入的URL已经是完整URL，则直接返回
  /// 如果是相对路径，则拼接基础URL
  static String getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return '';
    }

    // 如果已经是完整URL（包含http://或https://），直接返回
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return imageUrl;
    }

    // 如果是相对路径，拼接基础URL
    // 移除开头的斜杠，避免重复
    final cleanPath = imageUrl.startsWith('/')
        ? imageUrl.substring(1)
        : imageUrl;
    return '${AppConstants.baseUrl}/$cleanPath';
  }

  /// 上传图片到服务器
  /// 返回包含url、filename、size的Map
  Future<Map<String, String>> uploadImage(File imageFile) async {
    final uri = Uri.parse('$_baseUrl/upload/image');
    final headers = _getHeaders(requireAuth: true);

    // 移除Content-Type，让http包自动设置multipart/form-data边界
    final uploadHeaders = Map<String, String>.from(headers);
    uploadHeaders.remove('Content-Type');

    // 创建multipart请求
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(uploadHeaders);

    // 获取文件名
    final fileName = imageFile.path.split('/').last;
    final fileExtension = path.extension(imageFile.path).toLowerCase();

    // 根据文件扩展名设置内容类型
    MediaType contentType;
    if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
      contentType = MediaType('image', 'jpeg');
    } else if (fileExtension == '.png') {
      contentType = MediaType('image', 'png');
    } else if (fileExtension == '.gif') {
      contentType = MediaType('image', 'gif');
    } else if (fileExtension == '.webp') {
      contentType = MediaType('image', 'webp');
    } else {
      // 如果是不支持的格式，转换为JPEG
      contentType = MediaType('image', 'jpeg');
    }

    // 添加文件到请求
    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // 字段名与后端@RequestParam("file")对应
        imageFile.path,
        filename: fileName,
        contentType: contentType,
      ),
    );

    try {
      logger.log('ApiService.UPLOAD -> $uri | file: $fileName');
    } catch (_) {}

    // 发送请求
    try {
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60), // 上传文件需要更长时间
        onTimeout: () {
          throw TimeoutException('上传超时', const Duration(seconds: 60));
        },
      );
      final response = await http.Response.fromStream(streamedResponse);

      try {
        logger.log(
          'ApiService.UPLOAD <- ${response.statusCode} ${response.body.length} bytes',
        );
      } catch (_) {}

      final responseData = await _handleResponse(response);

      // 根据后端返回结构解析数据
      if (responseData['data'] != null &&
          responseData['data'] is Map<String, dynamic>) {
        final data = responseData['data'] as Map<String, dynamic>;

        // 提取URL、文件名和大小信息
        final Map<String, String> result = {};

        if (data['url'] is String) {
          result['url'] = data['url'] as String;
        }
        if (data['filename'] is String) {
          result['filename'] = data['filename'] as String;
        }
        if (data['size'] is String) {
          result['size'] = data['size'] as String;
        }

        if (result['url'] == null || result['url']!.isEmpty) {
          throw ApiException(
            'UPLOAD_ERROR',
            '无法从响应中提取图片URL',
            response.statusCode,
          );
        }

        logger.log(
          '上传成功: URL=${result['url']}, filename=${result['filename']}, size=${result['size']}',
        );
        return result;
      } else {
        throw ApiException(
          'UPLOAD_ERROR',
          '响应数据格式不正确: $responseData',
          response.statusCode,
        );
      }
    } on TimeoutException catch (e) {
      throw ApiException('TIMEOUT_ERROR', '上传超时: ${e.message}', 408);
    } on SocketException catch (e) {
      throw ApiException('NETWORK_ERROR', '网络连接失败: ${e.message}', 0);
    } on HttpException catch (e) {
      throw ApiException('HTTP_ERROR', 'HTTP错误: ${e.message}', 0);
    }
  }

  /// 批量上传图片（最多5个文件）
  /// 返回上传结果，包含成功和失败的文件信息
  Future<Map<String, dynamic>> uploadImages(List<File> imageFiles) async {
    if (imageFiles.isEmpty) {
      throw Exception('请选择要上传的文件');
    }

    if (imageFiles.length > 5) {
      throw Exception('一次最多只能上传5个文件');
    }

    final uri = Uri.parse('$_baseUrl/upload/images');
    final headers = _getHeaders(requireAuth: true);

    // 移除Content-Type，让http包自动设置multipart/form-data边界
    final uploadHeaders = Map<String, String>.from(headers);
    uploadHeaders.remove('Content-Type');

    try {
      final masked = uploadHeaders['Authorization'] != null
          ? 'Bearer ${uploadHeaders['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*')}'
          : 'none';
      logger.log(
        'ApiService.UPLOAD_BATCH -> $uri | Authorization=$masked | files=${imageFiles.length}',
      );
    } catch (_) {}

    // 创建multipart请求
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(uploadHeaders);

    // 添加多个文件
    for (int i = 0; i < imageFiles.length; i++) {
      final imageFile = imageFiles[i];
      final fileName = imageFile.path.split('/').last;

      request.files.add(
        await http.MultipartFile.fromPath(
          'files', // 字段名与后端@RequestParam("files")对应
          imageFile.path,
          filename: fileName,
        ),
      );

      logger.log('添加文件到批量上传: $fileName');
    }

    try {
      // 发送请求
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 90), // 批量上传需要更长时间
        onTimeout: () {
          throw TimeoutException('批量上传超时', const Duration(seconds: 90));
        },
      );
      final response = await http.Response.fromStream(streamedResponse);

      logger.log(
        'ApiService.UPLOAD_BATCH <- ${response.statusCode} ${response.body.length} bytes',
      );

      final responseData = await _handleResponse(response);

      // 根据后端返回结构解析数据
      if (responseData['data'] != null &&
          responseData['data'] is Map<String, dynamic>) {
        final data = responseData['data'] as Map<String, dynamic>;

        logger.log(
          '批量上传结果: total=${data['total']}, successCount=${data['successCount']}, failedCount=${data['failedCount']}',
        );

        // 返回完整的结果数据，让调用方根据需要处理
        return data;
      } else {
        throw ApiException(
          'UPLOAD_ERROR',
          '响应数据格式不正确: $responseData',
          response.statusCode,
        );
      }
    } on TimeoutException catch (e) {
      throw ApiException('TIMEOUT_ERROR', '批量上传超时: ${e.message}', 408);
    } on SocketException catch (e) {
      throw ApiException('NETWORK_ERROR', '网络连接失败: ${e.message}', 0);
    } on HttpException catch (e) {
      throw ApiException('HTTP_ERROR', 'HTTP错误: ${e.message}', 0);
    } catch (e) {
      logger.log('批量上传过程中发生错误: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('UPLOAD_ERROR', '批量上传失败: ${e.toString()}', 0);
    }
  }

  /// 便捷方法：批量上传图片并返回成功的URL列表
  /// 如果只需要成功的URL，可以使用这个方法
  /// 改为循环调用单个图片上传，避免批量上传API的问题
  Future<List<String>> uploadImagesAndGetUrls(List<File> imageFiles) async {
    final List<String> urls = [];

    for (final imageFile in imageFiles) {
      try {
        final result = await uploadImage(imageFile);
        if (result['url'] != null && result['url']!.isNotEmpty) {
          urls.add(result['url']!);
          logger.log('图片上传成功: ${result['url']}');
        } else {
          logger.log('图片上传失败: 未返回URL');
        }
      } catch (e) {
        logger.log('图片上传异常: $e');
        // 继续上传其他图片，不中断整个流程
      }
    }

    logger.log('批量上传完成: 成功${urls.length}/${imageFiles.length}');
    return urls;
  }
}

/// 自定义API异常类
class ApiException implements Exception {
  final String code;
  final String message;
  final int statusCode;

  ApiException(this.code, this.message, this.statusCode);

  @override
  String toString() {
    return 'ApiException{code: $code, message: $message, statusCode: $statusCode}';
  }
}

/// 重试请求异常（用于token刷新后重试）
class RetryRequestException implements Exception {
  const RetryRequestException();
}
