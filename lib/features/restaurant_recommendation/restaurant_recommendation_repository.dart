import '../../data/models/recommendation_model.dart';
import '../../core/services/restaurant_service.dart';
import 'restaurant_recommendation_api.dart';
import 'dart:developer' as logger;

/// 餐厅推荐仓库类，处理数据逻辑
class RestaurantRecommendationRepository {
  /// 推荐餐厅
  Future<Map<String, dynamic>> recommendRestaurant({
    required String restaurantId,
    String? comment,
    int? rating,
  }) async {
    return await RestaurantRecommendationApi.recommendRestaurant(
      restaurantId: restaurantId,
      comment: comment,
      rating: rating,
    );
  }

  /// 获取我的推荐列表
  static Future<List<RecommendationWithRestaurant>>
  getMyRecommendations() async {
    final recommendationData =
        await RestaurantRecommendationApi.getMyRecommendations();
    final result = <RecommendationWithRestaurant>[];

    for (final data in recommendationData) {
      try {
        final recommendation = RestaurantRecommendation.fromJson(data);
        final restaurant = await RestaurantService.get(
          recommendation.restaurantId.toString(),
        );
        result.add(
          RecommendationWithRestaurant(
            recommendation: recommendation,
            restaurant: restaurant,
          ),
        );
      } catch (e) {
        logger.log('获取餐厅详情失败: ${data['restaurantId']}, $e');
      }
    }

    return result;
  }

  /// 获取用户的推荐列表
  static Future<List<RecommendationWithRestaurant>> getUserRecommendations(
    int userId,
  ) async {
    final recommendationData =
        await RestaurantRecommendationApi.getUserRecommendations(userId);
    final result = <RecommendationWithRestaurant>[];

    for (final data in recommendationData) {
      try {
        final recommendation = RestaurantRecommendation.fromJson(data);
        final restaurant = await RestaurantService.get(
          recommendation.restaurantId.toString(),
        );
        result.add(
          RecommendationWithRestaurant(
            recommendation: recommendation,
            restaurant: restaurant,
          ),
        );
      } catch (e) {
        logger.log('获取餐厅详情失败: ${data['restaurantId']}, $e');
      }
    }

    return result;
  }

  /// 删除推荐
  Future<void> deleteRecommendation(int recommendationId) async {
    return await RestaurantRecommendationApi.deleteRecommendation(
      recommendationId,
    );
  }
}
