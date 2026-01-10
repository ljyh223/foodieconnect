import '../../network/dio_client.dart';
import '../../data/models/food_preference_model.dart';

class FoodPreferenceApi {
  /// 获取用户喜好食物列表
  static Future<List<FoodPreference>> getUserPreferences(int userId) async {
    final response = await DioClient.dio.get('/users/$userId/food-preferences');
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => FoodPreference.fromJson(json)).toList();
  }

  /// 添加用户喜好食物
  static Future<FoodPreference> addPreference({
    required int userId,
    required String foodName,
    String? category,
    String? description,
  }) async {
    final body = {
      'userId': userId,
      'foodName': foodName,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
    };

    final response = await DioClient.dio.post(
      '/users/$userId/food-preferences',
      data: body,
    );
    final data = response.data['data'];
    return FoodPreference.fromJson(data);
  }

  /// 更新用户喜好食物
  static Future<FoodPreference> updatePreference({
    required int preferenceId,
    required int userId,
    String? foodName,
    String? category,
    String? description,
  }) async {
    final body = {
      if (foodName != null) 'foodName': foodName,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
    };

    final response = await DioClient.dio.put(
      '/users/$userId/food-preferences/$preferenceId',
      data: body,
    );
    final data = response.data['data'];
    return FoodPreference.fromJson(data);
  }

  /// 删除用户喜好食物
  static Future<void> deletePreference({
    required int preferenceId,
    required int userId,
  }) async {
    await DioClient.dio.delete('/users/$userId/food-preferences/$preferenceId');
  }

  /// 获取所有食物分类
  static Future<List<String>> getFoodCategories() async {
    final response = await DioClient.dio.get('/food-categories');
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((category) => category.toString()).toList();
  }
}
