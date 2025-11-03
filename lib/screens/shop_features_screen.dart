import 'package:flutter/material.dart';
import 'package:tabletalk/core/services/localization_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../core/services/restaurant_service.dart';
import '../data/models/restaurant_model.dart';

class ShopFeaturesScreen extends StatefulWidget {
  final String? restaurantId;

  const ShopFeaturesScreen({super.key, this.restaurantId});

  @override
  State<ShopFeaturesScreen> createState() => _ShopFeaturesScreenState();
}

class _ShopFeaturesScreenState extends State<ShopFeaturesScreen> {
  late Future<Restaurant> _restaurantFuture;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRestaurant();
  }

  Future<void> _loadRestaurant() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final restaurantId = widget.restaurantId ?? (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String?;
      if (restaurantId != null) {
        _restaurantFuture = RestaurantService.get(restaurantId);
      } else {
        throw Exception('缺少餐厅ID');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigateToReviews() {
      Navigator.pushNamed(
        context,
        '/reviews',
        arguments: {'restaurantId': widget.restaurantId},
      );
    }

    void navigateToChatVerify() {
      Navigator.pushNamed(
        context,
        '/chat_verify',
      );
    }

    void navigateToStaff() {
      Navigator.pushNamed(
        context,
        '/staff',
        arguments: {'restaurantId': widget.restaurantId},
      );
    }

    void navigateToMenu() {
      // 菜单功能尚未实现
    }


    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: LocalizationService.I.shopFeatures,
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildContent(navigateToReviews, navigateToChatVerify, navigateToStaff, navigateToMenu),
        ),
      ),
    );
  }


  Widget _buildContent(
    VoidCallback navigateToReviews,
    VoidCallback navigateToChatVerify,
    VoidCallback navigateToStaff,
    VoidCallback navigateToMenu,
  ) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${LocalizationService.I.loadingFailed}：$_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadRestaurant,
              child: Text(LocalizationService.I.retry),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${LocalizationService.I.getShopInfoFailed}${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadRestaurant,
                  child: Text(LocalizationService.I.retry),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return FeatureCard(
                  icon: Icons.star,
                  title: LocalizationService.I.viewComments,
                  subtitle: LocalizationService.I.viewUserReviews,
                  onTap: navigateToReviews,
                );
              case 1:
                return FeatureCard(
                  icon: Icons.chat,
                  title: LocalizationService.I.instantChat,
                  subtitle: LocalizationService.I.chatWithStaffRealtime,
                  onTap: navigateToChatVerify,
                );
              case 2:
                return FeatureCard(
                  icon: Icons.people,
                  title: LocalizationService.I.viewStaff,
                  subtitle: LocalizationService.I.onlineStaffList,
                  onTap: navigateToStaff,
                );
              case 3:
                return FeatureCard(
                  icon: Icons.restaurant_menu,
                  title: LocalizationService.I.viewMenu,
                  subtitle: LocalizationService.I.browseAllDishes,
                  onTap: navigateToMenu,
                );
              default:
                return Container();
            }
          },
        );
      },
    );
  }
  }

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Row(
            children:
            [
              Icon(
                icon,
                size: 32,
                color: AppColors.primary,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    title,
                    style: AppTextStyles.titleMedium,
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}