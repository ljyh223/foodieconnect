import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/restaurant_model.dart';
import 'recommended_restaurant_card.dart';

/// 推荐餐厅网格组件
class RecommendedRestaurantsGrid extends StatelessWidget {
  final List<Restaurant> restaurants;
  final VoidCallback? onFollowingTap;

  const RecommendedRestaurantsGrid({
    super.key,
    required this.restaurants,
    this.onFollowingTap,
  });

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.profile.recommendedRestaurants,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.outline),
            ),
            child: Text(
              t.profile.noFoodPreferences,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.profile.recommendedRestaurants,
              style: AppTextStyles.titleMedium,
            ),
            if (onFollowingTap != null)
              TextButton(
                onPressed: onFollowingTap,
                child: Text(
                  t.profile.following,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return RecommendedRestaurantCard(restaurant: restaurant);
          },
        ),
      ],
    );
  }
}
