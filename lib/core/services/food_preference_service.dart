import 'dart:developer' as logger;
import '../../data/models/food_preference_model.dart';
import '../../features/food_preference/food_preference_repository.dart';

/// 用户喜好食物服务类
class FoodPreferenceService {
  static final FoodPreferenceRepository _foodPreferenceRepository = FoodPreferenceRepository();

  /// 获取用户喜好食物列表
  static Future<List<FoodPreference>> getUserPreferences(int userId) async {
    try {
      final result = await _foodPreferenceRepository.getUserPreferences(userId);
      
      logger.log('获取用户喜好食物成功，数量: ${result.length}');
      
      return result;
    } catch (e) {
      logger.log('获取用户喜好食物失败: $e');
      rethrow;
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
      final result = await _foodPreferenceRepository.addPreference(
        userId: userId,
        foodName: foodName,
        category: category,
        description: description,
      );
      
      logger.log('添加用户喜好食物成功: $foodName');
      
      return result;
    } catch (e) {
      logger.log('添加用户喜好食物失败: $e');
      rethrow;
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
      final result = await _foodPreferenceRepository.updatePreference(
        preferenceId: preferenceId,
        userId: userId,
        foodName: foodName,
        category: category,
        description: description,
      );
      
      logger.log('更新用户喜好食物成功，ID: $preferenceId');
      
      return result;
    } catch (e) {
      logger.log('更新用户喜好食物失败: $e');
      rethrow;
    }
  }

  /// 删除用户喜好食物
  static Future<bool> deletePreference({
    required int preferenceId,
    required int userId,
  }) async {
    try {
      await _foodPreferenceRepository.deletePreference(
        preferenceId: preferenceId,
        userId: userId,
      );
      
      logger.log('删除用户喜好食物成功，ID: $preferenceId');
      
      return true;
    } catch (e) {
      logger.log('删除用户喜好食物失败: $e');
      rethrow;
    }
  }

  /// 批量添加用户喜好食物
  static Future<List<FoodPreference>> addMultiplePreferences({
    required int userId,
    required List<String> foodNames,
    String? category,
  }) async {
    try {
      final result = await _foodPreferenceRepository.addMultiplePreferences(
        userId: userId,
        foodNames: foodNames,
        category: category,
      );
      
      logger.log('批量添加用户喜好食物成功，数量: ${result.length}');
      
      return result;
    } catch (e) {
      logger.log('批量添加用户喜好食物失败: $e');
      rethrow;
    }
  }

  /// 获取所有食物分类
  static Future<List<String>> getFoodCategories() async {
    try {
      final result = await _foodPreferenceRepository.getFoodCategories();
      
      logger.log('获取食物分类成功，数量: ${result.length}');
      
      return result;
    } catch (e) {
      logger.log('获取食物分类失败: $e');
      // 如果API调用失败，返回默认值
      return ['中餐', '西餐', '日料', '韩料', '泰餐', '意餐', '法餐', '甜品', '饮品', '小吃'];
    }
  }
}