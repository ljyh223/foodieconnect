import '../../network/dio_client.dart';
import '../../data/models/dish_review_model.dart';

/// 菜品评价 API 类
class DishReviewApi {
  /// 获取菜品评价列表
  static Future<List<DishReview>> getDishReviews(
    String restaurantId,
    String menuItemId, {
    int page = 0,
    int size = 20,
    String sortBy = 'latest',
  }) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/$menuItemId/reviews';
    final response = await DioClient.dio.get(
      endpoint,
      queryParameters: {
        'page': page,
        'size': size,
        if (sortBy.isNotEmpty) 'sortBy': sortBy,
      },
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<DishReview> reviews = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        reviews = records
            .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        reviews = content
            .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        reviews = data
            .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      reviews = payload
          .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return reviews;
  }

  /// 创建菜品评价
  static Future<DishReview> createDishReview(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
    List<String> images,
  ) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/$menuItemId/reviews';
    final body = {
      'rating': rating,
      'comment': comment,
      if (images.isNotEmpty) 'images': images,
    };

    final response = await DioClient.dio.post(endpoint, data: body);

    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return DishReview.fromJson(payload);
    }
    throw Exception('Failed to create dish review');
  }

  /// 更新菜品评价
  static Future<DishReview> updateDishReview(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
    List<String> images,
  ) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/reviews/$reviewId';
    final body = {
      'rating': rating,
      'comment': comment,
      if (images.isNotEmpty) 'images': images,
    };

    final response = await DioClient.dio.put(endpoint, data: body);

    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return DishReview.fromJson(payload);
    }
    throw Exception('Failed to update dish review');
  }

  /// 删除菜品评价
  static Future<void> deleteDishReview(
    String restaurantId,
    String reviewId,
  ) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/reviews/$reviewId';
    await DioClient.dio.delete(endpoint);
  }

  /// 获取菜品评分统计
  static Future<DishReviewStats> getDishReviewStats(
    String restaurantId,
    String menuItemId,
  ) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/$menuItemId/reviews/stats';
    final response = await DioClient.dio.get(endpoint);

    final data = response.data['data'];
    if (data != null) {
      return DishReviewStats.fromJson(data);
    }
    return DishReviewStats(
      averageRating: 0.0,
      totalReviews: 0,
      ratingDistribution: {},
    );
  }

  /// 检查是否已评价
  static Future<DishReviewCheck> checkUserReviewed(
    String restaurantId,
    String menuItemId,
  ) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/$menuItemId/reviews/check';
    final response = await DioClient.dio.get(endpoint);

    final data = response.data['data'];
    if (data != null) {
      return DishReviewCheck.fromJson(data);
    }
    return DishReviewCheck(hasReviewed: false);
  }

  /// 获取用户的菜品评价
  static Future<List<DishReview>> getMyDishReviews(
    String restaurantId, {
    int page = 0,
    int size = 20,
    String? menuItemId,
  }) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/reviews/my';
    final response = await DioClient.dio.get(
      endpoint,
      queryParameters: {
        'page': page,
        'size': size,
        if (menuItemId != null) 'menuItemId': menuItemId,
      },
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<DishReview> reviews = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        reviews = records
            .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        reviews = content
            .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        reviews = data
            .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      reviews = payload
          .map((e) => DishReview.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return reviews;
  }

  /// 获取菜品评价详情
  static Future<DishReview> getDishReviewDetail(
    String restaurantId,
    String menuItemId,
    String reviewId,
  ) async {
    final endpoint = '/user/restaurants/$restaurantId/menu-items/$menuItemId/reviews/$reviewId';
    final response = await DioClient.dio.get(endpoint);

    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return DishReview.fromJson(payload);
    }
    throw Exception('Failed to get dish review detail');
  }
}
