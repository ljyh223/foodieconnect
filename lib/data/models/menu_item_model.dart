import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_model.freezed.dart';

/// 菜品数据模型
@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required int id,
    required int restaurantId,
    required int categoryId,
    required String name,
    String? description,
    required double price,
    double? originalPrice,
    String? imageUrl,
    required bool isAvailable,
    required bool isRecommended,
    int? sortOrder,
    String? nutritionInfo,
    String? allergenInfo,
    String? spiceLevel,
    int? preparationTime,
    int? calories,
    double? rating,
    int? reviewCount,
    String? createdAt,
    String? updatedAt,
  }) = _MenuItem;

  // 添加私有构造函数以支持getter方法
  const MenuItem._();

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? 0,
      restaurantId: json['restaurantId'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      price: json['price'] is num
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] is num
              ? (json['originalPrice'] as num).toDouble()
              : double.tryParse(json['originalPrice'].toString()))
          : null,
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'] ?? true,
      isRecommended: json['isRecommended'] ?? false,
      sortOrder: json['sortOrder'],
      nutritionInfo: json['nutritionInfo'],
      allergenInfo: json['allergenInfo'],
      spiceLevel: json['spiceLevel'],
      preparationTime: json['preparationTime'],
      calories: json['calories'],
      rating: json['rating'] != null
          ? (json['rating'] is num
              ? (json['rating'] as num).toDouble()
              : double.tryParse(json['rating'].toString()))
          : null,
      reviewCount: json['reviewCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
