import '../../core/errors/api_error.dart';
import '../../data/models/review_model.dart';
import '../../data/models/restaurant_model.dart';
import 'review_api.dart';

class ReviewRepository {
  /// 获取餐厅评论列表
  Future<List<Review>> getRestaurantReviews(
    String restaurantId, {
    int page = 0,
    int size = 20,
  }) async {
    try {
      return await ReviewApi.getRestaurantReviews(
        restaurantId,
        page: page,
        size: size,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 发布评论
  Future<Review> postReview(
    String restaurantId,
    int rating,
    String comment,
  ) async {
    try {
      return await ReviewApi.postReview(restaurantId, rating, comment);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 发布带图片的评论
  Future<Review> postReviewWithImages(
    String restaurantId,
    int rating,
    String comment,
    List<String> imageUrls,
  ) async {
    try {
      return await ReviewApi.postReviewWithImages(
        restaurantId,
        rating,
        comment,
        imageUrls,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取用户的评价列表
  Future<List<Review>> getUserReviews(
    int userId, {
    int page = 0,
    int size = 20,
  }) async {
    try {
      return await ReviewApi.getUserReviews(userId, page: page, size: size);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取用户对特定餐厅的评价
  Future<Review?> getUserReviewForRestaurant(
    int userId,
    int restaurantId,
  ) async {
    try {
      return await ReviewApi.getUserReviewForRestaurant(userId, restaurantId);
    } catch (e) {
      // 如果获取失败，返回null，不抛出异常
      return null;
    }
  }

  /// 获取用户评价统计信息
  Future<Map<String, dynamic>> getUserReviewStats(int userId) async {
    try {
      return await ReviewApi.getUserReviewStats(userId);
    } catch (e) {
      // 如果获取失败，返回默认值
      return {
        'totalReviews': 0,
        'averageRating': 0.0,
        'highRatingCount': 0,
        'restaurantCount': 0,
      };
    }
  }

  /// 根据用户评价获取推荐餐厅（高分评价）
  Future<List<Restaurant>> getRecommendedRestaurants(
    int userId, {
    double minRating = 4.0,
  }) async {
    try {
      // 获取用户的所有评价
      final reviews = await getUserReviews(userId, size: 100);

      // 筛选高分评价
      final highRatingReviews = reviews
          .where((review) => review.rating >= minRating)
          .toList();

      // 按评分分组，获取每个餐厅的最高分评价
      final Map<int, Review> bestReviewsByRestaurant = {};
      for (final review in highRatingReviews) {
        final restaurantId = review.restaurantId;
        if (!bestReviewsByRestaurant.containsKey(restaurantId) ||
            review.rating > bestReviewsByRestaurant[restaurantId]!.rating) {
          bestReviewsByRestaurant[restaurantId] = review;
        }
      }

      // 按评分排序
      final sortedReviews = bestReviewsByRestaurant.values.toList()
        ..sort((a, b) => b.rating.compareTo(a.rating));

      // 获取餐厅详细信息
      final List<Restaurant> recommendedRestaurants = [];
      for (final review in sortedReviews.take(10)) {
        // 最多推荐10个餐厅
        try {
          final restaurant = await ReviewApi.getRestaurant(review.restaurantId);
          recommendedRestaurants.add(restaurant);
        } catch (e) {
          // 单个餐厅获取失败，继续获取其他餐厅
          continue;
        }
      }

      return recommendedRestaurants;
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }
}
