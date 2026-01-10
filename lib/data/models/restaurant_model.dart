import 'package:freezed_annotation/freezed_annotation.dart';

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
    @Default([]) List<String> recommendedDishes,
    double? averagePrice,
    String? createdAt,
    String? updatedAt,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    // 处理recommendedDishes字段，可能是字符串列表或对象列表
    List<String> recommendedDishes = [];
    if (json['recommendedDishes'] != null) {
      final dishes = json['recommendedDishes'] as List<dynamic>;
      for (var dish in dishes) {
        if (dish is String) {
          recommendedDishes.add(dish);
        } else if (dish is Map<String, dynamic>) {
          // 如果是对象，尝试提取name字段
          final name = dish['name'] ?? dish['dishName'] ?? '';
          if (name.isNotEmpty) {
            recommendedDishes.add(name);
          }
        }
      }
    }

    return Restaurant(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      distance: json['distance'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      hours: json['hours'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isOpen: json['isOpen'] as bool,
      imageUrl: json['imageUrl'] as String?,
      recommendedDishes: recommendedDishes,
      averagePrice: json['averagePrice'] as double?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}
