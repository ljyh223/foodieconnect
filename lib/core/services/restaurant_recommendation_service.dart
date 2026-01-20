import '../../data/models/recommendation_model.dart';
import '../../features/restaurant_recommendation/restaurant_recommendation_repository.dart';
import 'dart:developer' as logger;

/// 餐厅推荐服务类
class RestaurantRecommendationService {
  static final RestaurantRecommendationRepository _repository =
      RestaurantRecommendationRepository();

  /// 推荐餐厅
  static Future<Map<String, dynamic>> recommendRestaurant({
    required String restaurantId,
    String? comment,
    int? rating,
  }) async {
    try {
      final result = await _repository.recommendRestaurant(
        restaurantId: restaurantId,
        comment: comment,
        rating: rating,
      );
      logger.log('推荐餐厅成功');
      return result;
    } catch (e) {
      logger.log('推荐餐厅失败: $e');
      throw Exception('推荐餐厅失败: $e');
    }
  }

  /// 获取我的推荐餐厅列表
  static Future<List<RecommendationWithRestaurant>>
  getMyRecommendations() async {
    try {
      final result =
          await RestaurantRecommendationRepository.getMyRecommendations();
      logger.log('获取我的推荐列表成功，数量: ${result.length}');
      return result;
    } catch (e) {
      logger.log('获取我的推荐列表失败: $e');
      return [];
    }
  }

  /// 获取用户的推荐餐厅列表
  static Future<List<RecommendationWithRestaurant>> getUserRecommendations(
    int userId,
  ) async {
    try {
      final result =
          await RestaurantRecommendationRepository.getUserRecommendations(
            userId,
          );
      logger.log('获取用户推荐列表成功，数量: ${result.length}');
      return result;
    } catch (e) {
      logger.log('获取用户推荐列表失败: $e');
      return [];
    }
  }

  /// 删除推荐
  static Future<void> deleteRecommendation(int recommendationId) async {
    try {
      await _repository.deleteRecommendation(recommendationId);
      logger.log('删除推荐成功');
    } catch (e) {
      logger.log('删除推荐失败: $e');
      throw Exception('删除推荐失败: $e');
    }
  }
}
