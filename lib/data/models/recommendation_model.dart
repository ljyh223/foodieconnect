import 'package:freezed_annotation/freezed_annotation.dart';
import 'restaurant_model.dart';

part 'recommendation_model.freezed.dart';

@freezed
class RestaurantRecommendation with _$RestaurantRecommendation {
  const factory RestaurantRecommendation({
    required int id,
    required int userId,
    required int restaurantId,
    String? reason,
    int? rating,
    required String createdAt,
    required String updatedAt,
  }) = _RestaurantRecommendation;

  factory RestaurantRecommendation.fromJson(Map<String, dynamic> json) {
    return RestaurantRecommendation(
      id: json['id'] as int,
      userId: json['userId'] as int,
      restaurantId: json['restaurantId'] as int,
      reason: json['reason'] as String?,
      rating: json['rating'] as int?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

@freezed
class RecommendationWithRestaurant with _$RecommendationWithRestaurant {
  const factory RecommendationWithRestaurant({
    required RestaurantRecommendation recommendation,
    required Restaurant restaurant,
  }) = _RecommendationWithRestaurant;
}
