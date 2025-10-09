import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/models/restaurant_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../core/services/restaurant_service.dart';

class ShopDetailScreen extends StatelessWidget {
  final String? restaurantId;

  const ShopDetailScreen({super.key, this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final id = restaurantId ?? (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String? ?? '1';

    return FutureBuilder<Restaurant>(
      future: RestaurantService.get(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('获取店铺信息失败：${snapshot.error}')));
        }

        final restaurant = snapshot.data!;

        void navigateToShopFeatures() {
          Navigator.pushNamed(
            context,
            '/shop_features',
            arguments: {'restaurantId': restaurant.id},
          );
        }

        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBarWidget(
            title: restaurant.name,
            showBackButton: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    restaurant.avatar,
                                    style: TextStyle(
                                      color: AppColors.onPrimaryContainer,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.name,
                                    style: AppTextStyles.titleMedium,
                                  ),
                                  Text(
                                    '${restaurant.type} · ${restaurant.isOpen ? '营业中' : '已打烊'}',
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            restaurant.description,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '店铺信息',
                            style: AppTextStyles.titleMedium,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.location_on, size: 20),
                            title: Text(restaurant.address),
                            subtitle: Text('距离您${restaurant.distance}'),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          ListTile(
                            leading: const Icon(Icons.schedule, size: 20),
                            title: Text('营业时间：${restaurant.hours}'),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone, size: 20),
                            title: Text('电话：${restaurant.phone}'),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '推荐菜品',
                            style: AppTextStyles.titleMedium,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: restaurant.recommendedDishes.map((dish) {
                              return Chip(
                                label: Text(dish),
                                backgroundColor: AppColors.surfaceVariant,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: navigateToShopFeatures,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.store, color: AppColors.onPrimary),
                          const SizedBox(width: 8),
                          Text(
                            '进入店铺',
                            style: TextStyle(
                              color: AppColors.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}