import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/recommended_dish_model.dart';

class DishListItemWidget extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onTap;

  const DishListItemWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左侧图片 60x60
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 60,
                height: 60,
                child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? Image.network(
                        ApiService.getFullImageUrl(item.imageUrl!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Center(
                              child: Text(
                                item.name.isNotEmpty ? item.name[0] : '?',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            item.name.isNotEmpty ? item.name[0] : '?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // 右侧信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 菜品名称
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // 描述
                  if (item.description != null && item.description!.isNotEmpty)
                    Text(
                      item.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 6),
                  // 价格和评分
                  Row(
                    children: [
                      // 价格
                      Text(
                        '¥${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      if (item.rating != null && item.rating! > 0) ...[
                        const SizedBox(width: 12),
                        // 评分星星
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        // 评分数值
                        Text(
                          item.rating!.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        if (item.reviewCount != null && item.reviewCount! > 0) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(${item.reviewCount}条评价)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 转换 MenuItem 为 RecommendedDish
  static RecommendedDish convertToRecommendedDish(MenuItem item) {
    return RecommendedDish(
      id: item.id,
      restaurantId: item.restaurantId,
      name: item.name,
      description: item.description ?? '',
      price: item.price,
      imageUrl: item.imageUrl,
      rating: item.rating ?? 0.0,
      reviewCount: item.reviewCount ?? 0,
      spiceLevel: item.spiceLevel,
      preparationTime: item.preparationTime,
      calories: item.calories,
    );
  }
}
