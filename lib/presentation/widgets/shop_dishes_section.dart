import 'package:flutter/material.dart';

import '../../core/services/api_service.dart';
import '../../data/models/recommended_dish_model.dart';

/// 菜品评价组件
class ShopDishesSection extends StatelessWidget {
  final String restaurantId;
  final List<RecommendedDish> recommendedDishes;
  final VoidCallback onTap;

  const ShopDishesSection({
    super.key,
    required this.restaurantId,
    required this.recommendedDishes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 取前3个推荐菜品
    final dishes = recommendedDishes.take(3).toList();

    if (dishes.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Dish Reviews',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: dishes.map((dish) {
                return _buildDishItem(context, dish);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDishItem(BuildContext context, RecommendedDish dish) {
    return GestureDetector(
      onTap: () => _navigateToDishDetail(context, dish),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDishImage(dish),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDishInfo(dish),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDishInfo(RecommendedDish dish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dish.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dish.description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (dish.price > 0) ...[
          const SizedBox(height: 4),
          Text(
            '¥${dish.price.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDishImage(RecommendedDish dish) {
    String displayImageUrl = '';
    if (dish.imageUrl != null && dish.imageUrl!.isNotEmpty) {
      displayImageUrl = ApiService.getFullImageUrl(dish.imageUrl!);
    }

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: displayImageUrl.isNotEmpty
            ? Image.network(
                displayImageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      dish.name.isNotEmpty ? dish.name.substring(0, 1) : '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  dish.name.isNotEmpty ? dish.name.substring(0, 1) : '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
      ),
    );
  }

  void _navigateToDishDetail(BuildContext context, RecommendedDish dish) {
    Navigator.pushNamed(
      context,
      '/dish_detail',
      arguments: {
        'restaurantId': restaurantId,
        'dish': dish,
      },
    );
  }
}
