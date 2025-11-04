import 'user_model.dart';

/// 用户关注关系模型
class Follow {
  final int id;
  final int followerId; // 关注者ID
  final int followingId; // 被关注者ID
  final DateTime? createdAt;
  final User? follower; // 关注者用户信息
  final User? following; // 被关注者用户信息

  Follow({
    required this.id,
    required this.followerId,
    required this.followingId,
    this.createdAt,
    this.follower,
    this.following,
  });

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      id: json['id'] ?? 0,
      followerId: json['followerId'] ?? 0,
      followingId: json['followingId'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      follower: json['follower'] != null
          ? User.fromJson(json['follower'])
          : null,
      following: json['following'] != null
          ? User.fromJson(json['following'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'followerId': followerId,
      'followingId': followingId,
      'createdAt': createdAt?.toIso8601String(),
      if (follower != null) 'follower': follower!.toJson(),
      if (following != null) 'following': following!.toJson(),
    };
  }

  Follow copyWith({
    int? id,
    int? followerId,
    int? followingId,
    DateTime? createdAt,
    User? follower,
    User? following,
  }) {
    return Follow(
      id: id ?? this.id,
      followerId: followerId ?? this.followerId,
      followingId: followingId ?? this.followingId,
      createdAt: createdAt ?? this.createdAt,
      follower: follower ?? this.follower,
      following: following ?? this.following,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Follow &&
        other.id == id &&
        other.followerId == followerId &&
        other.followingId == followingId;
  }

  @override
  int get hashCode => id.hashCode ^ followerId.hashCode ^ followingId.hashCode;

  @override
  String toString() {
    return 'Follow{id: $id, followerId: $followerId, followingId: $followingId}';
  }
}