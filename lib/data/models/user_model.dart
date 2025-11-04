class User {
  final int id;
  final String email;
  final String? phone;
  final String? displayName;
  final String? avatarUrl; // 头像URL字段，与API保持一致
  final String? bio; // 个人简介字段
  final String? status; // 用户状态
  final DateTime? createdAt; // 创建时间
  final DateTime? updatedAt; // 更新时间
  final List<String>? favoriteFoods; // 喜欢的食物列表
  final int? followingCount; // 关注数量
  final int? followersCount; // 粉丝数量
  final int? recommendationsCount; // 推荐数量
  final bool? isFollowing; // 当前用户是否已关注此用户
  
  User({
    required this.id,
    required this.email,
    this.phone,
    this.displayName,
    this.avatarUrl,
    this.bio,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.favoriteFoods,
    this.followingCount,
    this.followersCount,
    this.recommendationsCount,
    this.isFollowing,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // 处理favoriteFoods字段：API返回的是对象数组，需要提取foodName作为字符串列表
    List<String> favoriteFoodsList = [];
    if (json['favoriteFoods'] != null) {
      if (json['favoriteFoods'] is List) {
        final foodsList = json['favoriteFoods'] as List;
        favoriteFoodsList = foodsList
            .where((item) => item is Map<String, dynamic> && item['foodName'] is String)
            .map((item) => item['foodName'] as String)
            .toList();
      } else if (json['favoriteFoods'] is List<String>) {
        // 兼容直接返回字符串列表的情况
        favoriteFoodsList = List<String>.from(json['favoriteFoods']);
      }
    }

    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      phone: json['phone']?.toString(), // 确保phone转换为字符串
      displayName: json['displayName']?.toString(), // 确保displayName转换为字符串
      avatarUrl: json['avatarUrl']?.toString(), // 确保avatarUrl转换为字符串
      bio: json['bio']?.toString(), // 确保bio转换为字符串
      status: json['status']?.toString(), // 确保status转换为字符串
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'].toString()) : null,
      favoriteFoods: favoriteFoodsList,
      followingCount: json['followingCount'] as int?,
      followersCount: json['followersCount'] as int?,
      recommendationsCount: json['recommendationsCount'] as int?,
      isFollowing: json['isFollowing'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'favoriteFoods': favoriteFoods,
      'followingCount': followingCount,
      'followersCount': followersCount,
      'recommendationsCount': recommendationsCount,
      'isFollowing': isFollowing,
    };
  }

  User copyWith({
    int? id,
    String? email,
    String? phone,
    String? displayName,
    String? avatarUrl,
    String? bio,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? favoriteFoods,
    int? followingCount,
    int? followersCount,
    int? recommendationsCount,
    bool? isFollowing,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favoriteFoods: favoriteFoods ?? this.favoriteFoods,
      followingCount: followingCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
      recommendationsCount: recommendationsCount ?? this.recommendationsCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}