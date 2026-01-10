import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    String? phone,
    String? displayName,
    String? avatarUrl, // 头像URL字段，与API保持一致
    String? bio, // 个人简介字段
    String? status, // 用户状态
    DateTime? createdAt, // 创建时间
    DateTime? updatedAt, // 更新时间
    List<String>? favoriteFoods, // 喜欢的食物列表
    int? followingCount, // 关注数量
    int? followersCount, // 粉丝数量
    int? recommendationsCount, // 推荐数量
    bool? isFollowing, // 当前用户是否已关注此用户
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) {
    // 处理favoriteFoods字段：API返回的是对象数组，需要提取foodName作为字符串列表
    List<String> favoriteFoodsList = [];
    if (json['favoriteFoods'] != null) {
      if (json['favoriteFoods'] is List) {
        final foodsList = json['favoriteFoods'] as List;
        favoriteFoodsList = foodsList
            .where(
              (item) =>
                  item is Map<String, dynamic> && item['foodName'] is String,
            )
            .map((item) => item['foodName'] as String)
            .toList();
      } else if (json['favoriteFoods'] is List<String>) {
        // 兼容直接返回字符串列表的情况
        favoriteFoodsList = List<String>.from(json['favoriteFoods']);
      }
    }

    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      favoriteFoods: favoriteFoodsList,
      followingCount: json['followingCount'] as int?,
      followersCount: json['followersCount'] as int?,
      recommendationsCount: json['recommendationsCount'] as int?,
      isFollowing: json['isFollowing'] as bool?,
    );
  }
}
