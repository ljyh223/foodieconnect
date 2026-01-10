import '../../network/dio_client.dart';
import '../../data/models/review_model.dart';
import '../../data/models/restaurant_model.dart';

class ReviewApi {
  /// 获取餐厅评论列表
  static Future<List<Review>> getRestaurantReviews(
    String restaurantId, {
    int page = 0,
    int size = 20,
  }) async {
    final endpoint = '/restaurants/$restaurantId/reviews';
    final response = await DioClient.dio.get(
      endpoint,
      queryParameters: {'page': page, 'size': size},
    );

    final dynamic payload = response.data['data'] ?? response.data;

    List<Review> reviews = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        reviews = records
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        reviews = content
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        reviews = data
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      reviews = payload
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return reviews;
  }

  /// 发布评论
  static Future<Review> postReview(
    String restaurantId,
    int rating,
    String comment,
  ) async {
    final endpoint = '/restaurants/$restaurantId/reviews';
    final body = {'rating': rating, 'comment': comment};

    final response = await DioClient.dio.post(endpoint, data: body);

    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return Review.fromJson(payload);
    }
    throw Exception('Failed to post review');
  }

  /// 发布带图片的评论
  static Future<Review> postReviewWithImages(
    String restaurantId,
    int rating,
    String comment,
    List<String> imageUrls,
  ) async {
    final endpoint = '/restaurants/$restaurantId/reviews';
    final body = {'rating': rating, 'comment': comment, 'imageUrls': imageUrls};

    final response = await DioClient.dio.post(endpoint, data: body);

    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return Review.fromJson(payload);
    }
    throw Exception('Failed to post review with images');
  }

  /// 获取用户的评价列表
  static Future<List<Review>> getUserReviews(
    int userId, {
    int page = 0,
    int size = 20,
  }) async {
    final response = await DioClient.dio.get(
      '/users/$userId/reviews',
      queryParameters: {'page': page, 'size': size},
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<Review> reviews = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        reviews = records
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        reviews = content
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        reviews = data
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      reviews = payload
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return reviews;
  }

  /// 获取用户对特定餐厅的评价
  static Future<Review?> getUserReviewForRestaurant(
    int userId,
    int restaurantId,
  ) async {
    final response = await DioClient.dio.get(
      '/restaurants/$restaurantId/reviews/user/$userId',
    );

    final data = response.data['data'];
    if (data != null) {
      return Review.fromJson(data);
    }
    return null;
  }

  /// 获取用户评价统计信息
  static Future<Map<String, dynamic>> getUserReviewStats(int userId) async {
    final response = await DioClient.dio.get('/users/$userId/reviews/stats');

    final data = response.data['data'] ?? {};
    return {
      'totalReviews': data['totalReviews'] ?? 0,
      'averageRating': data['averageRating']?.toDouble() ?? 0.0,
      'highRatingCount': data['highRatingCount'] ?? 0,
      'restaurantCount': data['restaurantCount'] ?? 0,
    };
  }

  /// 获取餐厅详情
  static Future<Restaurant> getRestaurant(int restaurantId) async {
    final response = await DioClient.dio.get('/restaurants/$restaurantId');
    return Restaurant.fromJson(response.data['data']);
  }
}
