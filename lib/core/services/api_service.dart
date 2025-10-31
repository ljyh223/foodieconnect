
import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:io';
import 'package:http/http.dart' as http;
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
    // 使用UTF-8编码解码响应体，解决中文字符乱码问题
    final decoded = json.decode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> parsed = decoded is Map<String, dynamic> ? decoded : {'data': decoded};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // 如果返回包含 success 字段，遵循 success/data 结构
      if (parsed.containsKey('success')) {
        if (parsed['success'] == true) {
          return parsed;
        } else {
          throw Exception(parsed['error']?['message'] ?? '请求失败');
        }
      }

      // 否则直接返回解析后的顶层对象（方便兼容不包含 success 的接口）
      return parsed;
    } else {
      throw Exception(parsed['error']?['message'] ?? '网络请求失败');
    }
  }

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
    final headers = _getHeaders();
    try {
      // final masked = headers['Authorization'] != null ? ('Bearer ' + (headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*'))) : 'none';

      logger.log('ApiService.GET -> $uri | Authorization=${headers['Authorization']!.split(' ').last}');
    } catch (_) {}
    final response = await http.get(uri, headers: headers);
    try {
      logger.log('ApiService.GET <- ${response.statusCode} ${response.body.length} bytes');
    } catch (_) {}
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders();
    try {
      final masked = headers['Authorization'] != null ? ('Bearer ' + (headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*'))) : 'none';
      logger.log('ApiService.POST -> $uri | Authorization=$masked | body=${body != null ? json.encode(body).substring(0, json.encode(body).length > 200 ? 200 : json.encode(body).length) : 'null'}');
    } catch (_) {}
    final response = await http.post(
      uri,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );
    try {
      logger.log('ApiService.POST <- ${response.statusCode} ${response.body.length} bytes');
    } catch (_) {}
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders();
    try {
      final masked = headers['Authorization'] != null ? ('Bearer ' + (headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*'))) : 'none';
      logger.log('ApiService.PUT -> $uri | Authorization=$masked');
    } catch (_) {}
    final response = await http.put(
      uri,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );
    try {
      logger.log('ApiService.PUT <- ${response.statusCode} ${response.body.length} bytes');
    } catch (_) {}
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = _getHeaders();
    try {
      final masked = headers['Authorization'] != null ? ('Bearer ' + (headers['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*'))) : 'none';
      logger.log('ApiService.DELETE -> $uri | Authorization=$masked');
    } catch (_) {}
    final response = await http.delete(
      uri,
      headers: headers,
    );
    try {
      logger.log('ApiService.DELETE <- ${response.statusCode} ${response.body.length} bytes');
    } catch (_) {}
    return _handleResponse(response);
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
    final cleanPath = imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
    return '${AppConstants.baseUrl}/$cleanPath';
  }

  /// 上传图片到服务器
  /// 返回包含图片URL的响应数据
  Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    final uri = Uri.parse('$_baseUrl/upload/image'); // 单张图片上传端点
    final headers = _getHeaders();
    
    // 移除Content-Type，让http包自动设置multipart/form-data边界
    final uploadHeaders = Map<String, String>.from(headers);
    uploadHeaders.remove('Content-Type');
    
    try {
      final masked = uploadHeaders['Authorization'] != null ?
          ('Bearer ' + (uploadHeaders['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*'))) : 'none';
      logger.log('ApiService.UPLOAD -> $uri | Authorization=$masked | file=${imageFile.path.split('/').last}');
    } catch (_) {}
    
    // 创建multipart请求
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(uploadHeaders)
      ..files.add(await http.MultipartFile.fromPath(
        'file', // 字段名，根据后端API调整
        imageFile.path,
      ));
    
    // 发送请求
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    
    try {
      logger.log('ApiService.UPLOAD <- ${response.statusCode} ${response.body.length} bytes');
    } catch (_) {}
    
    return _handleResponse(response);
  }

  /// 批量上传图片
  /// 返回图片URL列表
  Future<List<String>> uploadImages(List<File> imageFiles) async {
    if (imageFiles.isEmpty) return [];
    
    final uri = Uri.parse('$_baseUrl/upload/images'); // 批量上传端点
    final headers = _getHeaders();
    
    // 移除Content-Type，让http包自动设置multipart/form-data边界
    final uploadHeaders = Map<String, String>.from(headers);
    uploadHeaders.remove('Content-Type');
    
    try {
      final masked = uploadHeaders['Authorization'] != null ?
          ('Bearer ' + (uploadHeaders['Authorization']!.split(' ').last.replaceAll(RegExp('.(?=.{4})'), '*'))) : 'none';
      logger.log('ApiService.UPLOAD_BATCH -> $uri | Authorization=$masked | files=${imageFiles.length}');
    } catch (_) {}
    
    // 创建multipart请求
    final request = http.MultipartRequest('POST', uri)
      ..headers.addAll(uploadHeaders);
    
    // 添加多个文件
    for (final imageFile in imageFiles) {
      request.files.add(await http.MultipartFile.fromPath(
        'files', // 字段名，根据后端API调整
        imageFile.path,
      ));
    }
    
    // 发送请求
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    
    try {
      logger.log('ApiService.UPLOAD_BATCH <- ${response.statusCode} ${response.body.length} bytes');
    } catch (_) {}
    
    final responseData = await _handleResponse(response);
    List<String> imageUrls = [];
    
    // 解析响应数据，提取URL列表
    if (responseData['data'] != null) {
      final data = responseData['data'];
      if (data is Map<String, dynamic>) {
        // 如果是Map，提取所有URL值
        data.forEach((key, value) {
          if (value is String) {
            imageUrls.add(value);
          }
        });
      } else if (data is List) {
        // 如果是List，提取所有URL
        for (final item in data) {
          if (item is String) {
            imageUrls.add(item);
          } else if (item is Map<String, dynamic> && item['url'] is String) {
            imageUrls.add(item['url'] as String);
          }
        }
      }
    }
    
    return imageUrls;
  }

}
