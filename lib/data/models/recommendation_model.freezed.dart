// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RestaurantRecommendation {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get restaurantId => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  int? get rating => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of RestaurantRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantRecommendationCopyWith<RestaurantRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantRecommendationCopyWith<$Res> {
  factory $RestaurantRecommendationCopyWith(
    RestaurantRecommendation value,
    $Res Function(RestaurantRecommendation) then,
  ) = _$RestaurantRecommendationCopyWithImpl<$Res, RestaurantRecommendation>;
  @useResult
  $Res call({
    int id,
    int userId,
    int restaurantId,
    String? reason,
    int? rating,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class _$RestaurantRecommendationCopyWithImpl<
  $Res,
  $Val extends RestaurantRecommendation
>
    implements $RestaurantRecommendationCopyWith<$Res> {
  _$RestaurantRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RestaurantRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? restaurantId = null,
    Object? reason = freezed,
    Object? rating = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            restaurantId: null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as int,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantRecommendationImplCopyWith<$Res>
    implements $RestaurantRecommendationCopyWith<$Res> {
  factory _$$RestaurantRecommendationImplCopyWith(
    _$RestaurantRecommendationImpl value,
    $Res Function(_$RestaurantRecommendationImpl) then,
  ) = __$$RestaurantRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userId,
    int restaurantId,
    String? reason,
    int? rating,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class __$$RestaurantRecommendationImplCopyWithImpl<$Res>
    extends
        _$RestaurantRecommendationCopyWithImpl<
          $Res,
          _$RestaurantRecommendationImpl
        >
    implements _$$RestaurantRecommendationImplCopyWith<$Res> {
  __$$RestaurantRecommendationImplCopyWithImpl(
    _$RestaurantRecommendationImpl _value,
    $Res Function(_$RestaurantRecommendationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RestaurantRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? restaurantId = null,
    Object? reason = freezed,
    Object? rating = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$RestaurantRecommendationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as int,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantRecommendationImpl implements _RestaurantRecommendation {
  const _$RestaurantRecommendationImpl({
    required this.id,
    required this.userId,
    required this.restaurantId,
    this.reason,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final int id;
  @override
  final int userId;
  @override
  final int restaurantId;
  @override
  final String? reason;
  @override
  final int? rating;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'RestaurantRecommendation(id: $id, userId: $userId, restaurantId: $restaurantId, reason: $reason, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    restaurantId,
    reason,
    rating,
    createdAt,
    updatedAt,
  );

  /// Create a copy of RestaurantRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantRecommendationImplCopyWith<_$RestaurantRecommendationImpl>
  get copyWith =>
      __$$RestaurantRecommendationImplCopyWithImpl<
        _$RestaurantRecommendationImpl
      >(this, _$identity);
}

abstract class _RestaurantRecommendation implements RestaurantRecommendation {
  const factory _RestaurantRecommendation({
    required final int id,
    required final int userId,
    required final int restaurantId,
    final String? reason,
    final int? rating,
    required final String createdAt,
    required final String updatedAt,
  }) = _$RestaurantRecommendationImpl;

  @override
  int get id;
  @override
  int get userId;
  @override
  int get restaurantId;
  @override
  String? get reason;
  @override
  int? get rating;
  @override
  String get createdAt;
  @override
  String get updatedAt;

  /// Create a copy of RestaurantRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantRecommendationImplCopyWith<_$RestaurantRecommendationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationWithRestaurant {
  RestaurantRecommendation get recommendation =>
      throw _privateConstructorUsedError;
  Restaurant get restaurant => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationWithRestaurantCopyWith<RecommendationWithRestaurant>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationWithRestaurantCopyWith<$Res> {
  factory $RecommendationWithRestaurantCopyWith(
    RecommendationWithRestaurant value,
    $Res Function(RecommendationWithRestaurant) then,
  ) =
      _$RecommendationWithRestaurantCopyWithImpl<
        $Res,
        RecommendationWithRestaurant
      >;
  @useResult
  $Res call({RestaurantRecommendation recommendation, Restaurant restaurant});

  $RestaurantRecommendationCopyWith<$Res> get recommendation;
  $RestaurantCopyWith<$Res> get restaurant;
}

/// @nodoc
class _$RecommendationWithRestaurantCopyWithImpl<
  $Res,
  $Val extends RecommendationWithRestaurant
>
    implements $RecommendationWithRestaurantCopyWith<$Res> {
  _$RecommendationWithRestaurantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recommendation = null, Object? restaurant = null}) {
    return _then(
      _value.copyWith(
            recommendation: null == recommendation
                ? _value.recommendation
                : recommendation // ignore: cast_nullable_to_non_nullable
                      as RestaurantRecommendation,
            restaurant: null == restaurant
                ? _value.restaurant
                : restaurant // ignore: cast_nullable_to_non_nullable
                      as Restaurant,
          )
          as $Val,
    );
  }

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestaurantRecommendationCopyWith<$Res> get recommendation {
    return $RestaurantRecommendationCopyWith<$Res>(_value.recommendation, (
      value,
    ) {
      return _then(_value.copyWith(recommendation: value) as $Val);
    });
  }

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestaurantCopyWith<$Res> get restaurant {
    return $RestaurantCopyWith<$Res>(_value.restaurant, (value) {
      return _then(_value.copyWith(restaurant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecommendationWithRestaurantImplCopyWith<$Res>
    implements $RecommendationWithRestaurantCopyWith<$Res> {
  factory _$$RecommendationWithRestaurantImplCopyWith(
    _$RecommendationWithRestaurantImpl value,
    $Res Function(_$RecommendationWithRestaurantImpl) then,
  ) = __$$RecommendationWithRestaurantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RestaurantRecommendation recommendation, Restaurant restaurant});

  @override
  $RestaurantRecommendationCopyWith<$Res> get recommendation;
  @override
  $RestaurantCopyWith<$Res> get restaurant;
}

/// @nodoc
class __$$RecommendationWithRestaurantImplCopyWithImpl<$Res>
    extends
        _$RecommendationWithRestaurantCopyWithImpl<
          $Res,
          _$RecommendationWithRestaurantImpl
        >
    implements _$$RecommendationWithRestaurantImplCopyWith<$Res> {
  __$$RecommendationWithRestaurantImplCopyWithImpl(
    _$RecommendationWithRestaurantImpl _value,
    $Res Function(_$RecommendationWithRestaurantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recommendation = null, Object? restaurant = null}) {
    return _then(
      _$RecommendationWithRestaurantImpl(
        recommendation: null == recommendation
            ? _value.recommendation
            : recommendation // ignore: cast_nullable_to_non_nullable
                  as RestaurantRecommendation,
        restaurant: null == restaurant
            ? _value.restaurant
            : restaurant // ignore: cast_nullable_to_non_nullable
                  as Restaurant,
      ),
    );
  }
}

/// @nodoc

class _$RecommendationWithRestaurantImpl
    implements _RecommendationWithRestaurant {
  const _$RecommendationWithRestaurantImpl({
    required this.recommendation,
    required this.restaurant,
  });

  @override
  final RestaurantRecommendation recommendation;
  @override
  final Restaurant restaurant;

  @override
  String toString() {
    return 'RecommendationWithRestaurant(recommendation: $recommendation, restaurant: $restaurant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationWithRestaurantImpl &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation) &&
            (identical(other.restaurant, restaurant) ||
                other.restaurant == restaurant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recommendation, restaurant);

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationWithRestaurantImplCopyWith<
    _$RecommendationWithRestaurantImpl
  >
  get copyWith =>
      __$$RecommendationWithRestaurantImplCopyWithImpl<
        _$RecommendationWithRestaurantImpl
      >(this, _$identity);
}

abstract class _RecommendationWithRestaurant
    implements RecommendationWithRestaurant {
  const factory _RecommendationWithRestaurant({
    required final RestaurantRecommendation recommendation,
    required final Restaurant restaurant,
  }) = _$RecommendationWithRestaurantImpl;

  @override
  RestaurantRecommendation get recommendation;
  @override
  Restaurant get restaurant;

  /// Create a copy of RecommendationWithRestaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationWithRestaurantImplCopyWith<
    _$RecommendationWithRestaurantImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
