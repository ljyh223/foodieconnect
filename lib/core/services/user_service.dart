import 'dart:developer' as logger;
import 'dart:io';
import '../../data/models/user_model.dart';
import '../../features/user/user_repository.dart';

/// 用户服务类
class UserService {
  static final UserRepository _repository = UserRepository();

  /// 获取用户信息
  static Future<User> getUserInfo(int userId) async {
    try {
      return await _repository.fetchUserInfo(userId);
    } catch (e) {
      logger.log('获取用户信息失败: $e');
      throw Exception('获取用户信息失败: $e');
    }
  }

  /// 上传用户头像
  static Future<User> updateUserAvatar({required File avatarFile}) async {
    try {
      final result = await _repository.updateUserAvatar(avatarFile: avatarFile);

      logger.log('头像上传成功');

      return result;
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
      return await _repository.updateUserInfo(
        displayName: displayName,
        bio: bio,
        avatarUrl: avatarUrl,
      );
    } catch (e) {
      logger.log('更新用户信息失败: $e');
      throw Exception('更新用户信息失败: $e');
    }
  }
}
