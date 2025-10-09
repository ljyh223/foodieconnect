import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/review_model.dart';

class ReviewService {
  static final ApiService _api = ApiService();

  /// 获取餐厅评论列表
  static Future<List<Review>> listByRestaurant(String restaurantId, {int page = 0, int size = 20}) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final res = await _api.get(endpoint, queryParams: {'page': page.toString(), 'size': size.toString()});
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final content = payload['content'] as List<dynamic>? ?? [];
      return content.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) {
      return payload.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
    }
    return <Review>[];
  }

  /// 发布评论
  static Future<Review> post(String restaurantId, int rating, String comment) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final body = {'rating': rating, 'comment': comment};
    final res = await _api.post(endpoint, body: body);
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return Review.fromJson(payload);
    throw Exception('发布评论失败');
  }
}
