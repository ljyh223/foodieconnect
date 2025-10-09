class User {
  final int id;
  final String email;
  final String? phone;
  final String? displayName;
  final String? avatarUrl;
  
  User({
    required this.id,
    required this.email,
    this.phone,
    this.displayName,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'],
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