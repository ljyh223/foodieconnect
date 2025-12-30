import '../../network/dio_client.dart';
import '../../data/models/user_recommendation_model.dart';

/// 推荐API层，处理与服务器的直接通信
class RecommendationApi {
  /// 获取用户推荐列表
  static Future<List<UserRecommendation>> getUserRecommendations({
    required RecommendationAlgorithm algorithm,
    required int limit,
  }) async {
    final response = await DioClient.dio.get(
      '/api/user-recommendations',
      queryParameters: {
        'algorithm': algorithm.name.toUpperCase(),
        'limit': limit.toString(),
      },
    );

    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => UserRecommendation.fromJson(json)).toList();
  }

  /// 分页获取用户推荐列表
  static Future<List<UserRecommendation>> getUserRecommendationsPaginated({
    required int page,
    required int size,
  }) async {
    final response = await DioClient.dio.get(
      '/api/user-recommendations/paginated',
      queryParameters: {'page': page.toString(), 'size': size.toString()},
    );

    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => UserRecommendation.fromJson(json)).toList();
  }

  /// 获取推荐详情
  static Future<UserRecommendation> getRecommendationDetail(
    int recommendationId,
  ) async {
    final response = await DioClient.dio.get(
      '/api/user-recommendations/$recommendationId',
    );
    return UserRecommendation.fromJson(response.data['data']);
  }

  /// 标记推荐状态
  static Future<void> markRecommendationStatus({
    required int recommendationId,
    required RecommendationStatus status,
  }) async {
    await DioClient.dio.put(
      '/api/user-recommendations/$recommendationId/status',
      data: {'status': status.name},
    );
  }

  /// 标记多个推荐为已查看
  static Future<void> batchMarkAsViewed(List<int> recommendationIds) async {
    await DioClient.dio.put(
      '/api/user-recommendations/batch-viewed',
      data: {'recommendationIds': recommendationIds},
    );
  }

  /// 获取未查看的推荐
  static Future<List<UserRecommendation>> getUnviewedRecommendations() async {
    final response = await DioClient.dio.get(
      '/api/user-recommendations/unviewed',
    );
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => UserRecommendation.fromJson(json)).toList();
  }

  /// 获取推荐统计信息
  static Future<RecommendationStats> getRecommendationStats() async {
    final response = await DioClient.dio.get('/api/user-recommendations/stats');
    return RecommendationStats.fromJson(response.data['data']);
  }

  /// 获取算法统计信息
  static Future<Map<String, dynamic>> getAlgorithmStats() async {
    final response = await DioClient.dio.get(
      '/api/user-recommendations/algorithm-stats',
    );
    return response.data['data'] ?? {};
  }

  /// 获取全局算法统计信息
  static Future<Map<String, dynamic>> getGlobalAlgorithmStats() async {
    final response = await DioClient.dio.get(
      '/api/user-recommendations/global-algorithm-stats',
    );
    return response.data['data'] ?? {};
  }

  /// 删除推荐记录
  static Future<void> deleteRecommendation(int recommendationId) async {
    await DioClient.dio.delete('/api/user-recommendations/$recommendationId');
  }

  /// 清除所有推荐
  static Future<void> clearAllRecommendations() async {
    await DioClient.dio.delete('/api/user-recommendations/clear');
  }

  /// 清除过期推荐
  static Future<void> clearExpiredRecommendations() async {
    await DioClient.dio.delete('/api/user-recommendations/cleanup-expired');
  }

  /// 预热推荐缓存
  static Future<void> warmupRecommendationCache() async {
    await DioClient.dio.post('/api/user-recommendations/warmup-cache');
  }
}
