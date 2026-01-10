// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserRecommendation {
  int get userId => throw _privateConstructorUsedError; // 用户ID
  String get userName => throw _privateConstructorUsedError; // 用户名
  String? get userAvatar => throw _privateConstructorUsedError; // 用户头像
  double get score => throw _privateConstructorUsedError; // 推荐分数 (0.0-1.0)
  String get algorithmType => throw _privateConstructorUsedError; // 算法类型
  double? get similarity => throw _privateConstructorUsedError; // 相似度
  double? get socialDistance => throw _privateConstructorUsedError; // 社交距离
  int? get mutualFollowsCount => throw _privateConstructorUsedError; // 互相关注数量
  String get recommendationReason => throw _privateConstructorUsedError; // 推荐理由
  List<Restaurant>? get commonRestaurants =>
      throw _privateConstructorUsedError; // 共同餐厅
  List<String>? get commonRestaurantTypes =>
      throw _privateConstructorUsedError; // 共同餐厅类型
  double? get activityScore => throw _privateConstructorUsedError; // 活跃度分数
  double? get influenceScore => throw _privateConstructorUsedError; // 影响力分数
  // 本地状态字段（API不返回）
  RecommendationStatus? get status =>
      throw _privateConstructorUsedError; // 推荐状态
  DateTime? get createdAt => throw _privateConstructorUsedError; // 创建时间
  DateTime? get viewedAt => throw _privateConstructorUsedError;

  /// Create a copy of UserRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRecommendationCopyWith<UserRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRecommendationCopyWith<$Res> {
  factory $UserRecommendationCopyWith(
    UserRecommendation value,
    $Res Function(UserRecommendation) then,
  ) = _$UserRecommendationCopyWithImpl<$Res, UserRecommendation>;
  @useResult
  $Res call({
    int userId,
    String userName,
    String? userAvatar,
    double score,
    String algorithmType,
    double? similarity,
    double? socialDistance,
    int? mutualFollowsCount,
    String recommendationReason,
    List<Restaurant>? commonRestaurants,
    List<String>? commonRestaurantTypes,
    double? activityScore,
    double? influenceScore,
    RecommendationStatus? status,
    DateTime? createdAt,
    DateTime? viewedAt,
  });
}

/// @nodoc
class _$UserRecommendationCopyWithImpl<$Res, $Val extends UserRecommendation>
    implements $UserRecommendationCopyWith<$Res> {
  _$UserRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? score = null,
    Object? algorithmType = null,
    Object? similarity = freezed,
    Object? socialDistance = freezed,
    Object? mutualFollowsCount = freezed,
    Object? recommendationReason = null,
    Object? commonRestaurants = freezed,
    Object? commonRestaurantTypes = freezed,
    Object? activityScore = freezed,
    Object? influenceScore = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? viewedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            userAvatar: freezed == userAvatar
                ? _value.userAvatar
                : userAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double,
            algorithmType: null == algorithmType
                ? _value.algorithmType
                : algorithmType // ignore: cast_nullable_to_non_nullable
                      as String,
            similarity: freezed == similarity
                ? _value.similarity
                : similarity // ignore: cast_nullable_to_non_nullable
                      as double?,
            socialDistance: freezed == socialDistance
                ? _value.socialDistance
                : socialDistance // ignore: cast_nullable_to_non_nullable
                      as double?,
            mutualFollowsCount: freezed == mutualFollowsCount
                ? _value.mutualFollowsCount
                : mutualFollowsCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            recommendationReason: null == recommendationReason
                ? _value.recommendationReason
                : recommendationReason // ignore: cast_nullable_to_non_nullable
                      as String,
            commonRestaurants: freezed == commonRestaurants
                ? _value.commonRestaurants
                : commonRestaurants // ignore: cast_nullable_to_non_nullable
                      as List<Restaurant>?,
            commonRestaurantTypes: freezed == commonRestaurantTypes
                ? _value.commonRestaurantTypes
                : commonRestaurantTypes // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            activityScore: freezed == activityScore
                ? _value.activityScore
                : activityScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            influenceScore: freezed == influenceScore
                ? _value.influenceScore
                : influenceScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RecommendationStatus?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            viewedAt: freezed == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserRecommendationImplCopyWith<$Res>
    implements $UserRecommendationCopyWith<$Res> {
  factory _$$UserRecommendationImplCopyWith(
    _$UserRecommendationImpl value,
    $Res Function(_$UserRecommendationImpl) then,
  ) = __$$UserRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int userId,
    String userName,
    String? userAvatar,
    double score,
    String algorithmType,
    double? similarity,
    double? socialDistance,
    int? mutualFollowsCount,
    String recommendationReason,
    List<Restaurant>? commonRestaurants,
    List<String>? commonRestaurantTypes,
    double? activityScore,
    double? influenceScore,
    RecommendationStatus? status,
    DateTime? createdAt,
    DateTime? viewedAt,
  });
}

/// @nodoc
class __$$UserRecommendationImplCopyWithImpl<$Res>
    extends _$UserRecommendationCopyWithImpl<$Res, _$UserRecommendationImpl>
    implements _$$UserRecommendationImplCopyWith<$Res> {
  __$$UserRecommendationImplCopyWithImpl(
    _$UserRecommendationImpl _value,
    $Res Function(_$UserRecommendationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? score = null,
    Object? algorithmType = null,
    Object? similarity = freezed,
    Object? socialDistance = freezed,
    Object? mutualFollowsCount = freezed,
    Object? recommendationReason = null,
    Object? commonRestaurants = freezed,
    Object? commonRestaurantTypes = freezed,
    Object? activityScore = freezed,
    Object? influenceScore = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? viewedAt = freezed,
  }) {
    return _then(
      _$UserRecommendationImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        userAvatar: freezed == userAvatar
            ? _value.userAvatar
            : userAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double,
        algorithmType: null == algorithmType
            ? _value.algorithmType
            : algorithmType // ignore: cast_nullable_to_non_nullable
                  as String,
        similarity: freezed == similarity
            ? _value.similarity
            : similarity // ignore: cast_nullable_to_non_nullable
                  as double?,
        socialDistance: freezed == socialDistance
            ? _value.socialDistance
            : socialDistance // ignore: cast_nullable_to_non_nullable
                  as double?,
        mutualFollowsCount: freezed == mutualFollowsCount
            ? _value.mutualFollowsCount
            : mutualFollowsCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        recommendationReason: null == recommendationReason
            ? _value.recommendationReason
            : recommendationReason // ignore: cast_nullable_to_non_nullable
                  as String,
        commonRestaurants: freezed == commonRestaurants
            ? _value._commonRestaurants
            : commonRestaurants // ignore: cast_nullable_to_non_nullable
                  as List<Restaurant>?,
        commonRestaurantTypes: freezed == commonRestaurantTypes
            ? _value._commonRestaurantTypes
            : commonRestaurantTypes // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        activityScore: freezed == activityScore
            ? _value.activityScore
            : activityScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        influenceScore: freezed == influenceScore
            ? _value.influenceScore
            : influenceScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RecommendationStatus?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        viewedAt: freezed == viewedAt
            ? _value.viewedAt
            : viewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$UserRecommendationImpl extends _UserRecommendation {
  const _$UserRecommendationImpl({
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.score,
    required this.algorithmType,
    this.similarity,
    this.socialDistance,
    this.mutualFollowsCount,
    required this.recommendationReason,
    final List<Restaurant>? commonRestaurants,
    final List<String>? commonRestaurantTypes,
    this.activityScore,
    this.influenceScore,
    this.status,
    this.createdAt,
    this.viewedAt,
  }) : _commonRestaurants = commonRestaurants,
       _commonRestaurantTypes = commonRestaurantTypes,
       super._();

  @override
  final int userId;
  // 用户ID
  @override
  final String userName;
  // 用户名
  @override
  final String? userAvatar;
  // 用户头像
  @override
  final double score;
  // 推荐分数 (0.0-1.0)
  @override
  final String algorithmType;
  // 算法类型
  @override
  final double? similarity;
  // 相似度
  @override
  final double? socialDistance;
  // 社交距离
  @override
  final int? mutualFollowsCount;
  // 互相关注数量
  @override
  final String recommendationReason;
  // 推荐理由
  final List<Restaurant>? _commonRestaurants;
  // 推荐理由
  @override
  List<Restaurant>? get commonRestaurants {
    final value = _commonRestaurants;
    if (value == null) return null;
    if (_commonRestaurants is EqualUnmodifiableListView)
      return _commonRestaurants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // 共同餐厅
  final List<String>? _commonRestaurantTypes;
  // 共同餐厅
  @override
  List<String>? get commonRestaurantTypes {
    final value = _commonRestaurantTypes;
    if (value == null) return null;
    if (_commonRestaurantTypes is EqualUnmodifiableListView)
      return _commonRestaurantTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // 共同餐厅类型
  @override
  final double? activityScore;
  // 活跃度分数
  @override
  final double? influenceScore;
  // 影响力分数
  // 本地状态字段（API不返回）
  @override
  final RecommendationStatus? status;
  // 推荐状态
  @override
  final DateTime? createdAt;
  // 创建时间
  @override
  final DateTime? viewedAt;

  @override
  String toString() {
    return 'UserRecommendation(userId: $userId, userName: $userName, userAvatar: $userAvatar, score: $score, algorithmType: $algorithmType, similarity: $similarity, socialDistance: $socialDistance, mutualFollowsCount: $mutualFollowsCount, recommendationReason: $recommendationReason, commonRestaurants: $commonRestaurants, commonRestaurantTypes: $commonRestaurantTypes, activityScore: $activityScore, influenceScore: $influenceScore, status: $status, createdAt: $createdAt, viewedAt: $viewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRecommendationImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.algorithmType, algorithmType) ||
                other.algorithmType == algorithmType) &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity) &&
            (identical(other.socialDistance, socialDistance) ||
                other.socialDistance == socialDistance) &&
            (identical(other.mutualFollowsCount, mutualFollowsCount) ||
                other.mutualFollowsCount == mutualFollowsCount) &&
            (identical(other.recommendationReason, recommendationReason) ||
                other.recommendationReason == recommendationReason) &&
            const DeepCollectionEquality().equals(
              other._commonRestaurants,
              _commonRestaurants,
            ) &&
            const DeepCollectionEquality().equals(
              other._commonRestaurantTypes,
              _commonRestaurantTypes,
            ) &&
            (identical(other.activityScore, activityScore) ||
                other.activityScore == activityScore) &&
            (identical(other.influenceScore, influenceScore) ||
                other.influenceScore == influenceScore) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    userName,
    userAvatar,
    score,
    algorithmType,
    similarity,
    socialDistance,
    mutualFollowsCount,
    recommendationReason,
    const DeepCollectionEquality().hash(_commonRestaurants),
    const DeepCollectionEquality().hash(_commonRestaurantTypes),
    activityScore,
    influenceScore,
    status,
    createdAt,
    viewedAt,
  );

  /// Create a copy of UserRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRecommendationImplCopyWith<_$UserRecommendationImpl> get copyWith =>
      __$$UserRecommendationImplCopyWithImpl<_$UserRecommendationImpl>(
        this,
        _$identity,
      );
}

abstract class _UserRecommendation extends UserRecommendation {
  const factory _UserRecommendation({
    required final int userId,
    required final String userName,
    final String? userAvatar,
    required final double score,
    required final String algorithmType,
    final double? similarity,
    final double? socialDistance,
    final int? mutualFollowsCount,
    required final String recommendationReason,
    final List<Restaurant>? commonRestaurants,
    final List<String>? commonRestaurantTypes,
    final double? activityScore,
    final double? influenceScore,
    final RecommendationStatus? status,
    final DateTime? createdAt,
    final DateTime? viewedAt,
  }) = _$UserRecommendationImpl;
  const _UserRecommendation._() : super._();

  @override
  int get userId; // 用户ID
  @override
  String get userName; // 用户名
  @override
  String? get userAvatar; // 用户头像
  @override
  double get score; // 推荐分数 (0.0-1.0)
  @override
  String get algorithmType; // 算法类型
  @override
  double? get similarity; // 相似度
  @override
  double? get socialDistance; // 社交距离
  @override
  int? get mutualFollowsCount; // 互相关注数量
  @override
  String get recommendationReason; // 推荐理由
  @override
  List<Restaurant>? get commonRestaurants; // 共同餐厅
  @override
  List<String>? get commonRestaurantTypes; // 共同餐厅类型
  @override
  double? get activityScore; // 活跃度分数
  @override
  double? get influenceScore; // 影响力分数
  // 本地状态字段（API不返回）
  @override
  RecommendationStatus? get status; // 推荐状态
  @override
  DateTime? get createdAt; // 创建时间
  @override
  DateTime? get viewedAt;

  /// Create a copy of UserRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRecommendationImplCopyWith<_$UserRecommendationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationStatusRequest {
  RecommendationStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationStatusRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationStatusRequestCopyWith<RecommendationStatusRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationStatusRequestCopyWith<$Res> {
  factory $RecommendationStatusRequestCopyWith(
    RecommendationStatusRequest value,
    $Res Function(RecommendationStatusRequest) then,
  ) =
      _$RecommendationStatusRequestCopyWithImpl<
        $Res,
        RecommendationStatusRequest
      >;
  @useResult
  $Res call({RecommendationStatus status});
}

/// @nodoc
class _$RecommendationStatusRequestCopyWithImpl<
  $Res,
  $Val extends RecommendationStatusRequest
>
    implements $RecommendationStatusRequestCopyWith<$Res> {
  _$RecommendationStatusRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationStatusRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RecommendationStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendationStatusRequestImplCopyWith<$Res>
    implements $RecommendationStatusRequestCopyWith<$Res> {
  factory _$$RecommendationStatusRequestImplCopyWith(
    _$RecommendationStatusRequestImpl value,
    $Res Function(_$RecommendationStatusRequestImpl) then,
  ) = __$$RecommendationStatusRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RecommendationStatus status});
}

/// @nodoc
class __$$RecommendationStatusRequestImplCopyWithImpl<$Res>
    extends
        _$RecommendationStatusRequestCopyWithImpl<
          $Res,
          _$RecommendationStatusRequestImpl
        >
    implements _$$RecommendationStatusRequestImplCopyWith<$Res> {
  __$$RecommendationStatusRequestImplCopyWithImpl(
    _$RecommendationStatusRequestImpl _value,
    $Res Function(_$RecommendationStatusRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendationStatusRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null}) {
    return _then(
      _$RecommendationStatusRequestImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RecommendationStatus,
      ),
    );
  }
}

/// @nodoc

class _$RecommendationStatusRequestImpl
    implements _RecommendationStatusRequest {
  const _$RecommendationStatusRequestImpl({required this.status});

  @override
  final RecommendationStatus status;

  @override
  String toString() {
    return 'RecommendationStatusRequest(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationStatusRequestImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  /// Create a copy of RecommendationStatusRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationStatusRequestImplCopyWith<_$RecommendationStatusRequestImpl>
  get copyWith =>
      __$$RecommendationStatusRequestImplCopyWithImpl<
        _$RecommendationStatusRequestImpl
      >(this, _$identity);
}

abstract class _RecommendationStatusRequest
    implements RecommendationStatusRequest {
  const factory _RecommendationStatusRequest({
    required final RecommendationStatus status,
  }) = _$RecommendationStatusRequestImpl;

  @override
  RecommendationStatus get status;

  /// Create a copy of RecommendationStatusRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationStatusRequestImplCopyWith<_$RecommendationStatusRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BatchViewedRequest {
  List<int> get recommendationIds => throw _privateConstructorUsedError;

  /// Create a copy of BatchViewedRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchViewedRequestCopyWith<BatchViewedRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchViewedRequestCopyWith<$Res> {
  factory $BatchViewedRequestCopyWith(
    BatchViewedRequest value,
    $Res Function(BatchViewedRequest) then,
  ) = _$BatchViewedRequestCopyWithImpl<$Res, BatchViewedRequest>;
  @useResult
  $Res call({List<int> recommendationIds});
}

/// @nodoc
class _$BatchViewedRequestCopyWithImpl<$Res, $Val extends BatchViewedRequest>
    implements $BatchViewedRequestCopyWith<$Res> {
  _$BatchViewedRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchViewedRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recommendationIds = null}) {
    return _then(
      _value.copyWith(
            recommendationIds: null == recommendationIds
                ? _value.recommendationIds
                : recommendationIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BatchViewedRequestImplCopyWith<$Res>
    implements $BatchViewedRequestCopyWith<$Res> {
  factory _$$BatchViewedRequestImplCopyWith(
    _$BatchViewedRequestImpl value,
    $Res Function(_$BatchViewedRequestImpl) then,
  ) = __$$BatchViewedRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int> recommendationIds});
}

/// @nodoc
class __$$BatchViewedRequestImplCopyWithImpl<$Res>
    extends _$BatchViewedRequestCopyWithImpl<$Res, _$BatchViewedRequestImpl>
    implements _$$BatchViewedRequestImplCopyWith<$Res> {
  __$$BatchViewedRequestImplCopyWithImpl(
    _$BatchViewedRequestImpl _value,
    $Res Function(_$BatchViewedRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchViewedRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recommendationIds = null}) {
    return _then(
      _$BatchViewedRequestImpl(
        recommendationIds: null == recommendationIds
            ? _value._recommendationIds
            : recommendationIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc

class _$BatchViewedRequestImpl implements _BatchViewedRequest {
  const _$BatchViewedRequestImpl({required final List<int> recommendationIds})
    : _recommendationIds = recommendationIds;

  final List<int> _recommendationIds;
  @override
  List<int> get recommendationIds {
    if (_recommendationIds is EqualUnmodifiableListView)
      return _recommendationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendationIds);
  }

  @override
  String toString() {
    return 'BatchViewedRequest(recommendationIds: $recommendationIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchViewedRequestImpl &&
            const DeepCollectionEquality().equals(
              other._recommendationIds,
              _recommendationIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_recommendationIds),
  );

  /// Create a copy of BatchViewedRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchViewedRequestImplCopyWith<_$BatchViewedRequestImpl> get copyWith =>
      __$$BatchViewedRequestImplCopyWithImpl<_$BatchViewedRequestImpl>(
        this,
        _$identity,
      );
}

abstract class _BatchViewedRequest implements BatchViewedRequest {
  const factory _BatchViewedRequest({
    required final List<int> recommendationIds,
  }) = _$BatchViewedRequestImpl;

  @override
  List<int> get recommendationIds;

  /// Create a copy of BatchViewedRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchViewedRequestImplCopyWith<_$BatchViewedRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationStats {
  int get totalRecommendations => throw _privateConstructorUsedError; // 总推荐数
  int get viewedCount => throw _privateConstructorUsedError; // 已查看数
  int get interestedCount => throw _privateConstructorUsedError; // 感兴趣数
  int get notInterestedCount => throw _privateConstructorUsedError; // 不感兴趣数
  double get averageScore => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationStatsCopyWith<RecommendationStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationStatsCopyWith<$Res> {
  factory $RecommendationStatsCopyWith(
    RecommendationStats value,
    $Res Function(RecommendationStats) then,
  ) = _$RecommendationStatsCopyWithImpl<$Res, RecommendationStats>;
  @useResult
  $Res call({
    int totalRecommendations,
    int viewedCount,
    int interestedCount,
    int notInterestedCount,
    double averageScore,
  });
}

/// @nodoc
class _$RecommendationStatsCopyWithImpl<$Res, $Val extends RecommendationStats>
    implements $RecommendationStatsCopyWith<$Res> {
  _$RecommendationStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecommendations = null,
    Object? viewedCount = null,
    Object? interestedCount = null,
    Object? notInterestedCount = null,
    Object? averageScore = null,
  }) {
    return _then(
      _value.copyWith(
            totalRecommendations: null == totalRecommendations
                ? _value.totalRecommendations
                : totalRecommendations // ignore: cast_nullable_to_non_nullable
                      as int,
            viewedCount: null == viewedCount
                ? _value.viewedCount
                : viewedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            interestedCount: null == interestedCount
                ? _value.interestedCount
                : interestedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            notInterestedCount: null == notInterestedCount
                ? _value.notInterestedCount
                : notInterestedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            averageScore: null == averageScore
                ? _value.averageScore
                : averageScore // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendationStatsImplCopyWith<$Res>
    implements $RecommendationStatsCopyWith<$Res> {
  factory _$$RecommendationStatsImplCopyWith(
    _$RecommendationStatsImpl value,
    $Res Function(_$RecommendationStatsImpl) then,
  ) = __$$RecommendationStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalRecommendations,
    int viewedCount,
    int interestedCount,
    int notInterestedCount,
    double averageScore,
  });
}

/// @nodoc
class __$$RecommendationStatsImplCopyWithImpl<$Res>
    extends _$RecommendationStatsCopyWithImpl<$Res, _$RecommendationStatsImpl>
    implements _$$RecommendationStatsImplCopyWith<$Res> {
  __$$RecommendationStatsImplCopyWithImpl(
    _$RecommendationStatsImpl _value,
    $Res Function(_$RecommendationStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRecommendations = null,
    Object? viewedCount = null,
    Object? interestedCount = null,
    Object? notInterestedCount = null,
    Object? averageScore = null,
  }) {
    return _then(
      _$RecommendationStatsImpl(
        totalRecommendations: null == totalRecommendations
            ? _value.totalRecommendations
            : totalRecommendations // ignore: cast_nullable_to_non_nullable
                  as int,
        viewedCount: null == viewedCount
            ? _value.viewedCount
            : viewedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        interestedCount: null == interestedCount
            ? _value.interestedCount
            : interestedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        notInterestedCount: null == notInterestedCount
            ? _value.notInterestedCount
            : notInterestedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        averageScore: null == averageScore
            ? _value.averageScore
            : averageScore // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$RecommendationStatsImpl implements _RecommendationStats {
  const _$RecommendationStatsImpl({
    required this.totalRecommendations,
    required this.viewedCount,
    required this.interestedCount,
    required this.notInterestedCount,
    required this.averageScore,
  });

  @override
  final int totalRecommendations;
  // 总推荐数
  @override
  final int viewedCount;
  // 已查看数
  @override
  final int interestedCount;
  // 感兴趣数
  @override
  final int notInterestedCount;
  // 不感兴趣数
  @override
  final double averageScore;

  @override
  String toString() {
    return 'RecommendationStats(totalRecommendations: $totalRecommendations, viewedCount: $viewedCount, interestedCount: $interestedCount, notInterestedCount: $notInterestedCount, averageScore: $averageScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationStatsImpl &&
            (identical(other.totalRecommendations, totalRecommendations) ||
                other.totalRecommendations == totalRecommendations) &&
            (identical(other.viewedCount, viewedCount) ||
                other.viewedCount == viewedCount) &&
            (identical(other.interestedCount, interestedCount) ||
                other.interestedCount == interestedCount) &&
            (identical(other.notInterestedCount, notInterestedCount) ||
                other.notInterestedCount == notInterestedCount) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalRecommendations,
    viewedCount,
    interestedCount,
    notInterestedCount,
    averageScore,
  );

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationStatsImplCopyWith<_$RecommendationStatsImpl> get copyWith =>
      __$$RecommendationStatsImplCopyWithImpl<_$RecommendationStatsImpl>(
        this,
        _$identity,
      );
}

abstract class _RecommendationStats implements RecommendationStats {
  const factory _RecommendationStats({
    required final int totalRecommendations,
    required final int viewedCount,
    required final int interestedCount,
    required final int notInterestedCount,
    required final double averageScore,
  }) = _$RecommendationStatsImpl;

  @override
  int get totalRecommendations; // 总推荐数
  @override
  int get viewedCount; // 已查看数
  @override
  int get interestedCount; // 感兴趣数
  @override
  int get notInterestedCount; // 不感兴趣数
  @override
  double get averageScore;

  /// Create a copy of RecommendationStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationStatsImplCopyWith<_$RecommendationStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
