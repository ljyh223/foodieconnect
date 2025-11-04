/// 用户喜好食物模型
class FoodPreference {
  final int id;
  final int userId;
  final String foodName;
  final String? category; // 食物分类，如：中餐、西餐、日料等
  final String? description; // 喜好描述
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FoodPreference({
    required this.id,
    required this.userId,
    required this.foodName,
    this.category,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory FoodPreference.fromJson(Map<String, dynamic> json) {
    return FoodPreference(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      foodName: json['foodName'] ?? '',
      category: json['category'],
      description: json['description'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'foodName': foodName,
      'category': category,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  FoodPreference copyWith({
    int? id,
    int? userId,
    String? foodName,
    String? category,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FoodPreference(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodName: foodName ?? this.foodName,
      category: category ?? this.category,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FoodPreference &&
        other.id == id &&
        other.userId == userId &&
        other.foodName == foodName;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ foodName.hashCode;

  @override
  String toString() {
    return 'FoodPreference{id: $id, userId: $userId, foodName: $foodName, category: $category}';
  }
}