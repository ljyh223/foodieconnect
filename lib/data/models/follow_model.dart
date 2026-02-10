import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'follow_model.freezed.dart';

/// 用户关注关系模型
@freezed
class Follow with _$Follow {
  const factory Follow({
    required int id,
    required int followerId, // 关注者ID
    required int followingId, // 被关注者ID
    DateTime? createdAt,
    User? follower, // 关注者用户信息
    User? following, // 被关注者用户信息
  }) = _Follow;

  factory Follow.fromJson(Map<String, dynamic> json) {
    // 手动处理嵌套的User对象，增加null安全性
    return Follow(
      id: json['id'] as int? ?? 0,
      followerId: json['followerId'] as int? ?? 0,
      followingId: json['followingId'] as int? ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      follower: json['follower'] != null
          ? User.fromJson(json['follower'] as Map<String, dynamic>)
          : null,
      following: json['following'] != null
          ? User.fromJson(json['following'] as Map<String, dynamic>)
          : null,
    );
  }
}
