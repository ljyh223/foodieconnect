// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_dish_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecommendedDish {
  int get id => throw _privateConstructorUsedError;
  int get restaurantId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  String? get spiceLevel => throw _privateConstructorUsedError;
  int? get preparationTime => throw _privateConstructorUsedError;
  int? get calories => throw _privateConstructorUsedError;

  /// Create a copy of RecommendedDish
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendedDishCopyWith<RecommendedDish> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendedDishCopyWith<$Res> {
  factory $RecommendedDishCopyWith(
    RecommendedDish value,
    $Res Function(RecommendedDish) then,
  ) = _$RecommendedDishCopyWithImpl<$Res, RecommendedDish>;
  @useResult
  $Res call({
    int id,
    int restaurantId,
    String name,
    String description,
    double price,
    String? imageUrl,
    double rating,
    int reviewCount,
    String? spiceLevel,
    int? preparationTime,
    int? calories,
  });
}

/// @nodoc
class _$RecommendedDishCopyWithImpl<$Res, $Val extends RecommendedDish>
    implements $RecommendedDishCopyWith<$Res> {
  _$RecommendedDishCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendedDish
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? spiceLevel = freezed,
    Object? preparationTime = freezed,
    Object? calories = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            restaurantId: null == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            spiceLevel: freezed == spiceLevel
                ? _value.spiceLevel
                : spiceLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            preparationTime: freezed == preparationTime
                ? _value.preparationTime
                : preparationTime // ignore: cast_nullable_to_non_nullable
                      as int?,
            calories: freezed == calories
                ? _value.calories
                : calories // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendedDishImplCopyWith<$Res>
    implements $RecommendedDishCopyWith<$Res> {
  factory _$$RecommendedDishImplCopyWith(
    _$RecommendedDishImpl value,
    $Res Function(_$RecommendedDishImpl) then,
  ) = __$$RecommendedDishImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int restaurantId,
    String name,
    String description,
    double price,
    String? imageUrl,
    double rating,
    int reviewCount,
    String? spiceLevel,
    int? preparationTime,
    int? calories,
  });
}

/// @nodoc
class __$$RecommendedDishImplCopyWithImpl<$Res>
    extends _$RecommendedDishCopyWithImpl<$Res, _$RecommendedDishImpl>
    implements _$$RecommendedDishImplCopyWith<$Res> {
  __$$RecommendedDishImplCopyWithImpl(
    _$RecommendedDishImpl _value,
    $Res Function(_$RecommendedDishImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendedDish
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? restaurantId = null,
    Object? name = null,
    Object? description = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? spiceLevel = freezed,
    Object? preparationTime = freezed,
    Object? calories = freezed,
  }) {
    return _then(
      _$RecommendedDishImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        restaurantId: null == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        spiceLevel: freezed == spiceLevel
            ? _value.spiceLevel
            : spiceLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        preparationTime: freezed == preparationTime
            ? _value.preparationTime
            : preparationTime // ignore: cast_nullable_to_non_nullable
                  as int?,
        calories: freezed == calories
            ? _value.calories
            : calories // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$RecommendedDishImpl implements _RecommendedDish {
  const _$RecommendedDishImpl({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.rating,
    required this.reviewCount,
    this.spiceLevel,
    this.preparationTime,
    this.calories,
  });

  @override
  final int id;
  @override
  final int restaurantId;
  @override
  final String name;
  @override
  final String description;
  @override
  final double price;
  @override
  final String? imageUrl;
  @override
  final double rating;
  @override
  final int reviewCount;
  @override
  final String? spiceLevel;
  @override
  final int? preparationTime;
  @override
  final int? calories;

  @override
  String toString() {
    return 'RecommendedDish(id: $id, restaurantId: $restaurantId, name: $name, description: $description, price: $price, imageUrl: $imageUrl, rating: $rating, reviewCount: $reviewCount, spiceLevel: $spiceLevel, preparationTime: $preparationTime, calories: $calories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendedDishImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.spiceLevel, spiceLevel) ||
                other.spiceLevel == spiceLevel) &&
            (identical(other.preparationTime, preparationTime) ||
                other.preparationTime == preparationTime) &&
            (identical(other.calories, calories) ||
                other.calories == calories));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    restaurantId,
    name,
    description,
    price,
    imageUrl,
    rating,
    reviewCount,
    spiceLevel,
    preparationTime,
    calories,
  );

  /// Create a copy of RecommendedDish
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendedDishImplCopyWith<_$RecommendedDishImpl> get copyWith =>
      __$$RecommendedDishImplCopyWithImpl<_$RecommendedDishImpl>(
        this,
        _$identity,
      );
}

abstract class _RecommendedDish implements RecommendedDish {
  const factory _RecommendedDish({
    required final int id,
    required final int restaurantId,
    required final String name,
    required final String description,
    required final double price,
    final String? imageUrl,
    required final double rating,
    required final int reviewCount,
    final String? spiceLevel,
    final int? preparationTime,
    final int? calories,
  }) = _$RecommendedDishImpl;

  @override
  int get id;
  @override
  int get restaurantId;
  @override
  String get name;
  @override
  String get description;
  @override
  double get price;
  @override
  String? get imageUrl;
  @override
  double get rating;
  @override
  int get reviewCount;
  @override
  String? get spiceLevel;
  @override
  int? get preparationTime;
  @override
  int? get calories;

  /// Create a copy of RecommendedDish
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendedDishImplCopyWith<_$RecommendedDishImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
