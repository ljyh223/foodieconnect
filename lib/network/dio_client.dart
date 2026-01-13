import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodieconnect/core/constants/app_constants.dart';
import 'package:foodieconnect/core/utils/token_storage.dart';

/// 全局Dio客户端配置类
class DioClient {
  /// 全局Dio实例
  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
            sendTimeout: const Duration(seconds: 5),
            contentType: 'application/json',
          ),
        )
        // 添加日志拦截器
        ..interceptors.add(
          LogInterceptor(
            responseBody: true,
            requestBody: true,
            logPrint: (object) {
              print('DioLog: $object');
            },
          ),
        )
        // 添加认证拦截器
        ..interceptors.add(AuthInterceptor())
        // 添加错误处理拦截器
        ..interceptors.add(ErrorInterceptor());
}

/// 认证拦截器
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 这里可以添加认证逻辑，例如从本地存储获取token
    final token = await TokenStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      // 确保只添加一次Bearer前缀
      final authToken = token.startsWith('Bearer ') ? token : 'Bearer $token';
      options.headers['Authorization'] = authToken;
    }
    super.onRequest(options, handler);
  }
}

/// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 这里可以添加统一的错误处理逻辑
    print('DioError: ${err.message}');
    super.onError(err, handler);
  }
}
