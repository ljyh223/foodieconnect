import '../../data/models/review_model.dart';
import '../../data/models/restaurant_model.dart';
import '../../features/review/review_repository.dart';
import 'dart:developer' as logger;

class ReviewService {
  static final ReviewRepository _reviewRepository = ReviewRepository();

  /// 获取餐厅评论列表
  static Future<List<Review>> listByRestaurant(String restaurantId, {int page = 0, int size = 20}) async {
    try {
      return await _reviewRepository.getRestaurantReviews(restaurantId, page: page, size: size);
    } catch (e) {
      logger.log('获取餐厅评论失败: $e');
      return <Review>[];
    }
  }

  /// 发布评论
  static Future<Review> post(String restaurantId, int rating, String comment) async {
    try {
      return await _reviewRepository.postReview(restaurantId, rating, comment);
    } catch (e) {
      logger.log('发布评论失败: $e');
      rethrow;
    }
  }

  /// 发布带图片的评论
  static Future<Review> postWithImages(String restaurantId, int rating, String comment, List<String> imageUrls) async {
    try {
      return await _reviewRepository.postReviewWithImages(restaurantId, rating, comment, imageUrls);
    } catch (e) {
      logger.log('发布带图片评论失败: $e');
      rethrow;
    }
  }

  /// 发布带图片的评论 (暂不支持文件上传，需要单独实现)
  static Future<Review> postWithImageFiles(String restaurantId, int rating, String comment, List<dynamic> imageFiles) async {
    // 注意：这里的实现需要根据实际情况调整，可能需要先上传图片获取URL
    // 目前简单处理，直接调用postWithImages，imageUrls为空
    return await postWithImages(restaurantId, rating, comment, []);
  }

  /// 获取用户的评价列表
  static Future<List<Review>> getUserReviews(int userId, {int page = 0, int size = 20}) async {
    try {
      final result = await _reviewRepository.getUserReviews(userId, page: page, size: size);
      logger.log('获取用户评价成功，数量: ${result.length}');
      return result;
    } catch (e) {
      logger.log('获取用户评价失败: $e');
      return [];
    }
  }

  /// 根据用户评价获取推荐餐厅（高分评价）
  static Future<List<Restaurant>> getRecommendedRestaurants(int userId, {double minRating = 4.0}) async {
    try {
      final result = await _reviewRepository.getRecommendedRestaurants(userId, minRating: minRating);
      logger.log('获取推荐餐厅成功，数量: ${result.length}');
      return result;
    } catch (e) {
      logger.log('获取推荐餐厅失败: $e');
      return [];
    }
  }

  /// 获取用户对特定餐厅的评价
  static Future<Review?> getUserReviewForRestaurant(int userId, int restaurantId) async {
    try {
      final result = await _reviewRepository.getUserReviewForRestaurant(userId, restaurantId);
      if (result != null) {
        logger.log('获取用户餐厅评价成功: $userId -> $restaurantId');
      }
      return result;
    } catch (e) {
      logger.log('获取用户餐厅评价失败: $e');
      return null;
    }
  }

  /// 获取用户的评价统计信息
  static Future<Map<String, dynamic>> getUserReviewStats(int userId) async {
    try {
      final result = await _reviewRepository.getUserReviewStats(userId);
      logger.log('获取用户评价统计成功: $result');
      return result;
    } catch (e) {
      logger.log('获取用户评价统计失败: $e');
      // 如果API调用失败，返回默认值
      return {
        'totalReviews': 0,
        'averageRating': 0.0,
        'highRatingCount': 0,
        'restaurantCount': 0,
      };
    }
  }
}