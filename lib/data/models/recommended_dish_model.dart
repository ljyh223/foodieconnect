import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommended_dish_model.freezed.dart';

@freezed
class RecommendedDish with _$RecommendedDish {
  const factory RecommendedDish({
    required int id,
    required int restaurantId,
    required String name,
    required String description,
    required double price,
    String? imageUrl,
    required double rating,
    required int reviewCount,
    String? spiceLevel,
    int? preparationTime,
    int? calories,
  }) = _RecommendedDish;

  factory RecommendedDish.fromJson(Map<String, dynamic> json) {
    return RecommendedDish(
      id: json['id'] as int? ?? 0,
      restaurantId: json['restaurantId'] as int? ?? 0,
      name: json['name'] as String? ?? json['dishName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      spiceLevel: json['spiceLevel'] as String?,
      preparationTime: json['preparationTime'] as int?,
      calories: json['calories'] as int?,
    );
  }
}
