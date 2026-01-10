// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Follow {
  int get id => throw _privateConstructorUsedError;
  int get followerId => throw _privateConstructorUsedError; // 关注者ID
  int get followingId => throw _privateConstructorUsedError; // 被关注者ID
  DateTime? get createdAt => throw _privateConstructorUsedError;
  User? get follower => throw _privateConstructorUsedError; // 关注者用户信息
  User? get following => throw _privateConstructorUsedError;

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FollowCopyWith<Follow> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowCopyWith<$Res> {
  factory $FollowCopyWith(Follow value, $Res Function(Follow) then) =
      _$FollowCopyWithImpl<$Res, Follow>;
  @useResult
  $Res call({
    int id,
    int followerId,
    int followingId,
    DateTime? createdAt,
    User? follower,
    User? following,
  });

  $UserCopyWith<$Res>? get follower;
  $UserCopyWith<$Res>? get following;
}

/// @nodoc
class _$FollowCopyWithImpl<$Res, $Val extends Follow>
    implements $FollowCopyWith<$Res> {
  _$FollowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? followerId = null,
    Object? followingId = null,
    Object? createdAt = freezed,
    Object? follower = freezed,
    Object? following = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            followerId: null == followerId
                ? _value.followerId
                : followerId // ignore: cast_nullable_to_non_nullable
                      as int,
            followingId: null == followingId
                ? _value.followingId
                : followingId // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            follower: freezed == follower
                ? _value.follower
                : follower // ignore: cast_nullable_to_non_nullable
                      as User?,
            following: freezed == following
                ? _value.following
                : following // ignore: cast_nullable_to_non_nullable
                      as User?,
          )
          as $Val,
    );
  }

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get follower {
    if (_value.follower == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.follower!, (value) {
      return _then(_value.copyWith(follower: value) as $Val);
    });
  }

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get following {
    if (_value.following == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.following!, (value) {
      return _then(_value.copyWith(following: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FollowImplCopyWith<$Res> implements $FollowCopyWith<$Res> {
  factory _$$FollowImplCopyWith(
    _$FollowImpl value,
    $Res Function(_$FollowImpl) then,
  ) = __$$FollowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int followerId,
    int followingId,
    DateTime? createdAt,
    User? follower,
    User? following,
  });

  @override
  $UserCopyWith<$Res>? get follower;
  @override
  $UserCopyWith<$Res>? get following;
}

/// @nodoc
class __$$FollowImplCopyWithImpl<$Res>
    extends _$FollowCopyWithImpl<$Res, _$FollowImpl>
    implements _$$FollowImplCopyWith<$Res> {
  __$$FollowImplCopyWithImpl(
    _$FollowImpl _value,
    $Res Function(_$FollowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? followerId = null,
    Object? followingId = null,
    Object? createdAt = freezed,
    Object? follower = freezed,
    Object? following = freezed,
  }) {
    return _then(
      _$FollowImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        followerId: null == followerId
            ? _value.followerId
            : followerId // ignore: cast_nullable_to_non_nullable
                  as int,
        followingId: null == followingId
            ? _value.followingId
            : followingId // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        follower: freezed == follower
            ? _value.follower
            : follower // ignore: cast_nullable_to_non_nullable
                  as User?,
        following: freezed == following
            ? _value.following
            : following // ignore: cast_nullable_to_non_nullable
                  as User?,
      ),
    );
  }
}

/// @nodoc

class _$FollowImpl implements _Follow {
  const _$FollowImpl({
    required this.id,
    required this.followerId,
    required this.followingId,
    this.createdAt,
    this.follower,
    this.following,
  });

  @override
  final int id;
  @override
  final int followerId;
  // 关注者ID
  @override
  final int followingId;
  // 被关注者ID
  @override
  final DateTime? createdAt;
  @override
  final User? follower;
  // 关注者用户信息
  @override
  final User? following;

  @override
  String toString() {
    return 'Follow(id: $id, followerId: $followerId, followingId: $followingId, createdAt: $createdAt, follower: $follower, following: $following)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.followerId, followerId) ||
                other.followerId == followerId) &&
            (identical(other.followingId, followingId) ||
                other.followingId == followingId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.follower, follower) ||
                other.follower == follower) &&
            (identical(other.following, following) ||
                other.following == following));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    followerId,
    followingId,
    createdAt,
    follower,
    following,
  );

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowImplCopyWith<_$FollowImpl> get copyWith =>
      __$$FollowImplCopyWithImpl<_$FollowImpl>(this, _$identity);
}

abstract class _Follow implements Follow {
  const factory _Follow({
    required final int id,
    required final int followerId,
    required final int followingId,
    final DateTime? createdAt,
    final User? follower,
    final User? following,
  }) = _$FollowImpl;

  @override
  int get id;
  @override
  int get followerId; // 关注者ID
  @override
  int get followingId; // 被关注者ID
  @override
  DateTime? get createdAt;
  @override
  User? get follower; // 关注者用户信息
  @override
  User? get following;

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FollowImplCopyWith<_$FollowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
