import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../data/models/restaurant_model.dart';
import '../core/services/restaurant_service.dart';
import '../core/services/staff_service.dart';
import '../core/services/restaurant_recommendation_service.dart';
import '../presentation/widgets/shop_detail_header.dart';
import '../presentation/widgets/shop_basic_info_section.dart';
import '../presentation/widgets/shop_reviews_section.dart';
import '../presentation/widgets/shop_dishes_section.dart';
import '../presentation/widgets/shop_chat_section.dart';
import '../presentation/widgets/shop_staff_section.dart';

class ShopDetailScreen extends StatelessWidget {
  final String? restaurantId;

  const ShopDetailScreen({super.key, this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final restaurantId = _getRestaurantId(context);

    return FutureBuilder<Restaurant>(
      future: RestaurantService.get(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          debugPrint('获取店铺信息失败：${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Text('${t.restaurant.getShopInfoFailed}${snapshot.error}'),
            ),
          );
        }

        final restaurant = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context, restaurant),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 餐厅大图
                  ShopDetailHeader(
                    imageUrl: restaurant.imageUrl,
                    name: restaurant.name,
                  ),

                  const SizedBox(height: 16),

                  // 基础信息模块
                  ShopBasicInfoSection(
                    hours: restaurant.hours,
                    phone: restaurant.phone,
                    rating: restaurant.rating,
                    reviewCount: restaurant.reviewCount,
                    onTap: () => _navigateToRestaurantInfo(context, restaurant.id.toString()),
                  ),

                  const SizedBox(height: 16),

                  // 餐厅评价模块
                  _buildReviewsSection(context, restaurant.id.toString()),

                  const SizedBox(height: 16),

                  // 菜品评价模块
                  ShopDishesSection(
                    restaurantId: restaurant.id.toString(),
                    recommendedDishes: restaurant.recommendedDishes,
                    onTap: () => _navigateToDishReviews(context, restaurant.id.toString(), restaurant.name),
                  ),

                  const SizedBox(height: 16),

                  // 聊天室模块
                  ShopChatSection(
                    onEnterChat: () => _navigateToChat(context, restaurant.id.toString()),
                  ),

                  const SizedBox(height: 16),

                  // 店员评价模块
                  ShopStaffSection(
                    restaurantId: restaurant.id.toString(),
                    loadStaff: () => StaffService.listByRestaurant(restaurant.id.toString()),
                    onViewAllStaff: () => _navigateToStaff(context, restaurant.id.toString()),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getRestaurantId(BuildContext context) {
    return restaurantId ??
        (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String? ??
        '1';
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Restaurant restaurant) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        restaurant.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.recommend, color: Colors.black),
          onPressed: () => _recommendRestaurant(context, restaurant.id.toString()),
          tooltip: t.restaurant.recommendRestaurant,
        ),
      ],
    );
  }

  Widget _buildReviewsSection(BuildContext context, String restaurantId) {
    return ShopReviewsSection(
      restaurantId: restaurantId,
      onTap: () => _navigateToReviews(context, restaurantId),
    );
  }

  void _navigateToReviews(BuildContext context, String restaurantId) {
    Navigator.pushNamed(
      context,
      '/reviews',
      arguments: {'restaurantId': restaurantId},
    );
  }

  void _navigateToChat(BuildContext context, String restaurantId) {
    Navigator.pushNamed(
      context,
      '/chat_verify',
      arguments: {'restaurantId': restaurantId},
    );
  }

  void _navigateToStaff(BuildContext context, String restaurantId) {
    Navigator.pushNamed(
      context,
      '/staff',
      arguments: {'restaurantId': restaurantId},
    );
  }

  void _navigateToRestaurantInfo(BuildContext context, String restaurantId) {
    Navigator.pushNamed(
      context,
      '/restaurant_info',
      arguments: {'restaurantId': restaurantId},
    );
  }

  void _navigateToDishReviews(BuildContext context, String restaurantId, String restaurantName) {
    Navigator.pushNamed(
      context,
      '/dish_list',
      arguments: {
        'restaurantId': restaurantId,
        'restaurantName': restaurantName,
      },
    );
  }

  Future<void> _recommendRestaurant(BuildContext context, String restaurantId) async {
    try {
      await RestaurantRecommendationService.recommendRestaurant(
        restaurantId: restaurantId,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.restaurant.recommendSuccess)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${t.restaurant.recommendFailed}$e')),
        );
      }
    }
  }
}
