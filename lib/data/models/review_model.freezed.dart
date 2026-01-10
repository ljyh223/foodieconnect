// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Review {
  int get id => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  int get restaurantId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<ReviewImage> get images => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userAvatar => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call({
    int id,
    int userId,
    int restaurantId,
    int rating,
    String comment,
    DateTime createdAt,
    DateTime updatedAt,
    List<ReviewImage> images,
    String userName,
    String userAvatar,
  });
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? restaurantId = null,
    Object? rating = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? images = null,
    Object? userName = null,
    Object? userAvatar = null,
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
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as int,
            comment: null == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            images: null == images
                ? _value.images
                : images // ignore: cast_nullable_to_non_nullable
                      as List<ReviewImage>,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            userAvatar: null == userAvatar
                ? _value.userAvatar
                : userAvatar // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
    _$ReviewImpl value,
    $Res Function(_$ReviewImpl) then,
  ) = __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int userId,
    int restaurantId,
    int rating,
    String comment,
    DateTime createdAt,
    DateTime updatedAt,
    List<ReviewImage> images,
    String userName,
    String userAvatar,
  });
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
    _$ReviewImpl _value,
    $Res Function(_$ReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? restaurantId = null,
    Object? rating = null,
    Object? comment = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? images = null,
    Object? userName = null,
    Object? userAvatar = null,
  }) {
    return _then(
      _$ReviewImpl(
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
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as int,
        comment: null == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        images: null == images
            ? _value._images
            : images // ignore: cast_nullable_to_non_nullable
                  as List<ReviewImage>,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        userAvatar: null == userAvatar
            ? _value.userAvatar
            : userAvatar // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ReviewImpl extends _Review {
  const _$ReviewImpl({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    final List<ReviewImage> images = const [],
    this.userName = '',
    this.userAvatar = '',
  }) : _images = images,
       super._();

  @override
  final int id;
  @override
  final int userId;
  @override
  final int restaurantId;
  @override
  final int rating;
  @override
  final String comment;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<ReviewImage> _images;
  @override
  @JsonKey()
  List<ReviewImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String userAvatar;

  @override
  String toString() {
    return 'Review(id: $id, userId: $userId, restaurantId: $restaurantId, rating: $rating, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt, images: $images, userName: $userName, userAvatar: $userAvatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    restaurantId,
    rating,
    comment,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_images),
    userName,
    userAvatar,
  );

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);
}

abstract class _Review extends Review {
  const factory _Review({
    required final int id,
    required final int userId,
    required final int restaurantId,
    required final int rating,
    required final String comment,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final List<ReviewImage> images,
    final String userName,
    final String userAvatar,
  }) = _$ReviewImpl;
  const _Review._() : super._();

  @override
  int get id;
  @override
  int get userId;
  @override
  int get restaurantId;
  @override
  int get rating;
  @override
  String get comment;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<ReviewImage> get images;
  @override
  String get userName;
  @override
  String get userAvatar;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReviewImage {
  int? get id => throw _privateConstructorUsedError;
  int? get reviewId => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of ReviewImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewImageCopyWith<ReviewImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewImageCopyWith<$Res> {
  factory $ReviewImageCopyWith(
    ReviewImage value,
    $Res Function(ReviewImage) then,
  ) = _$ReviewImageCopyWithImpl<$Res, ReviewImage>;
  @useResult
  $Res call({
    int? id,
    int? reviewId,
    String imageUrl,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$ReviewImageCopyWithImpl<$Res, $Val extends ReviewImage>
    implements $ReviewImageCopyWith<$Res> {
  _$ReviewImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? reviewId = freezed,
    Object? imageUrl = null,
    Object? sortOrder = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            reviewId: freezed == reviewId
                ? _value.reviewId
                : reviewId // ignore: cast_nullable_to_non_nullable
                      as int?,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: freezed == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewImageImplCopyWith<$Res>
    implements $ReviewImageCopyWith<$Res> {
  factory _$$ReviewImageImplCopyWith(
    _$ReviewImageImpl value,
    $Res Function(_$ReviewImageImpl) then,
  ) = __$$ReviewImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    int? reviewId,
    String imageUrl,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ReviewImageImplCopyWithImpl<$Res>
    extends _$ReviewImageCopyWithImpl<$Res, _$ReviewImageImpl>
    implements _$$ReviewImageImplCopyWith<$Res> {
  __$$ReviewImageImplCopyWithImpl(
    _$ReviewImageImpl _value,
    $Res Function(_$ReviewImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReviewImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? reviewId = freezed,
    Object? imageUrl = null,
    Object? sortOrder = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ReviewImageImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        reviewId: freezed == reviewId
            ? _value.reviewId
            : reviewId // ignore: cast_nullable_to_non_nullable
                  as int?,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: freezed == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ReviewImageImpl implements _ReviewImage {
  const _$ReviewImageImpl({
    this.id,
    this.reviewId,
    required this.imageUrl,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  @override
  final int? id;
  @override
  final int? reviewId;
  @override
  final String imageUrl;
  @override
  final int? sortOrder;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ReviewImage(id: $id, reviewId: $reviewId, imageUrl: $imageUrl, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    reviewId,
    imageUrl,
    sortOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of ReviewImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImageImplCopyWith<_$ReviewImageImpl> get copyWith =>
      __$$ReviewImageImplCopyWithImpl<_$ReviewImageImpl>(this, _$identity);
}

abstract class _ReviewImage implements ReviewImage {
  const factory _ReviewImage({
    final int? id,
    final int? reviewId,
    required final String imageUrl,
    final int? sortOrder,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$ReviewImageImpl;

  @override
  int? get id;
  @override
  int? get reviewId;
  @override
  String get imageUrl;
  @override
  int? get sortOrder;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ReviewImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImageImplCopyWith<_$ReviewImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
