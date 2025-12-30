import 'package:freezed_annotation/freezed_annotation.dart';
import 'restaurant_model.dart';

part 'user_recommendation_model.freezed.dart';
part 'user_recommendation_model.g.dart';

/// 推荐状态枚举
enum RecommendationStatus {
  unviewed, // 未查看
  viewed, // 已查看
  interested, // 感兴趣
  notInterested, // 不感兴趣
}

/// 推荐算法类型枚举
enum RecommendationAlgorithm {
  weighted, // 加权推荐
  switching, // 切换推荐
  cascade, // 级联推荐
  hybridWeighted, // 混合加权推荐（API返回值）
}

// API返回的字符串常量
class RecommendationAlgorithmType {
  static const String weighted = 'weighted';
  static const String switching = 'switching';
  static const String cascade = 'cascade';
  static const String hybridWeighted = 'hybrid_weighted';
}

/// 用户推荐模型 - 根据API返回数据结构更新
@freezed
@JsonSerializable()
class UserRecommendation with _$UserRecommendation {
  const factory UserRecommendation({
    required int userId, // 用户ID
    required String userName, // 用户名
    String? userAvatar, // 用户头像
    required double score, // 推荐分数 (0.0-1.0)
    required String algorithmType, // 算法类型
    double? similarity, // 相似度
    double? socialDistance, // 社交距离
    int? mutualFollowsCount, // 互相关注数量
    required String recommendationReason, // 推荐理由
    List<Restaurant>? commonRestaurants, // 共同餐厅
    List<String>? commonRestaurantTypes, // 共同餐厅类型
    double? activityScore, // 活跃度分数
    double? influenceScore, // 影响力分数
    // 本地状态字段（API不返回）
    RecommendationStatus? status, // 推荐状态
    DateTime? createdAt, // 创建时间
    DateTime? viewedAt, // 查看时间
  }) = _UserRecommendation;

  factory UserRecommendation.fromJson(Map<String, dynamic> json) {
    // 手动处理默认值
    final parsedJson = Map<String, dynamic>.from(json);
    parsedJson['status'] ??= RecommendationStatus.unviewed.name;
    return _$UserRecommendationFromJson(parsedJson);
  }

  // 添加私有构造函数以支持在getter中访问属性
  const UserRecommendation._();

  /// 获取星级评分 (1-5星)
  int get starRating {
    if (score >= 0.8) return 5;
    if (score >= 0.6) return 4;
    if (score >= 0.4) return 3;
    if (score >= 0.2) return 2;
    return 1;
  }

  /// 获取星级显示字符串
  String get starRatingString {
    final stars = '⭐' * starRating;
    final emptyStars = '☆' * (5 - starRating);
    return stars + emptyStars;
  }

  /// 是否为高推荐度
  bool get isHighRecommendation => score >= 0.7;

  /// 是否为中等推荐度
  bool get isMediumRecommendation => score >= 0.4 && score < 0.7;

  /// 是否为低推荐度
  bool get isLowRecommendation => score < 0.4;

  /// 获取用户显示名称（兼容原有代码）
  String get displayName => userName;

  /// 获取用户头像URL（兼容原有代码）
  String? get avatarUrl => userAvatar;

  /// 获取用户ID（兼容原有代码）
  int get id => userId;

  /// 获取推荐算法的显示名称
  String get algorithmDisplayName {
    switch (algorithmType.toLowerCase()) {
      case 'hybrid_weighted':
        return '混合加权推荐';
      case 'weighted':
        return '加权推荐';
      case 'switching':
        return '切换推荐';
      case 'cascade':
        return '级联推荐';
      default:
        return '智能推荐';
    }
  }

  /// 获取相似度百分比显示
  String get similarityPercentage {
    if (similarity == null) return '';
    return '${((similarity ?? 0.0) * 100).toStringAsFixed(1)}%';
  }

  /// 获取共同餐厅数量
  int get commonRestaurantsCount => commonRestaurants?.length ?? 0;

  /// 获取共同餐厅类型数量
  int get commonRestaurantTypesCount => commonRestaurantTypes?.length ?? 0;
}

/// 推荐状态请求模型
@freezed
class RecommendationStatusRequest with _$RecommendationStatusRequest {
  const factory RecommendationStatusRequest({
    required RecommendationStatus status,
  }) = _RecommendationStatusRequest;

  factory RecommendationStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$RecommendationStatusRequestFromJson(json);
}

/// 批量查看请求模型
@freezed
class BatchViewedRequest with _$BatchViewedRequest {
  const factory BatchViewedRequest({required List<int> recommendationIds}) =
      _BatchViewedRequest;

  factory BatchViewedRequest.fromJson(Map<String, dynamic> json) =>
      _$BatchViewedRequestFromJson(json);
}

/// 推荐统计信息模型
@freezed
class RecommendationStats with _$RecommendationStats {
  const factory RecommendationStats({
    required int totalRecommendations, // 总推荐数
    required int viewedCount, // 已查看数
    required int interestedCount, // 感兴趣数
    required int notInterestedCount, // 不感兴趣数
    required double averageScore, // 平均推荐分数
  }) = _RecommendationStats;

  factory RecommendationStats.fromJson(Map<String, dynamic> json) =>
      _$RecommendationStatsFromJson(json);
}

// 用户模型已在文件开头导入，无需重复导入
