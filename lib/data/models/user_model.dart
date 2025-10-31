class User {
  final int id;
  final String email;
  final String? phone;
  final String? displayName;
  final String? avatarUrl; // 头像URL字段，与API保持一致
  
  User({
    required this.id,
    required this.email,
    this.phone,
    this.displayName,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // 修复：id应该是int类型
      email: json['email'] ?? '',
      phone: json['phone'],
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'], // 直接使用API返回的avatarUrl字段
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
    };
  }

  User copyWith({
    int? id,
    String? email,
    String? phone,
    String? displayName,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}