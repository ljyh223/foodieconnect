import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import '../constants/app_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;
  final String _baseUrl = AppConstants.baseUrl;

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

  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      logger.log('ApiService._getHeaders: hasToken=${_token != null}');
    } catch (_) {}

    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
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

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    final headers = _getHeaders();
    try {
      final authHeader = headers['Authorization'];
      if (authHeader != null) {
        final token = authHeader.split(' ').last;
        logger.log('ApiService.GET -> $uri | Authorization=$token');
      } else {
        logger.log('ApiService.GET -> $uri | Authorization=none');
      }
    } catch (_) {}

    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('请求超时', const Duration(seconds: 30));
            },
          );

      try {
        logger.log(
          'ApiService.GET <- ${response.statusCode} ${response.body.length} bytes',
        );
      } catch (_) {}
      return _handleResponse(response);
    } on TimeoutException catch (e) {
      throw ApiException('TIMEOUT_ERROR', '请求超时: ${e.message}', 408);
    } on SocketException catch (e) {
      throw ApiException('NETWORK_ERROR', '网络连接失败: ${e.message}', 0);
    } on HttpException catch (e) {
      throw ApiException('HTTP_ERROR', 'HTTP错误: ${e.message}', 0);
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders();
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

    try {
      final response = await http
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

      try {
        logger.log(
          'ApiService.POST <- ${response.statusCode} ${response.body.length} bytes',
        );
      } catch (_) {}
      return _handleResponse(response);
    } on TimeoutException catch (e) {
      throw ApiException('TIMEOUT_ERROR', '请求超时: ${e.message}', 408);
    } on SocketException catch (e) {
      throw ApiException('NETWORK_ERROR', '网络连接失败: ${e.message}', 0);
    } on HttpException catch (e) {
      throw ApiException('HTTP_ERROR', 'HTTP错误: ${e.message}', 0);
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders();
    try {
      final masked = headers['Authorization'] != null
          ? 'Bearer ${headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*')}'
          : 'none';
      logger.log('ApiService.PUT -> $uri | Authorization=$masked');
    } catch (_) {}

    try {
      final response = await http
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

      try {
        logger.log(
          'ApiService.PUT <- ${response.statusCode} ${response.body.length} bytes',
        );
      } catch (_) {}
      return _handleResponse(response);
    } on TimeoutException catch (e) {
      throw ApiException('TIMEOUT_ERROR', '请求超时: ${e.message}', 408);
    } on SocketException catch (e) {
      throw ApiException('NETWORK_ERROR', '网络连接失败: ${e.message}', 0);
    } on HttpException catch (e) {
      throw ApiException('HTTP_ERROR', 'HTTP错误: ${e.message}', 0);
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders();
    try {
      final masked = headers['Authorization'] != null
          ? 'Bearer ${headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*')}'
          : 'none';
      logger.log('ApiService.DELETE -> $uri | Authorization=$masked');
    } catch (_) {}

    try {
      final response = await http
          .delete(uri, headers: headers)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw TimeoutException('请求超时', const Duration(seconds: 30));
            },
          );

      try {
        logger.log(
          'ApiService.DELETE <- ${response.statusCode} ${response.body.length} bytes',
        );
      } catch (_) {}
      return _handleResponse(response);
    } on TimeoutException catch (e) {
      throw ApiException('TIMEOUT_ERROR', '请求超时: ${e.message}', 408);
    } on SocketException catch (e) {
      throw ApiException('NETWORK_ERROR', '网络连接失败: ${e.message}', 0);
    } on HttpException catch (e) {
      throw ApiException('HTTP_ERROR', 'HTTP错误: ${e.message}', 0);
    }
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
    final headers = _getHeaders();

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
    final headers = _getHeaders();

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
  Future<List<String>> uploadImagesAndGetUrls(List<File> imageFiles) async {
    final result = await uploadImages(imageFiles);

    if (result['success'] != null &&
        result['success'] is Map<String, dynamic>) {
      final successFiles = result['success'] as Map<String, dynamic>;
      // 提取所有成功的URL
      final urls = successFiles.values.whereType<String>().toList();
      logger.log('成功上传的图片URL列表: $urls');
      return urls;
    }

    return [];
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
