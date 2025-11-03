import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk/core/services/localization_service.dart';
import '../presentation/providers/restaurant_provider.dart';
import '../core/services/api_service.dart';
import 'dart:math';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Random _random = Random();
  
  // 随机在线图片列表
  final List<String> _randomImages = [
    'https://picsum.photos/seed/restaurant1/200/200.jpg',
    'https://picsum.photos/seed/restaurant2/200/200.jpg',
    'https://picsum.photos/seed/restaurant3/200/200.jpg',
    'https://picsum.photos/seed/restaurant4/200/200.jpg',
    'https://picsum.photos/seed/restaurant5/200/200.jpg',
    'https://picsum.photos/seed/restaurant6/200/200.jpg',
    'https://picsum.photos/seed/restaurant7/200/200.jpg',
    'https://picsum.photos/seed/restaurant8/200/200.jpg',
  ];
  
  @override
  void initState() {
    super.initState();
    // Trigger fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
    });
  }

  /// 获取随机图片URL
  String _getRandomImageUrl() {
    return _randomImages[_random.nextInt(_randomImages.length)];
  }

  /// 获取餐厅图片URL，如果没有则使用随机图片
  String _getRestaurantImageUrl(String? avatar) {
    if (avatar != null && avatar.isNotEmpty) {
      return ApiService.getFullImageUrl(avatar);
    }
    return _getRandomImageUrl();
  }

  void navigateToShopDetail(String restaurantId) {
    Navigator.pushNamed(
      context,
      '/shop_detail',
      arguments: {'restaurantId': restaurantId},
    );
  }

  void navigateToUserProfile() {
    // 导航到用户个人资料页面
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // 移除返回按钮
        titleSpacing: 0,
        title: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: LocalizationService.I.search,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                isDense: true, // 减少垂直空间
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings, color: Colors.grey),
              iconSize: 20,
              tooltip: LocalizationService.I.settings,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: navigateToUserProfile,
              icon: const Icon(Icons.person, color: Colors.grey),
              iconSize: 20, // 减小图标大小
            ),
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                provider.error!,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          final restaurants = provider.restaurants;

          if (restaurants.isEmpty) {
            return Center(
              child: Text(
                LocalizationService.I.noRestaurants,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return GestureDetector(
                onTap: () => navigateToShopDetail(restaurant.id.toString()),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 餐厅大图，占宽度2/3
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _getRestaurantImageUrl(restaurant.avatar),
                          width: MediaQuery.of(context).size.width * 0.67, // 占宽度2/3
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.67,
                              height: 200,
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
                      const SizedBox(height: 12),
                      
                      // 餐厅名称和评分在同一排
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              restaurant.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                restaurant.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // 餐厅详情
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 餐厅类型和距离
                          Row(
                            children: [
                              Text(
                                restaurant.type,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '•',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                restaurant.distance,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: restaurant.isOpen
                                      ? Colors.green.withValues(alpha: 0.1)
                                      : Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  restaurant.isOpen ? LocalizationService.I.open : LocalizationService.I.closed,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: restaurant.isOpen ? Colors.green : Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          
                          // 餐厅介绍
                          Text(
                            restaurant.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          // 推荐菜品
                          if (restaurant.recommendedDishes.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: restaurant.recommendedDishes.take(3).map((dish) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    dish,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}