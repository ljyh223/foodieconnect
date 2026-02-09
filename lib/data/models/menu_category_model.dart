import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_category_model.freezed.dart';

@freezed
class MenuCategory with _$MenuCategory {
  const factory MenuCategory({
    required int id,
    required int restaurantId,
    required String name,
    String? description,
    int? sortOrder,
    required bool isActive,
    String? createdAt,
    String? updatedAt,
  }) = _MenuCategory;

  const MenuCategory._();

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'] ?? 0,
      restaurantId: json['restaurantId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      sortOrder: json['sortOrder'],
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
