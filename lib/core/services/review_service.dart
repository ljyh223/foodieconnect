import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/review_model.dart';
import '../../data/models/restaurant_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:developer' as logger;

class ReviewService {
  static final ApiService _api = ApiService();

  /// 获取餐厅评论列表
  static Future<List<Review>> listByRestaurant(String restaurantId, {int page = 0, int size = 20}) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final res = await _api.get(
      endpoint,
      queryParams: {'page': page.toString(), 'size': size.toString()},
      requireAuth: false, // 获取评论列表不需要认证
    );
    final dynamic payload = res['data'] ?? res;
    
    // 调试输出，帮助分析数据结构
    debugPrint('ReviewService API Response: $payload');
    
    if (payload is Map<String, dynamic>) {
      // 检查是否有records字段（分页结构）
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        debugPrint('Found ${records.length} reviews in records field');
        return records.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
      // 检查是否有content字段
      else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        debugPrint('Found ${content.length} reviews in content field');
        return content.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
      // 直接是数组
      else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        debugPrint('Found ${data.length} reviews in data field');
        return data.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
    }
    if (payload is List) {
      debugPrint('Found ${payload.length} reviews in payload list');
      return payload.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    debugPrint('No reviews found, returning empty list');
    return <Review>[];
  }

  /// 发布评论
  static Future<Review> post(String restaurantId, int rating, String comment) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final body = {'rating': rating, 'comment': comment};
    final res = await _api.post(
      endpoint,
      body: body,
      requireAuth: true, // 发布评论需要认证
    );
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return Review.fromJson(payload);
    throw Exception('Comment failed to post');
  }

  /// 发布带图片的评论
  static Future<Review> postWithImages(String restaurantId, int rating, String comment, List<String> imageUrls) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final body = {
      'rating': rating,
      'comment': comment,
      'imageUrls': imageUrls, // 图片URL列表，多个URL用逗号分隔
    };
    final res = await _api.post(
      endpoint,
      body: body,
      requireAuth: true, // 发布带图片评论需要认证
    );
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return Review.fromJson(payload);
    throw Exception('Comment failed to post');
  }

  /// 上传图片并发布评论
  static Future<Review> postWithImageFiles(String restaurantId, int rating, String comment, List<File> imageFiles) async {
    List<String> imageUrls = [];
    
    // 如果有图片，先上传图片
    if (imageFiles.isNotEmpty) {
      imageUrls = await _api.uploadImagesAndGetUrls(imageFiles);
    }
    
    // 发布带图片URL的评论
    return postWithImages(restaurantId, rating, comment, imageUrls);
  }

  /// 获取用户的评价列表
  static Future<List<Review>> getUserReviews(int userId, {int page = 0, int size = 20}) async {
    try {
      final res = await _api.get(
        '/users/$userId/reviews',
        queryParams: {
          'page': page.toString(),
          'size': size.toString(),
        },
        requireAuth: true, // 获取用户评价需要认证
      );
      
      final dynamic payload = res['data'] ?? res;
      List<Review> reviews = [];
      
      if (payload is Map<String, dynamic>) {
        // 检查是否有records字段（分页结构）
        if (payload.containsKey('records')) {
          final records = payload['records'] as List<dynamic>? ?? [];
          reviews = records.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
        }
        // 检查是否有content字段
        else if (payload.containsKey('content')) {
          final content = payload['content'] as List<dynamic>? ?? [];
          reviews = content.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
        }
        // 直接是数组
        else if (payload['data'] is List) {
          final data = payload['data'] as List<dynamic>? ?? [];
          reviews = data.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
        }
      } else if (payload is List) {
        reviews = payload.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
      
      logger.log('获取用户评价成功，数量: ${reviews.length}');
      return reviews;
    } catch (e) {
      logger.log('获取用户评价失败: $e');
      return [];
    }
  }

  /// 根据用户评价获取推荐餐厅（高分评价）
  static Future<List<Restaurant>> getRecommendedRestaurants(int userId, {double minRating = 4.0}) async {
    try {
      // 获取用户的所有评价
      final reviews = await getUserReviews(userId, size: 100); // 获取更多评价
      
      // 筛选高分评价
      final highRatingReviews = reviews.where((review) => review.rating >= minRating).toList();
      
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
      for (final review in sortedReviews.take(10)) { // 最多推荐10个餐厅
        try {
          final restaurantRes = await _api.get(
            '/restaurants/${review.restaurantId}',
            requireAuth: false, // 获取餐厅详情不需要认证
          );
          final restaurantData = restaurantRes['data'];
          if (restaurantData != null) {
            final restaurant = Restaurant.fromJson(restaurantData);
            recommendedRestaurants.add(restaurant);
          }
        } catch (e) {
          logger.log('获取餐厅详情失败，ID: ${review.restaurantId}, 错误: $e');
        }
      }
      
      logger.log('获取推荐餐厅成功，数量: ${recommendedRestaurants.length}');
      return recommendedRestaurants;
    } catch (e) {
      logger.log('获取推荐餐厅失败: $e');
      return [];
    }
  }

  /// 获取用户对特定餐厅的评价
  static Future<Review?> getUserReviewForRestaurant(int userId, int restaurantId) async {
    try {
      final res = await _api.get(
        '/restaurants/$restaurantId/reviews/user/$userId',
        requireAuth: true, // 获取用户对特定餐厅的评价需要认证
      );
      final data = res['data'];
      
      if (data != null) {
        logger.log('获取用户餐厅评价成功: $userId -> $restaurantId');
        return Review.fromJson(data);
      }
      
      return null;
    } catch (e) {
      logger.log('获取用户餐厅评价失败: $e');
      return null;
    }
  }

  /// 获取用户的评价统计信息
  static Future<Map<String, dynamic>> getUserReviewStats(int userId) async {
    try {
      final res = await _api.get(
        '/users/$userId/reviews/stats',
        requireAuth: true, // 获取评价统计需要认证
      );
      final data = res['data'] ?? {};
      
      final stats = {
        'totalReviews': data['totalReviews'] ?? 0,
        'averageRating': data['averageRating']?.toDouble() ?? 0.0,
        'highRatingCount': data['highRatingCount'] ?? 0,
        'restaurantCount': data['restaurantCount'] ?? 0,
      };
      
      logger.log('获取用户评价统计成功: $stats');
      return stats;
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
