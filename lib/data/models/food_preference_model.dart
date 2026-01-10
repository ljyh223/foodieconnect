import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_preference_model.freezed.dart';

@freezed
class FoodPreference with _$FoodPreference {
  const factory FoodPreference({
    required int id,
    required int userId,
    required String foodName,
    String? category, // 食物分类，如：中餐、西餐、日料等
    String? description, // 喜好描述
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FoodPreference;

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
}
