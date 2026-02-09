import 'package:freezed_annotation/freezed_annotation.dart';

import 'recommended_dish_model.dart';

part 'restaurant_model.freezed.dart';

@freezed
class Restaurant with _$Restaurant {
  const factory Restaurant({
    required int id,
    required String name,
    required String type,
    required String distance,
    required String description,
    required String address,
    required String phone,
    required String hours,
    required double rating,
    required int reviewCount,
    required bool isOpen,
    String? imageUrl, // 改为可空类型，与API保持一致
    @Default([]) List<RecommendedDish> recommendedDishes,
    double? averagePrice,
    String? createdAt,
    String? updatedAt,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    // 处理recommendedDishes字段，可能是字符串列表或对象列表
    List<RecommendedDish> recommendedDishes = [];
    if (json['recommendedDishes'] != null) {
      final dishes = json['recommendedDishes'] as List<dynamic>;
      for (var dish in dishes) {
        if (dish is Map<String, dynamic>) {
          recommendedDishes.add(RecommendedDish.fromJson(dish));
        } else if (dish is String) {
          // 兼容旧格式，只有名称的情况
          recommendedDishes.add(RecommendedDish(
            id: 0,
            restaurantId: json['id'] as int? ?? 0,
            name: dish,
            description: '',
            price: 0.0,
            imageUrl: null,
            rating: 0.0,
            reviewCount: 0,
            spiceLevel: null,
            preparationTime: null,
            calories: null,
          ));
        }
      }
    }

    return Restaurant(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      type: json['type'] as String? ?? '',
      distance: json['distance'] as String? ?? '0km',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      hours: json['hours'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      isOpen: json['isOpen'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
      recommendedDishes: recommendedDishes,
      averagePrice: json['averagePrice'] as double?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}
