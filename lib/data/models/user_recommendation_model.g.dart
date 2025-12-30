// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecommendation _$UserRecommendationFromJson(Map<String, dynamic> json) =>
    UserRecommendation(
      userId: (json['userId'] as num).toInt(),
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String?,
      score: (json['score'] as num).toDouble(),
      algorithmType: json['algorithmType'] as String,
      similarity: (json['similarity'] as num?)?.toDouble(),
      socialDistance: (json['socialDistance'] as num?)?.toDouble(),
      mutualFollowsCount: (json['mutualFollowsCount'] as num?)?.toInt(),
      recommendationReason: json['recommendationReason'] as String,
      commonRestaurants: (json['commonRestaurants'] as List<dynamic>?)
          ?.map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList(),
      commonRestaurantTypes: (json['commonRestaurantTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      activityScore: (json['activityScore'] as num?)?.toDouble(),
      influenceScore: (json['influenceScore'] as num?)?.toDouble(),
      status: $enumDecodeNullable(
        _$RecommendationStatusEnumMap,
        json['status'],
      ),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      viewedAt: json['viewedAt'] == null
          ? null
          : DateTime.parse(json['viewedAt'] as String),
    );

Map<String, dynamic> _$UserRecommendationToJson(UserRecommendation instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'score': instance.score,
      'algorithmType': instance.algorithmType,
      'similarity': instance.similarity,
      'socialDistance': instance.socialDistance,
      'mutualFollowsCount': instance.mutualFollowsCount,
      'recommendationReason': instance.recommendationReason,
      'commonRestaurants': instance.commonRestaurants,
      'commonRestaurantTypes': instance.commonRestaurantTypes,
      'activityScore': instance.activityScore,
      'influenceScore': instance.influenceScore,
      'status': _$RecommendationStatusEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
      'viewedAt': instance.viewedAt?.toIso8601String(),
    };

const _$RecommendationStatusEnumMap = {
  RecommendationStatus.unviewed: 'unviewed',
  RecommendationStatus.viewed: 'viewed',
  RecommendationStatus.interested: 'interested',
  RecommendationStatus.notInterested: 'notInterested',
};

_$RecommendationStatusRequestImpl _$$RecommendationStatusRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendationStatusRequestImpl(
  status: $enumDecode(_$RecommendationStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$RecommendationStatusRequestImplToJson(
  _$RecommendationStatusRequestImpl instance,
) => <String, dynamic>{
  'status': _$RecommendationStatusEnumMap[instance.status]!,
};

_$BatchViewedRequestImpl _$$BatchViewedRequestImplFromJson(
  Map<String, dynamic> json,
) => _$BatchViewedRequestImpl(
  recommendationIds: (json['recommendationIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$$BatchViewedRequestImplToJson(
  _$BatchViewedRequestImpl instance,
) => <String, dynamic>{'recommendationIds': instance.recommendationIds};

_$RecommendationStatsImpl _$$RecommendationStatsImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendationStatsImpl(
  totalRecommendations: (json['totalRecommendations'] as num).toInt(),
  viewedCount: (json['viewedCount'] as num).toInt(),
  interestedCount: (json['interestedCount'] as num).toInt(),
  notInterestedCount: (json['notInterestedCount'] as num).toInt(),
  averageScore: (json['averageScore'] as num).toDouble(),
);

Map<String, dynamic> _$$RecommendationStatsImplToJson(
  _$RecommendationStatsImpl instance,
) => <String, dynamic>{
  'totalRecommendations': instance.totalRecommendations,
  'viewedCount': instance.viewedCount,
  'interestedCount': instance.interestedCount,
  'notInterestedCount': instance.notInterestedCount,
  'averageScore': instance.averageScore,
};
