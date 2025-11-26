import 'dart:developer' as logger;
import 'api_service.dart';
import '../../data/models/user_recommendation_model.dart';

/// 推荐服务类
class RecommendationService {
  static final ApiService _apiService = ApiService();

  /// 获取用户推荐列表
  ///
  /// [algorithm] 推荐算法类型：weighted, switching, cascade
  /// [limit] 推荐数量限制，默认10，最大50
  static Future<List<UserRecommendation>> getUserRecommendations({
    RecommendationAlgorithm algorithm = RecommendationAlgorithm.weighted,
    int limit = 10,
  }) async {
    try {
      final queryParams = {
        'algorithm': algorithm.name.toUpperCase(),
        'limit': limit.toString(),
      };

      final response = await _apiService.get(
        '/api/user-recommendations',
        queryParams: queryParams,
      );
      
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('获取用户推荐成功，数量: ${data.length}');
      
      return data.map((json) => UserRecommendation.fromJson(json)).toList();
    } catch (e) {
      logger.log('获取用户推荐失败: $e');
      String errorMessage = '获取用户推荐失败';
      
      // 根据错误类型提供更具体的错误信息
      if (e.toString().contains('SocketException')) {
        errorMessage = '网络连接失败，请检查网络设置';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = '请求超时，请稍后重试';
      } else if (e.toString().contains('401')) {
        errorMessage = '身份验证失败，请重新登录';
      } else if (e.toString().contains('403')) {
        errorMessage = '没有权限访问推荐数据';
      } else if (e.toString().contains('404')) {
        errorMessage = '推荐服务不可用';
      } else if (e.toString().contains('500')) {
        errorMessage = '服务器内部错误，请稍后重试';
      }
      
      throw Exception(errorMessage);
    }
  }

  /// 分页获取用户推荐列表
  /// 
  /// [page] 页码，从0开始
  /// [size] 每页大小，默认10，最大20
  static Future<List<UserRecommendation>> getUserRecommendationsPaginated({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        'size': size.toString(),
      };

      final response = await _apiService.get(
        '/api/user-recommendations/paginated',
        queryParams: queryParams,
      );
      
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('分页获取用户推荐成功，页码: $page, 数量: ${data.length}');
      
      return data.map((json) => UserRecommendation.fromJson(json)).toList();
    } catch (e) {
      logger.log('分页获取用户推荐失败: $e');
      String errorMessage = '分页获取用户推荐失败';
      
      // 根据错误类型提供更具体的错误信息
      if (e.toString().contains('SocketException')) {
        errorMessage = '网络连接失败，请检查网络设置';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = '请求超时，请稍后重试';
      } else if (e.toString().contains('401')) {
        errorMessage = '身份验证失败，请重新登录';
      } else if (e.toString().contains('403')) {
        errorMessage = '没有权限访问推荐数据';
      } else if (e.toString().contains('404')) {
        errorMessage = '推荐服务不可用';
      } else if (e.toString().contains('500')) {
        errorMessage = '服务器内部错误，请稍后重试';
      }
      
      throw Exception(errorMessage);
    }
  }

  /// 获取推荐详情
  /// 
  /// [recommendationId] 推荐ID
  static Future<UserRecommendation> getRecommendationDetail(int recommendationId) async {
    try {
      final response = await _apiService.get('/api/user-recommendations/$recommendationId');
      final data = response['data'];
      
      logger.log('获取推荐详情成功: $recommendationId');
      
      return UserRecommendation.fromJson(data);
    } catch (e) {
      logger.log('获取推荐详情失败: $e');
      String errorMessage = '获取推荐详情失败';
      
      // 根据错误类型提供更具体的错误信息
      if (e.toString().contains('SocketException')) {
        errorMessage = '网络连接失败，请检查网络设置';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = '请求超时，请稍后重试';
      } else if (e.toString().contains('401')) {
        errorMessage = '身份验证失败，请重新登录';
      } else if (e.toString().contains('403')) {
        errorMessage = '没有权限访问推荐数据';
      } else if (e.toString().contains('404')) {
        errorMessage = '推荐不存在';
      } else if (e.toString().contains('500')) {
        errorMessage = '服务器内部错误，请稍后重试';
      }
      
      throw Exception(errorMessage);
    }
  }

  /// 标记推荐状态
  /// 
  /// [recommendationId] 推荐ID
  /// [status] 推荐状态
  static Future<bool> markRecommendationStatus({
    required int recommendationId,
    required RecommendationStatus status,
  }) async {
    try {
      final request = RecommendationStatusRequest(status: status);
      
      await _apiService.put(
        '/api/user-recommendations/$recommendationId/status',
        body: request.toJson(),
      );
      
      logger.log('标记推荐状态成功: $recommendationId -> ${status.name}');
      
      return true;
    } catch (e) {
      logger.log('标记推荐状态失败: $e');
      String errorMessage = '标记推荐状态失败';
      
      // 根据错误类型提供更具体的错误信息
      if (e.toString().contains('SocketException')) {
        errorMessage = '网络连接失败，请检查网络设置';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = '请求超时，请稍后重试';
      } else if (e.toString().contains('401')) {
        errorMessage = '身份验证失败，请重新登录';
      } else if (e.toString().contains('403')) {
        errorMessage = '没有权限修改推荐状态';
      } else if (e.toString().contains('404')) {
        errorMessage = '推荐不存在';
      } else if (e.toString().contains('500')) {
        errorMessage = '服务器内部错误，请稍后重试';
      }
      
      throw Exception(errorMessage);
    }
  }

  /// 批量标记为已查看
  /// 
  /// [recommendationIds] 推荐ID列表
  static Future<bool> batchMarkAsViewed(List<int> recommendationIds) async {
    try {
      final request = BatchViewedRequest(recommendationIds: recommendationIds);
      
      await _apiService.put(
        '/api/user-recommendations/batch-viewed',
        body: request.toJson(),
      );
      
      logger.log('批量标记已查看成功，数量: ${recommendationIds.length}');
      
      return true;
    } catch (e) {
      logger.log('批量标记已查看失败: $e');
      String errorMessage = '批量标记已查看失败';
      
      // 根据错误类型提供更具体的错误信息
      if (e.toString().contains('SocketException')) {
        errorMessage = '网络连接失败，请检查网络设置';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = '请求超时，请稍后重试';
      } else if (e.toString().contains('401')) {
        errorMessage = '身份验证失败，请重新登录';
      } else if (e.toString().contains('403')) {
        errorMessage = '没有权限修改推荐状态';
      } else if (e.toString().contains('500')) {
        errorMessage = '服务器内部错误，请稍后重试';
      }
      
      throw Exception(errorMessage);
    }
  }

  /// 获取未查看的推荐
  static Future<List<UserRecommendation>> getUnviewedRecommendations() async {
    try {
      final response = await _apiService.get('/api/user-recommendations/unviewed');
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('获取未查看推荐成功，数量: ${data.length}');
      
      return data.map((json) => UserRecommendation.fromJson(json)).toList();
    } catch (e) {
      logger.log('获取未查看推荐失败: $e');
      throw Exception('获取未查看推荐失败: $e');
    }
  }

  /// 获取推荐统计信息
  static Future<RecommendationStats> getRecommendationStats() async {
    try {
      final response = await _apiService.get('/api/user-recommendations/stats');
      final data = response['data'];
      
      logger.log('获取推荐统计成功');
      
      return RecommendationStats.fromJson(data);
    } catch (e) {
      logger.log('获取推荐统计失败: $e');
      throw Exception('获取推荐统计失败: $e');
    }
  }

  /// 获取算法统计信息
  static Future<Map<String, dynamic>> getAlgorithmStats() async {
    try {
      final response = await _apiService.get('/api/user-recommendations/algorithm-stats');
      final data = response['data'] ?? {};
      
      logger.log('获取算法统计成功');
      
      return data;
    } catch (e) {
      logger.log('获取算法统计失败: $e');
      throw Exception('获取算法统计失败: $e');
    }
  }

  /// 获取全局算法统计信息
  static Future<Map<String, dynamic>> getGlobalAlgorithmStats() async {
    try {
      final response = await _apiService.get('/api/user-recommendations/global-algorithm-stats');
      final data = response['data'] ?? {};
      
      logger.log('获取全局算法统计成功');
      
      return data;
    } catch (e) {
      logger.log('获取全局算法统计失败: $e');
      throw Exception('获取全局算法统计失败: $e');
    }
  }

  /// 删除推荐记录
  /// 
  /// [recommendationId] 推荐ID
  static Future<bool> deleteRecommendation(int recommendationId) async {
    try {
      await _apiService.delete('/api/user-recommendations/$recommendationId');
      
      logger.log('删除推荐成功: $recommendationId');
      
      return true;
    } catch (e) {
      logger.log('删除推荐失败: $e');
      throw Exception('删除推荐失败: $e');
    }
  }

  /// 清除所有推荐
  static Future<bool> clearAllRecommendations() async {
    try {
      await _apiService.delete('/api/user-recommendations/clear');
      
      logger.log('清除所有推荐成功');
      
      return true;
    } catch (e) {
      logger.log('清除所有推荐失败: $e');
      throw Exception('清除所有推荐失败: $e');
    }
  }

  /// 清除过期推荐
  static Future<bool> clearExpiredRecommendations() async {
    try {
      await _apiService.delete('/api/user-recommendations/cleanup-expired');
      
      logger.log('清除过期推荐成功');
      
      return true;
    } catch (e) {
      logger.log('清除过期推荐失败: $e');
      throw Exception('清除过期推荐失败: $e');
    }
  }

  /// 预热推荐缓存
  static Future<bool> warmupRecommendationCache() async {
    try {
      await _apiService.post('/api/user-recommendations/warmup-cache');
      
      logger.log('预热推荐缓存成功');
      
      return true;
    } catch (e) {
      logger.log('预热推荐缓存失败: $e');
      throw Exception('预热推荐缓存失败: $e');
    }
  }

  /// 便捷方法：标记为感兴趣
  static Future<bool> markAsInterested(int recommendationId) async {
    return markRecommendationStatus(
      recommendationId: recommendationId,
      status: RecommendationStatus.interested,
    );
  }

  /// 便捷方法：标记为不感兴趣
  static Future<bool> markAsNotInterested(int recommendationId) async {
    return markRecommendationStatus(
      recommendationId: recommendationId,
      status: RecommendationStatus.notInterested,
    );
  }

  /// 便捷方法：标记为已查看
  static Future<bool> markAsViewed(int recommendationId) async {
    return markRecommendationStatus(
      recommendationId: recommendationId,
      status: RecommendationStatus.viewed,
    );
  }
}