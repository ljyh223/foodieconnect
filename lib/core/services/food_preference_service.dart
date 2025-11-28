import 'dart:developer' as logger;
import 'api_service.dart';
import '../../data/models/food_preference_model.dart';

/// 用户喜好食物服务类
class FoodPreferenceService {
  static final ApiService _apiService = ApiService();

  /// 获取用户喜好食物列表
  static Future<List<FoodPreference>> getUserPreferences(int userId) async {
    try {
      final response = await _apiService.get(
        '/users/$userId/food-preferences',
        requireAuth: true, // 获取用户喜好需要认证
      );
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('获取用户喜好食物成功，数量: ${data.length}');
      
      return data.map((json) => FoodPreference.fromJson(json)).toList();
    } catch (e) {
      logger.log('获取用户喜好食物失败: $e');
      throw Exception('获取用户喜好食物失败: $e');
    }
  }

  /// 添加用户喜好食物
  static Future<FoodPreference> addPreference({
    required int userId,
    required String foodName,
    String? category,
    String? description,
  }) async {
    try {
      final body = {
        'userId': userId,
        'foodName': foodName,
        if (category != null) 'category': category,
        if (description != null) 'description': description,
      };

      final response = await _apiService.post(
        '/users/$userId/food-preferences',
        body: body,
        requireAuth: true, // 添加喜好需要认证
      );
      final data = response['data'];
      
      logger.log('添加用户喜好食物成功: $foodName');
      
      return FoodPreference.fromJson(data);
    } catch (e) {
      logger.log('添加用户喜好食物失败: $e');
      throw Exception('添加用户喜好食物失败: $e');
    }
  }

  /// 更新用户喜好食物
  static Future<FoodPreference> updatePreference({
    required int preferenceId,
    required int userId,
    String? foodName,
    String? category,
    String? description,
  }) async {
    try {
      final body = {
        if (foodName != null) 'foodName': foodName,
        if (category != null) 'category': category,
        if (description != null) 'description': description,
      };

      final response = await _apiService.put(
        '/users/$userId/food-preferences/$preferenceId',
        body: body,
        requireAuth: true, // 更新喜好需要认证
      );
      final data = response['data'];
      
      logger.log('更新用户喜好食物成功，ID: $preferenceId');
      
      return FoodPreference.fromJson(data);
    } catch (e) {
      logger.log('更新用户喜好食物失败: $e');
      throw Exception('更新用户喜好食物失败: $e');
    }
  }

  /// 删除用户喜好食物
  static Future<bool> deletePreference({
    required int preferenceId,
    required int userId,
  }) async {
    try {
      await _apiService.delete(
        '/users/$userId/food-preferences/$preferenceId',
        requireAuth: true, // 删除喜好需要认证
      );
      
      logger.log('删除用户喜好食物成功，ID: $preferenceId');
      
      return true;
    } catch (e) {
      logger.log('删除用户喜好食物失败: $e');
      throw Exception('删除用户喜好食物失败: $e');
    }
  }

  /// 批量添加用户喜好食物
  static Future<List<FoodPreference>> addMultiplePreferences({
    required int userId,
    required List<String> foodNames,
    String? category,
  }) async {
    try {
      final List<FoodPreference> preferences = [];
      
      for (final foodName in foodNames) {
        final preference = await addPreference(
          userId: userId,
          foodName: foodName,
          category: category,
        );
        preferences.add(preference);
      }
      
      logger.log('批量添加用户喜好食物成功，数量: ${preferences.length}');
      
      return preferences;
    } catch (e) {
      logger.log('批量添加用户喜好食物失败: $e');
      throw Exception('批量添加用户喜好食物失败: $e');
    }
  }

  /// 获取所有食物分类
  static Future<List<String>> getFoodCategories() async {
    try {
      final response = await _apiService.get(
        '/food-categories',
        requireAuth: false, // 获取食物分类不需要认证
      );
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('获取食物分类成功，数量: ${data.length}');
      
      return data.map((category) => category.toString()).toList();
    } catch (e) {
      logger.log('获取食物分类失败: $e');
      // 如果API不存在，返回默认分类
      return ['中餐', '西餐', '日料', '韩料', '泰餐', '意餐', '法餐', '甜品', '饮品', '小吃'];
    }
  }
}