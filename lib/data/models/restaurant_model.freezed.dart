// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Restaurant {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get hours => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  bool get isOpen => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError; // 改为可空类型，与API保持一致
  List<String> get recommendedDishes => throw _privateConstructorUsedError;
  double? get averagePrice => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RestaurantCopyWith<Restaurant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantCopyWith<$Res> {
  factory $RestaurantCopyWith(
    Restaurant value,
    $Res Function(Restaurant) then,
  ) = _$RestaurantCopyWithImpl<$Res, Restaurant>;
  @useResult
  $Res call({
    int id,
    String name,
    String type,
    String distance,
    String description,
    String address,
    String phone,
    String hours,
    double rating,
    int reviewCount,
    bool isOpen,
    String? imageUrl,
    List<String> recommendedDishes,
    double? averagePrice,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$RestaurantCopyWithImpl<$Res, $Val extends Restaurant>
    implements $RestaurantCopyWith<$Res> {
  _$RestaurantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? distance = null,
    Object? description = null,
    Object? address = null,
    Object? phone = null,
    Object? hours = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isOpen = null,
    Object? imageUrl = freezed,
    Object? recommendedDishes = null,
    Object? averagePrice = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            distance: null == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            hours: null == hours
                ? _value.hours
                : hours // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isOpen: null == isOpen
                ? _value.isOpen
                : isOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            recommendedDishes: null == recommendedDishes
                ? _value.recommendedDishes
                : recommendedDishes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            averagePrice: freezed == averagePrice
                ? _value.averagePrice
                : averagePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RestaurantImplCopyWith<$Res>
    implements $RestaurantCopyWith<$Res> {
  factory _$$RestaurantImplCopyWith(
    _$RestaurantImpl value,
    $Res Function(_$RestaurantImpl) then,
  ) = __$$RestaurantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String type,
    String distance,
    String description,
    String address,
    String phone,
    String hours,
    double rating,
    int reviewCount,
    bool isOpen,
    String? imageUrl,
    List<String> recommendedDishes,
    double? averagePrice,
    String? createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$RestaurantImplCopyWithImpl<$Res>
    extends _$RestaurantCopyWithImpl<$Res, _$RestaurantImpl>
    implements _$$RestaurantImplCopyWith<$Res> {
  __$$RestaurantImplCopyWithImpl(
    _$RestaurantImpl _value,
    $Res Function(_$RestaurantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? distance = null,
    Object? description = null,
    Object? address = null,
    Object? phone = null,
    Object? hours = null,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isOpen = null,
    Object? imageUrl = freezed,
    Object? recommendedDishes = null,
    Object? averagePrice = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$RestaurantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        distance: null == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        hours: null == hours
            ? _value.hours
            : hours // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isOpen: null == isOpen
            ? _value.isOpen
            : isOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        recommendedDishes: null == recommendedDishes
            ? _value._recommendedDishes
            : recommendedDishes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        averagePrice: freezed == averagePrice
            ? _value.averagePrice
            : averagePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$RestaurantImpl implements _Restaurant {
  const _$RestaurantImpl({
    required this.id,
    required this.name,
    required this.type,
    required this.distance,
    required this.description,
    required this.address,
    required this.phone,
    required this.hours,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    this.imageUrl,
    final List<String> recommendedDishes = const [],
    this.averagePrice,
    this.createdAt,
    this.updatedAt,
  }) : _recommendedDishes = recommendedDishes;

  @override
  final int id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String distance;
  @override
  final String description;
  @override
  final String address;
  @override
  final String phone;
  @override
  final String hours;
  @override
  final double rating;
  @override
  final int reviewCount;
  @override
  final bool isOpen;
  @override
  final String? imageUrl;
  // 改为可空类型，与API保持一致
  final List<String> _recommendedDishes;
  // 改为可空类型，与API保持一致
  @override
  @JsonKey()
  List<String> get recommendedDishes {
    if (_recommendedDishes is EqualUnmodifiableListView)
      return _recommendedDishes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedDishes);
  }

  @override
  final double? averagePrice;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'Restaurant(id: $id, name: $name, type: $type, distance: $distance, description: $description, address: $address, phone: $phone, hours: $hours, rating: $rating, reviewCount: $reviewCount, isOpen: $isOpen, imageUrl: $imageUrl, recommendedDishes: $recommendedDishes, averagePrice: $averagePrice, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._recommendedDishes,
              _recommendedDishes,
            ) &&
            (identical(other.averagePrice, averagePrice) ||
                other.averagePrice == averagePrice) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    type,
    distance,
    description,
    address,
    phone,
    hours,
    rating,
    reviewCount,
    isOpen,
    imageUrl,
    const DeepCollectionEquality().hash(_recommendedDishes),
    averagePrice,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      __$$RestaurantImplCopyWithImpl<_$RestaurantImpl>(this, _$identity);
}

abstract class _Restaurant implements Restaurant {
  const factory _Restaurant({
    required final int id,
    required final String name,
    required final String type,
    required final String distance,
    required final String description,
    required final String address,
    required final String phone,
    required final String hours,
    required final double rating,
    required final int reviewCount,
    required final bool isOpen,
    final String? imageUrl,
    final List<String> recommendedDishes,
    final double? averagePrice,
    final String? createdAt,
    final String? updatedAt,
  }) = _$RestaurantImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get distance;
  @override
  String get description;
  @override
  String get address;
  @override
  String get phone;
  @override
  String get hours;
  @override
  double get rating;
  @override
  int get reviewCount;
  @override
  bool get isOpen;
  @override
  String? get imageUrl; // 改为可空类型，与API保持一致
  @override
  List<String> get recommendedDishes;
  @override
  double? get averagePrice;
  @override
  String? get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of Restaurant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RestaurantImplCopyWith<_$RestaurantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
