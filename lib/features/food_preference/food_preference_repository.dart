import '../../core/errors/api_error.dart';
import '../../data/models/food_preference_model.dart';
import 'food_preference_api.dart';

class FoodPreferenceRepository {
  /// 获取用户喜好食物列表
  Future<List<FoodPreference>> getUserPreferences(int userId) async {
    try {
      return await FoodPreferenceApi.getUserPreferences(userId);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 添加用户喜好食物
  Future<FoodPreference> addPreference({
    required int userId,
    required String foodName,
    String? category,
    String? description,
  }) async {
    try {
      return await FoodPreferenceApi.addPreference(
        userId: userId,
        foodName: foodName,
        category: category,
        description: description,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 更新用户喜好食物
  Future<FoodPreference> updatePreference({
    required int preferenceId,
    required int userId,
    String? foodName,
    String? category,
    String? description,
  }) async {
    try {
      return await FoodPreferenceApi.updatePreference(
        preferenceId: preferenceId,
        userId: userId,
        foodName: foodName,
        category: category,
        description: description,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 删除用户喜好食物
  Future<void> deletePreference({
    required int preferenceId,
    required int userId,
  }) async {
    try {
      await FoodPreferenceApi.deletePreference(
        preferenceId: preferenceId,
        userId: userId,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取所有食物分类
  Future<List<String>> getFoodCategories() async {
    try {
      return await FoodPreferenceApi.getFoodCategories();
    } catch (e) {
      // 如果API不存在，返回默认分类
      return ['中餐', '西餐', '日料', '韩料', '泰餐', '意餐', '法餐', '甜品', '饮品', '小吃'];
    }
  }

  /// 批量添加用户喜好食物
  Future<List<FoodPreference>> addMultiplePreferences({
    required int userId,
    required List<String> foodNames,
    String? category,
  }) async {
    final List<FoodPreference> preferences = [];

    for (final foodName in foodNames) {
      final preference = await addPreference(
        userId: userId,
        foodName: foodName,
        category: category,
      );
      preferences.add(preference);
    }

    return preferences;
  }
}
