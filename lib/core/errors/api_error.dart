import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

/// API错误模型，使用Freezed的sealed class实现
@freezed
class ApiError with _$ApiError {
  /// 网络错误
  const factory ApiError.network() = _Network;
  
  /// 服务器错误
  const factory ApiError.server(int code, String message) = _Server;
  
  /// 未知错误
  const factory ApiError.unknown(String message) = _Unknown;
  
  /// 从DioException创建ApiError
  factory ApiError.fromDio(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.cancel ||
        e.type == DioExceptionType.connectionError) {
      return const ApiError.network();
    }
    
    if (e.response != null) {
      final code = e.response!.statusCode ?? 0;
      final message = e.response?.data?['error']?['message'] as String? ??
          e.response?.data?['message'] as String? ??
          e.message ??
          '服务器错误';
      return ApiError.server(code, message);
    }
    
    return ApiError.unknown(e.message ?? '未知错误');
  }
}
