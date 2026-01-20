import '../../network/dio_client.dart';

/// 餐厅推荐API层，处理与服务器的直接通信
class RestaurantRecommendationApi {
  /// 推荐餐厅
  static Future<Map<String, dynamic>> recommendRestaurant({
    required String restaurantId,
    String? comment,
    int? rating,
  }) async {
    final response = await DioClient.dio.post(
      '/api/recommendations',
      data: {
        'restaurantId': restaurantId,
        if (comment != null) 'comment': comment,
        if (rating != null) 'rating': rating,
      },
    );
    return response.data;
  }

  /// 获取我的推荐列表
  static Future<List<Map<String, dynamic>>> getMyRecommendations() async {
    final response = await DioClient.dio.get('/api/recommendations/my');
    final data = response.data;

    if (data is Map && data['data'] != null) {
      final Map<String, dynamic> dataMap = data['data'];
      if (dataMap['records'] != null) {
        final List<dynamic> records = dataMap['records'];
        return records.cast<Map<String, dynamic>>();
      }
    }

    return [];
  }

  /// 获取用户的推荐列表
  static Future<List<Map<String, dynamic>>> getUserRecommendations(
    int userId,
  ) async {
    final response = await DioClient.dio.get(
      '/api/recommendations/user/$userId',
    );
    final data = response.data;

    if (data is Map && data['data'] != null) {
      final Map<String, dynamic> dataMap = data['data'];
      if (dataMap['records'] != null) {
        final List<dynamic> records = dataMap['records'];
        return records.cast<Map<String, dynamic>>();
      }
    }

    return [];
  }

  /// 删除推荐
  static Future<void> deleteRecommendation(int recommendationId) async {
    await DioClient.dio.delete('/api/recommendations/$recommendationId');
  }
}
