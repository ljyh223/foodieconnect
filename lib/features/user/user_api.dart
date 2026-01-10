import 'package:dio/dio.dart';
import '../../network/dio_client.dart';
import '../../data/models/user_model.dart';

/// 用户API层，处理与服务器的直接通信
class UserApi {
  /// 获取用户信息
  static Future<User> getUserInfo(int userId) async {
    final response = await DioClient.dio.get('/api/users/$userId');
    return User.fromJson(response.data['data']);
  }

  /// 更新用户头像
  static Future<Map<String, dynamic>> uploadAvatar(dynamic formData) async {
    final response = await DioClient.dio.post(
      '/upload/image',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return response.data;
  }

  /// 更新用户信息
  static Future<User> updateUserInfo(Map<String, dynamic> body) async {
    final response = await DioClient.dio.put('/api/users/profile', data: body);
    return User.fromJson(response.data['data']);
  }
}
