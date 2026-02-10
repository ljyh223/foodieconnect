import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/recommendation_model.dart';
import 'recommended_restaurant_card.dart';

/// 推荐餐厅网格组件
class RecommendedRestaurantsGrid extends StatelessWidget {
  final List<RecommendationWithRestaurant> recommendations;
  final String? title;
  final VoidCallback? onFollowingTap;
  final Function(int)? onDeleteRecommendation;

  const RecommendedRestaurantsGrid({
    super.key,
    required this.recommendations,
    this.title,
    this.onFollowingTap,
    this.onDeleteRecommendation,
  });

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? t.profile.recommendedRestaurants,
              style: AppTextStyles.titleMedium,
            ),
            if (onFollowingTap != null)
              TextButton(
                onPressed: onFollowingTap,
                child: Text(
                  t.profile.connected,
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
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final recommendationWithRestaurant = recommendations[index];
            final restaurant = recommendationWithRestaurant.restaurant;
            final recommendation = recommendationWithRestaurant.recommendation;
            return RecommendedRestaurantCard(
              recommendationWithRestaurant: recommendationWithRestaurant,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/shop_detail',
                  arguments: {'restaurantId': restaurant.id.toString()},
                );
              },
              onDelete: onDeleteRecommendation != null
                  ? () => onDeleteRecommendation!(recommendation.id)
                  : null,
            );
          },
        ),
      ],
    );
  }
}
