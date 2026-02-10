import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../data/models/restaurant_model.dart';
import '../core/services/restaurant_service.dart';
import '../core/services/api_service.dart';
import '../presentation/widgets/restaurant_info_card.dart';
import 'dart:math';

class RestaurantInfoScreen extends StatefulWidget {
  final String? restaurantId;

  const RestaurantInfoScreen({super.key, this.restaurantId});

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  final Random _random = Random();
  late Future<Restaurant> _restaurantFuture;
  late Future<List<String>> _recommendedDishesFuture;

  final List<String> _randomImages = [
    'https://picsum.photos/seed/restaurant1/400/400.jpg',
    'https://picsum.photos/seed/restaurant2/400/400.jpg',
    'https://picsum.photos/seed/restaurant3/400/400.jpg',
    'https://picsum.photos/seed/restaurant4/400/400.jpg',
    'https://picsum.photos/seed/restaurant5/400/400.jpg',
  ];

  @override
  void initState() {
    super.initState();
    final id = widget.restaurantId ?? '1';
    _restaurantFuture = RestaurantService.get(id);
    _recommendedDishesFuture = RestaurantService.getRecommendedDishes(id);
  }

  String _getRandomImageUrl() {
    return _randomImages[_random.nextInt(_randomImages.length)];
  }

  String _getRestaurantImageUrl(String? avatar) {
    if (avatar != null && avatar.isNotEmpty) {
      return ApiService.getFullImageUrl(avatar);
    }
    return _getRandomImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text('${t.restaurant.getShopInfoFailed}${snapshot.error}'),
            ),
          );
        }

        final restaurant = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
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
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRestaurantImage(restaurant),
                const SizedBox(height: 16),
                _buildHoursSection(restaurant),
                const SizedBox(height: 16),
                _buildAddressSection(restaurant),
                const SizedBox(height: 16),
                _buildPriceSection(restaurant),
                const SizedBox(height: 16),
                _buildRecommendedDishesSection(restaurant),
                const SizedBox(height: 16),
                _buildMenuSection(restaurant),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRestaurantImage(Restaurant restaurant) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          _getRestaurantImageUrl(restaurant.imageUrl),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  restaurant.name.isNotEmpty ? restaurant.name.substring(0, 1) : '',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHoursSection(Restaurant restaurant) {
    return RestaurantInfoCard(
      title: t.restaurant.businessHours,
      icon: Icons.schedule,
      child: Text(
        restaurant.hours,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAddressSection(Restaurant restaurant) {
    return RestaurantInfoCard(
      title: t.restaurant.address,
      icon: Icons.location_on,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.address,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t.restaurant.distanceFromYou(distance: restaurant.distance),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(Restaurant restaurant) {
    return RestaurantInfoCard(
      title: t.restaurant.averagePrice,
      icon: Icons.attach_money,
      child: Text(
        restaurant.averagePrice != null
            ? '¥${restaurant.averagePrice!.toStringAsFixed(0)}'
            : '¥${(restaurant.rating * 20).toStringAsFixed(0)}',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildRecommendedDishesSection(Restaurant restaurant) {
    return RestaurantInfoCard(
      title: t.restaurant.recommendedDishes,
      icon: Icons.star,
      child: FutureBuilder<List<String>>(
        future: _recommendedDishesFuture,
        builder: (context, dishesSnapshot) {
          List<String> dishes = [];

          if (dishesSnapshot.connectionState == ConnectionState.waiting) {
            dishes = [t.app.loading];
          } else if (dishesSnapshot.hasError ||
              dishesSnapshot.data == null ||
              dishesSnapshot.data!.isEmpty) {
            dishes = restaurant.recommendedDishes.isNotEmpty
                ? restaurant.recommendedDishes.map((d) => d.name).toList()
                : ['招牌炒饭', '秘制烤鸭', '麻辣香锅', '清蒸鲈鱼', '糖醋排骨'];
          } else {
            dishes = dishesSnapshot.data!;
          }

          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: dishes
                .map((dish) => _buildDishChip(dish, restaurant.id.toString()))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildMenuSection(Restaurant restaurant) {
    return RestaurantInfoCard(
      title: t.restaurant.menu,
      icon: Icons.restaurant_menu,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '查看菜品评价',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/dish_list',
                  arguments: {
                    'restaurantId': restaurant.id.toString(),
                    'restaurantName': restaurant.name,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '查看菜品列表',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishChip(String dishName, String restaurantId) {
    return InkWell(
      onTap: () => _navigateToDishReview(context, restaurantId, dishName),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dishName,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.reviews,
              size: 12,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDishReview(
    BuildContext context,
    String restaurantId,
    String dishName,
  ) {
    final menuItemId = dishName.hashCode.toSigned(32).abs().toString();

    Navigator.of(context).pushNamed(
      '/dish_reviews',
      arguments: {
        'restaurantId': restaurantId,
        'menuItemId': menuItemId,
        'itemName': dishName,
      },
    );
  }
}
