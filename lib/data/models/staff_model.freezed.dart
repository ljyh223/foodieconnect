// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Staff {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get experience => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String? get restaurantId => throw _privateConstructorUsedError;
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // 头像URL字段，与API保持一致
  List<String> get skills => throw _privateConstructorUsedError;
  List<String> get languages => throw _privateConstructorUsedError;
  List<StaffReview> get reviews => throw _privateConstructorUsedError;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call({
    String id,
    String name,
    String position,
    String status,
    String experience,
    double rating,
    String? restaurantId,
    String? avatarUrl,
    List<String> skills,
    List<String> languages,
    List<StaffReview> reviews,
  });
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? status = null,
    Object? experience = null,
    Object? rating = null,
    Object? restaurantId = freezed,
    Object? avatarUrl = freezed,
    Object? skills = null,
    Object? languages = null,
    Object? reviews = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            experience: null == experience
                ? _value.experience
                : experience // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            restaurantId: freezed == restaurantId
                ? _value.restaurantId
                : restaurantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            skills: null == skills
                ? _value.skills
                : skills // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            languages: null == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as List<StaffReview>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
    _$StaffImpl value,
    $Res Function(_$StaffImpl) then,
  ) = __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String position,
    String status,
    String experience,
    double rating,
    String? restaurantId,
    String? avatarUrl,
    List<String> skills,
    List<String> languages,
    List<StaffReview> reviews,
  });
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
    _$StaffImpl _value,
    $Res Function(_$StaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? position = null,
    Object? status = null,
    Object? experience = null,
    Object? rating = null,
    Object? restaurantId = freezed,
    Object? avatarUrl = freezed,
    Object? skills = null,
    Object? languages = null,
    Object? reviews = null,
  }) {
    return _then(
      _$StaffImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        experience: null == experience
            ? _value.experience
            : experience // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        restaurantId: freezed == restaurantId
            ? _value.restaurantId
            : restaurantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        skills: null == skills
            ? _value._skills
            : skills // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        languages: null == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        reviews: null == reviews
            ? _value._reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as List<StaffReview>,
      ),
    );
  }
}

/// @nodoc

class _$StaffImpl implements _Staff {
  const _$StaffImpl({
    required this.id,
    required this.name,
    required this.position,
    required this.status,
    required this.experience,
    required this.rating,
    this.restaurantId,
    this.avatarUrl,
    final List<String> skills = const [],
    final List<String> languages = const [],
    final List<StaffReview> reviews = const [],
  }) : _skills = skills,
       _languages = languages,
       _reviews = reviews;

  @override
  final String id;
  @override
  final String name;
  @override
  final String position;
  @override
  final String status;
  @override
  final String experience;
  @override
  final double rating;
  @override
  final String? restaurantId;
  @override
  final String? avatarUrl;
  // 头像URL字段，与API保持一致
  final List<String> _skills;
  // 头像URL字段，与API保持一致
  @override
  @JsonKey()
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<String> _languages;
  @override
  @JsonKey()
  List<String> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  final List<StaffReview> _reviews;
  @override
  @JsonKey()
  List<StaffReview> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  String toString() {
    return 'Staff(id: $id, name: $name, position: $position, status: $status, experience: $experience, rating: $rating, restaurantId: $restaurantId, avatarUrl: $avatarUrl, skills: $skills, languages: $languages, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.restaurantId, restaurantId) ||
                other.restaurantId == restaurantId) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    position,
    status,
    experience,
    rating,
    restaurantId,
    avatarUrl,
    const DeepCollectionEquality().hash(_skills),
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_reviews),
  );

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);
}

abstract class _Staff implements Staff {
  const factory _Staff({
    required final String id,
    required final String name,
    required final String position,
    required final String status,
    required final String experience,
    required final double rating,
    final String? restaurantId,
    final String? avatarUrl,
    final List<String> skills,
    final List<String> languages,
    final List<StaffReview> reviews,
  }) = _$StaffImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get position;
  @override
  String get status;
  @override
  String get experience;
  @override
  double get rating;
  @override
  String? get restaurantId;
  @override
  String? get avatarUrl; // 头像URL字段，与API保持一致
  @override
  List<String> get skills;
  @override
  List<String> get languages;
  @override
  List<StaffReview> get reviews;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StaffReview {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String get staffId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get userAvatar => throw _privateConstructorUsedError;

  /// Create a copy of StaffReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffReviewCopyWith<StaffReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffReviewCopyWith<$Res> {
  factory $StaffReviewCopyWith(
    StaffReview value,
    $Res Function(StaffReview) then,
  ) = _$StaffReviewCopyWithImpl<$Res, StaffReview>;
  @useResult
  $Res call({
    String id,
    String userName,
    String content,
    double rating,
    DateTime createdAt,
    DateTime? updatedAt,
    String staffId,
    String userId,
    String? userAvatar,
  });
}

/// @nodoc
class _$StaffReviewCopyWithImpl<$Res, $Val extends StaffReview>
    implements $StaffReviewCopyWith<$Res> {
  _$StaffReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StaffReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? content = null,
    Object? rating = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? staffId = null,
    Object? userId = null,
    Object? userAvatar = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            staffId: null == staffId
                ? _value.staffId
                : staffId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userAvatar: freezed == userAvatar
                ? _value.userAvatar
                : userAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffReviewImplCopyWith<$Res>
    implements $StaffReviewCopyWith<$Res> {
  factory _$$StaffReviewImplCopyWith(
    _$StaffReviewImpl value,
    $Res Function(_$StaffReviewImpl) then,
  ) = __$$StaffReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userName,
    String content,
    double rating,
    DateTime createdAt,
    DateTime? updatedAt,
    String staffId,
    String userId,
    String? userAvatar,
  });
}

/// @nodoc
class __$$StaffReviewImplCopyWithImpl<$Res>
    extends _$StaffReviewCopyWithImpl<$Res, _$StaffReviewImpl>
    implements _$$StaffReviewImplCopyWith<$Res> {
  __$$StaffReviewImplCopyWithImpl(
    _$StaffReviewImpl _value,
    $Res Function(_$StaffReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StaffReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? content = null,
    Object? rating = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? staffId = null,
    Object? userId = null,
    Object? userAvatar = freezed,
  }) {
    return _then(
      _$StaffReviewImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        staffId: null == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userAvatar: freezed == userAvatar
            ? _value.userAvatar
            : userAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StaffReviewImpl implements _StaffReview {
  const _$StaffReviewImpl({
    required this.id,
    required this.userName,
    required this.content,
    required this.rating,
    required this.createdAt,
    this.updatedAt,
    required this.staffId,
    required this.userId,
    this.userAvatar,
  });

  @override
  final String id;
  @override
  final String userName;
  @override
  final String content;
  @override
  final double rating;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String staffId;
  @override
  final String userId;
  @override
  final String? userAvatar;

  @override
  String toString() {
    return 'StaffReview(id: $id, userName: $userName, content: $content, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt, staffId: $staffId, userId: $userId, userAvatar: $userAvatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userName,
    content,
    rating,
    createdAt,
    updatedAt,
    staffId,
    userId,
    userAvatar,
  );

  /// Create a copy of StaffReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffReviewImplCopyWith<_$StaffReviewImpl> get copyWith =>
      __$$StaffReviewImplCopyWithImpl<_$StaffReviewImpl>(this, _$identity);
}

abstract class _StaffReview implements StaffReview {
  const factory _StaffReview({
    required final String id,
    required final String userName,
    required final String content,
    required final double rating,
    required final DateTime createdAt,
    final DateTime? updatedAt,
    required final String staffId,
    required final String userId,
    final String? userAvatar,
  }) = _$StaffReviewImpl;

  @override
  String get id;
  @override
  String get userName;
  @override
  String get content;
  @override
  double get rating;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String get staffId;
  @override
  String get userId;
  @override
  String? get userAvatar;

  /// Create a copy of StaffReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffReviewImplCopyWith<_$StaffReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
