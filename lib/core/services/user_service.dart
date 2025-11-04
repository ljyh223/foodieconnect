import 'dart:developer' as logger;
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
      
      // 添加详细的调试日志
      logger.log('获取用户信息成功: $userId');
      logger.log('API返回数据结构: ${data.runtimeType}');
      if (data is Map<String, dynamic>) {
        logger.log('用户数据字段: ${data.keys.toList()}');
        if (data.containsKey('favoriteFoods')) {
          logger.log('favoriteFoods类型: ${data['favoriteFoods'].runtimeType}');
          logger.log('favoriteFoods内容: ${data['favoriteFoods']}');
        }
      }
      
      return User.fromJson(data);
    } catch (e) {
      logger.log('获取用户信息失败: $e');
      logger.log('错误堆栈: ${StackTrace.current}');
      throw Exception('获取用户信息失败: $e');
    }
  }

  /// 更新用户信息
  static Future<User> updateUserInfo({
    required int userId,
    String? displayName,
    String? bio,
    String? phone,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (displayName != null) body['displayName'] = displayName;
      if (bio != null) body['bio'] = bio;
      if (phone != null) body['phone'] = phone;

      final response = await _apiService.put('/api/users/$userId', body: body);
      final data = response['data'];
      
      logger.log('更新用户信息成功: $userId');
      
      return User.fromJson(data);
    } catch (e) {
      logger.log('更新用户信息失败: $e');
      throw Exception('更新用户信息失败: $e');
    }
  }
}