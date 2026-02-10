import 'package:flutter/foundation.dart';
import '../../data/models/user_recommendation_model.dart';
import '../../core/services/recommendation_service.dart';
import 'dart:developer' as logger;

/// 推荐状态管理Provider
class RecommendationProvider with ChangeNotifier {
  List<UserRecommendation> _recommendations = [];
  bool _isLoading = false;
  String? _error;
  bool _hasMore = true;
  int _currentPage = 0;
  final int _pageSize = 10;

  // 缓存相关
  DateTime? _lastFetchTime;
  static const Duration _cacheTimeout = Duration(minutes: 30);

  // 筛选和排序状态
  RecommendationStatus? _filterStatus;
  String _sortBy = 'score';

  /// 获取推荐列表
  List<UserRecommendation> get recommendations =>
      List.unmodifiable(_recommendations);

  /// 是否正在加载
  bool get isLoading => _isLoading;

  /// 错误信息
  String? get error => _error;

  /// 是否还有更多数据
  bool get hasMore => _hasMore;

  /// 获取未查看的推荐数量
  int get unviewedCount => _recommendations
      .where((r) => r.status == RecommendationStatus.unviewed)
      .length;

  /// 获取感兴趣的推荐数量
  int get interestedCount => _recommendations
      .where((r) => r.status == RecommendationStatus.interested)
      .length;

  /// 获取高推荐度用户
  List<UserRecommendation> get highRecommendations =>
      _recommendations.where((r) => r.isHighRecommendation).toList();

  /// 获取当前筛选状态
  RecommendationStatus? get filterStatus => _filterStatus;

  /// 获取当前排序方式
  String get sortBy => _sortBy;

  /// 检查缓存是否有效
  bool get _isCacheValid {
    if (_lastFetchTime == null) return false;
    return DateTime.now().difference(_lastFetchTime!) < _cacheTimeout;
  }

  /// 清除错误信息
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// 重置状态
  void reset() {
    _recommendations.clear();
    _isLoading = false;
    _error = null;
    _hasMore = true;
    _currentPage = 0;
    _lastFetchTime = null;
    _filterStatus = null;
    _sortBy = 'score';
    notifyListeners();
  }

  /// 获取首页推荐（3-5个）
  Future<List<UserRecommendation>> getHomeRecommendations({
    int count = 5,
    RecommendationAlgorithm algorithm = RecommendationAlgorithm.weighted,
    bool forceRefresh = false,
  }) async {
    // 如果缓存有效且有数据，直接返回
    if (_isCacheValid && _recommendations.isNotEmpty && !forceRefresh) {
      logger.log('使用推荐缓存数据');
      return _recommendations.take(count).toList();
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      logger.log('开始获取首页推荐，数量: $count');
      final recommendations =
          await RecommendationService.getUserRecommendations(
            algorithm: algorithm,
            limit: count,
          );

      // 更新缓存
      _recommendations = recommendations;
      _lastFetchTime = DateTime.now();
      _isLoading = false;

      logger.log('首页推荐获取成功，数量: ${recommendations.length}');
      notifyListeners();

      return recommendations;
    } catch (e) {
      logger.log('获取首页推荐失败: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return [];
    }
  }

  /// 加载更多推荐
  Future<void> loadMoreRecommendations() async {
    if (!_hasMore || _isLoading) {
      logger.log('加载更多推荐被跳过: hasMore=$_hasMore, isLoading=$_isLoading');
      return;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      logger.log('开始加载更多推荐，页码: $_currentPage');
      final newRecommendations =
          await RecommendationService.getUserRecommendationsPaginated(
            page: _currentPage,
            size: _pageSize,
          );

      if (newRecommendations.isEmpty) {
        _hasMore = false;
        logger.log('没有更多推荐数据');
      } else {
        _recommendations.addAll(newRecommendations);
        _currentPage++;
        logger.log('加载更多推荐成功，新增: ${newRecommendations.length}');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      logger.log('加载更多推荐失败: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 刷新推荐列表
  Future<void> refreshRecommendations() async {
    reset();
    await loadMoreRecommendations();
  }

  /// 标记推荐状态
  Future<bool> markRecommendationStatus({
    required int recommendationId,
    required RecommendationStatus status,
  }) async {
    try {
      logger.log('标记推荐状态: $recommendationId -> ${status.name}');
      await RecommendationService.markRecommendationStatus(
        recommendationId: recommendationId,
        status: status,
      );

      // 更新本地状态
      final index = _recommendations.indexWhere(
        (r) => r.id == recommendationId,
      );
      if (index != -1) {
        _recommendations[index] = _recommendations[index].copyWith(
          status: status,
          viewedAt: status == RecommendationStatus.viewed
              ? DateTime.now()
              : _recommendations[index].viewedAt,
        );
        logger.log('本地推荐状态更新成功: $recommendationId');
        notifyListeners();
      }

      return true;
    } catch (e) {
      logger.log('标记推荐状态失败: $e');
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// 标记为感兴趣
  Future<bool> markAsInterested(int recommendationId) async {
    return markRecommendationStatus(
      recommendationId: recommendationId,
      status: RecommendationStatus.interested,
    );
  }

  /// 标记为不感兴趣
  Future<bool> markAsNotInterested(int recommendationId) async {
    final success = await markRecommendationStatus(
      recommendationId: recommendationId,
      status: RecommendationStatus.notInterested,
    );

    // 从列表中移除该推荐
    if (success) {
      _recommendations.removeWhere((r) => r.recommendationId == recommendationId);
      notifyListeners();
    }

    return success;
  }

  /// 标记为已查看
  Future<bool> markAsViewed(int recommendationId) async {
    return markRecommendationStatus(
      recommendationId: recommendationId,
      status: RecommendationStatus.viewed,
    );
  }

  /// 批量标记为已查看
  Future<bool> batchMarkAsViewed(List<int> recommendationIds) async {
    try {
      await RecommendationService.batchMarkAsViewed(recommendationIds);

      // 更新本地状态
      for (final id in recommendationIds) {
        final index = _recommendations.indexWhere((r) => r.id == id);
        if (index != -1 &&
            _recommendations[index].status == RecommendationStatus.unviewed) {
          _recommendations[index] = _recommendations[index].copyWith(
            status: RecommendationStatus.viewed,
            viewedAt: DateTime.now(),
          );
        }
      }
      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// 获取未查看的推荐
  Future<List<UserRecommendation>> getUnviewedRecommendations() async {
    try {
      return await RecommendationService.getUnviewedRecommendations();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  /// 删除推荐
  Future<bool> deleteRecommendation(int recommendationId) async {
    try {
      await RecommendationService.deleteRecommendation(recommendationId);

      // 从本地列表中移除
      _recommendations.removeWhere((r) => r.id == recommendationId);
      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// 清除所有推荐
  Future<bool> clearAllRecommendations() async {
    try {
      await RecommendationService.clearAllRecommendations();
      reset();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// 预热推荐缓存
  Future<bool> warmupCache() async {
    try {
      await RecommendationService.warmupRecommendationCache();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// 根据状态筛选推荐
  List<UserRecommendation> getRecommendationsByStatus(
    RecommendationStatus status,
  ) {
    return _recommendations.where((r) => r.status == status).toList();
  }

  /// 根据推荐分数筛选
  List<UserRecommendation> getRecommendationsByScore(
    double minScore,
    double maxScore,
  ) {
    return _recommendations
        .where((r) => r.score >= minScore && r.score <= maxScore)
        .toList();
  }

  /// 搜索推荐用户
  List<UserRecommendation> searchRecommendations(String query) {
    if (query.isEmpty) return _recommendations;

    final lowerQuery = query.toLowerCase();
    return _recommendations.where((r) {
      return r.userName.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// 设置筛选状态
  void setFilterStatus(RecommendationStatus? status) {
    _filterStatus = status;
    notifyListeners();
  }

  /// 设置排序方式
  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  /// 获取筛选和排序后的推荐列表
  List<UserRecommendation> get processedRecommendations {
    List<UserRecommendation> filteredRecommendations = List.from(
      _recommendations,
    );

    // 应用筛选
    if (_filterStatus != null) {
      filteredRecommendations = filteredRecommendations
          .where((r) => r.status == _filterStatus)
          .toList();
    }

    // 应用排序
    switch (_sortBy) {
      case 'score':
        filteredRecommendations.sort((a, b) => b.score.compareTo(a.score));
        break;
      case 'createdAt':
        filteredRecommendations.sort((a, b) {
          final aTime = a.createdAt ?? DateTime.now();
          final bTime = b.createdAt ?? DateTime.now();
          return bTime.compareTo(aTime);
        });
        break;
      case 'viewedAt':
        filteredRecommendations.sort((a, b) {
          if (a.viewedAt == null && b.viewedAt == null) return 0;
          if (a.viewedAt == null) return 1;
          if (b.viewedAt == null) return -1;
          return b.viewedAt!.compareTo(a.viewedAt!);
        });
        break;
    }

    return filteredRecommendations;
  }
}
