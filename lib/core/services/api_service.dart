
import 'dart:convert';
import 'dart:developer' as logger;
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;
  final String? _baseUrl = AppConstants.baseUrl;

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
      logger.log('ApiService.POST -> $uri | Authorization=$masked | body=${body != null ? json.encode(body).substring(0, (json.encode(body).length>200?200:json.encode(body).length)) : 'null'}');
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

}
