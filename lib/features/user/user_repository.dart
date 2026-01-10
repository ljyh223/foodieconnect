import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/errors/api_error.dart';
import '../../data/models/user_model.dart';
import 'user_api.dart';

/// 用户仓库层，封装业务逻辑
class UserRepository {
  /// 获取用户信息
  Future<User> fetchUserInfo(int userId) async {
    try {
      return await UserApi.getUserInfo(userId);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 上传用户头像
  Future<User> updateUserAvatar({required File avatarFile}) async {
    try {
      // 创建FormData
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          avatarFile.path,
          filename: avatarFile.path.split('/').last,
        ),
      });

      // 上传图片获取URL
      final uploadResponse = await UserApi.uploadAvatar(formData);
      final avatarUrl = uploadResponse['url'] as String?;

      if (avatarUrl == null || avatarUrl.isEmpty) {
        throw Exception('上传头像失败：未获取到图片URL');
      }

      // 更新用户头像URL
      return await UserApi.updateUserInfo({'avatarUrl': avatarUrl});
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 更新用户信息
  Future<User> updateUserInfo({
    String? displayName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (displayName != null) body['displayName'] = displayName;
      if (bio != null) body['bio'] = bio;
      if (avatarUrl != null) body['avatarUrl'] = avatarUrl;

      return await UserApi.updateUserInfo(body);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
