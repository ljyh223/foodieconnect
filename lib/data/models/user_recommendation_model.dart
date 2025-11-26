import 'restaurant_model.dart';

/// 推荐状态枚举
enum RecommendationStatus {
  unviewed,    // 未查看
  viewed,      // 已查看
  interested,  // 感兴趣
  notInterested, // 不感兴趣
}

/// 推荐算法类型枚举
enum RecommendationAlgorithm {
  weighted,            // 加权推荐
  switching,           // 切换推荐
  cascade,             // 级联推荐
  hybridWeighted,      // 混合加权推荐（API返回值）
}

// API返回的字符串常量
class RecommendationAlgorithmType {
  static const String weighted = 'weighted';
  static const String switching = 'switching';
  static const String cascade = 'cascade';
  static const String hybridWeighted = 'hybrid_weighted';
}

/// 用户推荐模型 - 根据API返回数据结构更新
class UserRecommendation {
  final int userId;                          // 用户ID
  final String userName;                     // 用户名
  final String? userAvatar;                  // 用户头像
  final double score;                        // 推荐分数 (0.0-1.0)
  final String algorithmType;                // 算法类型
  final double? similarity;                  // 相似度
  final double? socialDistance;              // 社交距离
  final int? mutualFollowsCount;             // 互相关注数量
  final String recommendationReason;         // 推荐理由
  final List<Restaurant>? commonRestaurants;  // 共同餐厅
  final List<String>? commonRestaurantTypes; // 共同餐厅类型
  final double? activityScore;               // 活跃度分数
  final double? influenceScore;              // 影响力分数
  
  // 本地状态字段（API不返回）
  final RecommendationStatus status;         // 推荐状态
  final DateTime createdAt;                   // 创建时间
  final DateTime? viewedAt;                   // 查看时间

  UserRecommendation({
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.score,
    required this.algorithmType,
    this.similarity,
    this.socialDistance,
    this.mutualFollowsCount,
    required this.recommendationReason,
    this.commonRestaurants,
    this.commonRestaurantTypes,
    this.activityScore,
    this.influenceScore,
    this.status = RecommendationStatus.unviewed,
    DateTime? createdAt,
    this.viewedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserRecommendation.fromJson(Map<String, dynamic> json) {
    // 解析共同餐厅列表
    List<Restaurant>? commonRestaurants;
    if (json['commonRestaurants'] != null) {
      commonRestaurants = (json['commonRestaurants'] as List<dynamic>)
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList();
    }

    // 解析共同餐厅类型
    List<String>? commonRestaurantTypes;
    if (json['commonRestaurantTypes'] != null) {
      commonRestaurantTypes = (json['commonRestaurantTypes'] as List<dynamic>)
          .map((type) => type.toString())
          .toList();
    }

    return UserRecommendation(
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'],
      score: (json['score'] ?? 0.0).toDouble(),
      algorithmType: json['algorithmType'] ?? '',
      similarity: json['similarity']?.toDouble(),
      socialDistance: json['socialDistance']?.toDouble(),
      mutualFollowsCount: json['mutualFollowsCount'] as int?,
      recommendationReason: json['recommendationReason'] ?? '',
      commonRestaurants: commonRestaurants,
      commonRestaurantTypes: commonRestaurantTypes,
      activityScore: json['activityScore']?.toDouble(),
      influenceScore: json['influenceScore']?.toDouble(),
      status: _parseStatus(json['status']),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      viewedAt: json['viewedAt'] != null ? DateTime.parse(json['viewedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'score': score,
      'algorithmType': algorithmType,
      'similarity': similarity,
      'socialDistance': socialDistance,
      'mutualFollowsCount': mutualFollowsCount,
      'recommendationReason': recommendationReason,
      'commonRestaurants': commonRestaurants?.map((r) => r.toJson()).toList(),
      'commonRestaurantTypes': commonRestaurantTypes,
      'activityScore': activityScore,
      'influenceScore': influenceScore,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'viewedAt': viewedAt?.toIso8601String(),
    };
  }

  /// 解析推荐状态
  static RecommendationStatus _parseStatus(String? status) {
    switch (status) {
      case 'VIEWED':
        return RecommendationStatus.viewed;
      case 'INTERESTED':
        return RecommendationStatus.interested;
      case 'NOT_INTERESTED':
        return RecommendationStatus.notInterested;
      default:
        return RecommendationStatus.unviewed;
    }
  }

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
    return '${(similarity! * 100).toStringAsFixed(1)}%';
  }
  
  /// 获取共同餐厅数量
  int get commonRestaurantsCount => commonRestaurants?.length ?? 0;
  
  /// 获取共同餐厅类型数量
  int get commonRestaurantTypesCount => commonRestaurantTypes?.length ?? 0;
}

/// 推荐状态请求模型
class RecommendationStatusRequest {
  final RecommendationStatus status;

  RecommendationStatusRequest({required this.status});

  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
    };
  }
}

/// 批量查看请求模型
class BatchViewedRequest {
  final List<int> recommendationIds;

  BatchViewedRequest({required this.recommendationIds});

  Map<String, dynamic> toJson() {
    return {
      'recommendationIds': recommendationIds,
    };
  }
}

/// 推荐统计信息模型
class RecommendationStats {
  final int totalRecommendations;    // 总推荐数
  final int viewedCount;            // 已查看数
  final int interestedCount;        // 感兴趣数
  final int notInterestedCount;     // 不感兴趣数
  final double averageScore;         // 平均推荐分数

  RecommendationStats({
    required this.totalRecommendations,
    required this.viewedCount,
    required this.interestedCount,
    required this.notInterestedCount,
    required this.averageScore,
  });

  factory RecommendationStats.fromJson(Map<String, dynamic> json) {
    return RecommendationStats(
      totalRecommendations: json['totalRecommendations'] ?? 0,
      viewedCount: json['viewedCount'] ?? 0,
      interestedCount: json['interestedCount'] ?? 0,
      notInterestedCount: json['notInterestedCount'] ?? 0,
      averageScore: (json['averageScore'] ?? 0.0).toDouble(),
    );
  }
}

/// 扩展 UserRecommendation 的 copyWith 方法
extension UserRecommendationCopyWith on UserRecommendation {
  UserRecommendation copyWith({
    int? userId,
    String? userName,
    String? userAvatar,
    double? score,
    String? algorithmType,
    double? similarity,
    double? socialDistance,
    int? mutualFollowsCount,
    String? recommendationReason,
    List<Restaurant>? commonRestaurants,
    List<String>? commonRestaurantTypes,
    double? activityScore,
    double? influenceScore,
    RecommendationStatus? status,
    DateTime? createdAt,
    DateTime? viewedAt,
  }) {
    return UserRecommendation(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      score: score ?? this.score,
      algorithmType: algorithmType ?? this.algorithmType,
      similarity: similarity ?? this.similarity,
      socialDistance: socialDistance ?? this.socialDistance,
      mutualFollowsCount: mutualFollowsCount ?? this.mutualFollowsCount,
      recommendationReason: recommendationReason ?? this.recommendationReason,
      commonRestaurants: commonRestaurants ?? this.commonRestaurants,
      commonRestaurantTypes: commonRestaurantTypes ?? this.commonRestaurantTypes,
      activityScore: activityScore ?? this.activityScore,
      influenceScore: influenceScore ?? this.influenceScore,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }
}

// 用户模型已在文件开头导入，无需重复导入