import 'dart:developer' as logger;
import 'dart:io';
import 'api_service.dart';
import '../../data/models/user_model.dart';

/// 用户服务类
class UserService {
  static final ApiService _apiService = ApiService();

  /// 获取用户信息
  static Future<User> getUserInfo(int userId) async {
    try {
      final response = await _apiService.get('/api/users/$userId');
      final data = response['data'];
      
      return User.fromJson(data);
    } catch (e) {
      logger.log('获取用户信息失败: $e');
      throw Exception('获取用户信息失败: $e');
    }
  }

  /// 上传用户头像
  static Future<User> updateUserAvatar({
    required File avatarFile,
  }) async {
    try {
      // 上传图片获取URL
      final response = await _apiService.uploadImage(avatarFile);
      final avatarUrl = response['url'];
      
      if (avatarUrl == null) {
        throw Exception('上传头像失败：未获取到图片URL');
      }
      
      logger.log('头像上传成功，URL: $avatarUrl');

      // 更新用户头像URL
      final updateResponse = await _apiService.put('/api/users/profile', body: {'avatarUrl': avatarUrl});
      final data = updateResponse['data'];
      
      return User.fromJson(data);
    } catch (e) {
      logger.log('更新用户头像失败: $e');
      throw Exception('更新用户头像失败: $e');
    }
  }

  /// 更新用户信息
  static Future<User> updateUserInfo({
    String? displayName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (displayName != null) body['displayName'] = displayName;
      if (bio != null) body['bio'] = bio;
      if (avatarUrl != null) body['avatarUrl'] = avatarUrl;

      final response = await _apiService.put('/api/users/profile', body: body);
      final data = response['data'];
      
      return User.fromJson(data);
    } catch (e) {
      logger.log('更新用户信息失败: $e');
      throw Exception('更新用户信息失败: $e');
    }
  }
}