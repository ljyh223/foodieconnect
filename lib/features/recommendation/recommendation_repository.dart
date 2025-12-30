import 'package:dio/dio.dart';
import '../../core/errors/api_error.dart';
import '../../data/models/user_recommendation_model.dart';
import 'recommendation_api.dart';

/// 推荐仓库层，封装业务逻辑
class RecommendationRepository {
  /// 获取用户推荐列表
  Future<List<UserRecommendation>> fetchUserRecommendations({
    RecommendationAlgorithm algorithm = RecommendationAlgorithm.weighted,
    int limit = 10,
  }) async {
    try {
      return await RecommendationApi.getUserRecommendations(
        algorithm: algorithm,
        limit: limit,
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 分页获取用户推荐列表
  Future<List<UserRecommendation>> fetchUserRecommendationsPaginated({
    int page = 0,
    int size = 10,
  }) async {
    try {
      return await RecommendationApi.getUserRecommendationsPaginated(
        page: page,
        size: size,
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取推荐详情
  Future<UserRecommendation> fetchRecommendationDetail(
    int recommendationId,
  ) async {
    try {
      return await RecommendationApi.getRecommendationDetail(recommendationId);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 标记推荐状态
  Future<bool> updateRecommendationStatus({
    required int recommendationId,
    required RecommendationStatus status,
  }) async {
    try {
      await RecommendationApi.markRecommendationStatus(
        recommendationId: recommendationId,
        status: status,
      );
      return true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 标记多个推荐为已查看
  Future<bool> batchMarkRecommendationsAsViewed(
    List<int> recommendationIds,
  ) async {
    try {
      await RecommendationApi.batchMarkAsViewed(recommendationIds);
      return true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取未查看的推荐
  Future<List<UserRecommendation>> fetchUnviewedRecommendations() async {
    try {
      return await RecommendationApi.getUnviewedRecommendations();
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取推荐统计信息
  Future<RecommendationStats> fetchRecommendationStats() async {
    try {
      return await RecommendationApi.getRecommendationStats();
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取算法统计信息
  Future<Map<String, dynamic>> fetchAlgorithmStats() async {
    try {
      return await RecommendationApi.getAlgorithmStats();
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取全局算法统计信息
  Future<Map<String, dynamic>> fetchGlobalAlgorithmStats() async {
    try {
      return await RecommendationApi.getGlobalAlgorithmStats();
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 删除推荐记录
  Future<bool> deleteRecommendation(int recommendationId) async {
    try {
      await RecommendationApi.deleteRecommendation(recommendationId);
      return true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 清除所有推荐
  Future<bool> clearAllRecommendations() async {
    try {
      await RecommendationApi.clearAllRecommendations();
      return true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 清除过期推荐
  Future<bool> clearExpiredRecommendations() async {
    try {
      await RecommendationApi.clearExpiredRecommendations();
      return true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 预热推荐缓存
  Future<bool> warmupRecommendationCache() async {
    try {
      await RecommendationApi.warmupRecommendationCache();
      return true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
