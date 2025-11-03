
import 'package:flutter/material.dart';
import 'package:tabletalk/generated/app_localizations.dart';
import '../data/models/restaurant_model.dart';
import '../core/services/restaurant_service.dart';
import '../core/services/api_service.dart';
import '../presentation/widgets/card_widget.dart';
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
  
  // 随机在线图片列表
  final List<String> _randomImages = [
    'https://picsum.photos/seed/restaurant1/400/400.jpg',
    'https://picsum.photos/seed/restaurant2/400/400.jpg',
    'https://picsum.photos/seed/restaurant3/400/400.jpg',
    'https://picsum.photos/seed/restaurant4/400/400.jpg',
    'https://picsum.photos/seed/restaurant5/400/400.jpg',
    'https://picsum.photos/seed/restaurant6/400/400.jpg',
    'https://picsum.photos/seed/restaurant7/400/400.jpg',
    'https://picsum.photos/seed/restaurant8/400/400.jpg',
  ];

  @override
  void initState() {
    super.initState();
    final id = widget.restaurantId ?? '1';
    _restaurantFuture = RestaurantService.get(id);
    _recommendedDishesFuture = RestaurantService.getRecommendedDishes(id);
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

  /// 获取餐厅菜单
  Future<void> _getRestaurantMenu(BuildContext context, String restaurantId) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      
      // 调用API获取菜单
      final menuData = await RestaurantService.getMenu(restaurantId);
      
      // 关闭加载指示器
      Navigator.of(context).pop();
      
      // TODO: 实现菜单显示界面
      // 这里可以导航到一个新的菜单页面或显示底部弹窗
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).menuFeatureInDevelopment)),
      );
    } catch (e) {
      // 关闭加载指示器（如果还在显示）
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppLocalizations.of(context).getMenuFailed}$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.restaurantId ?? (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String? ?? '1';

    return FutureBuilder<Restaurant>(
      future: _restaurantFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('${AppLocalizations.of(context).getShopInfoFailed}${snapshot.error}')));
        }

        final restaurant = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.grey[50],
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
                // 餐厅图片 - 圆角正方形
                CardWidget(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          AppLocalizations.of(context).restaurantImages,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            _getRestaurantImageUrl(restaurant.avatar),
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
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 营业时间
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).businessHours,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              restaurant.hours,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 餐厅地址
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).address,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.address,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  AppLocalizations.of(context).distanceFromYou(restaurant.distance),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 人均消费
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).averagePrice,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            // 如果API返回了人均消费价格，使用实际价格；否则基于评分估算
                            restaurant.averagePrice != null
                                ? '¥${restaurant.averagePrice!.toStringAsFixed(0)}'
                                : '¥${(restaurant.rating * 20).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 推荐菜品
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).recommendedDishes,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FutureBuilder<List<String>>(
                              future: _recommendedDishesFuture,
                              builder: (context, dishesSnapshot) {
                                List<String> dishes = [];
                                
                                if (dishesSnapshot.connectionState == ConnectionState.waiting) {
                                  dishes = [AppLocalizations.of(context).loading];
                                } else if (dishesSnapshot.hasError || dishesSnapshot.data == null || dishesSnapshot.data!.isEmpty) {
                                  // 如果API调用失败或没有数据，使用餐厅模型中的推荐菜品或默认菜品
                                  dishes = restaurant.recommendedDishes.isNotEmpty
                                      ? restaurant.recommendedDishes
                                      : [
                                          '招牌炒饭',
                                          '秘制烤鸭',
                                          '麻辣香锅',
                                          '清蒸鲈鱼',
                                          '糖醋排骨',
                                        ];
                                } else {
                                  dishes = dishesSnapshot.data!;
                                }
                                
                                return Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: dishes.map((dish) => _buildDishChip(dish)).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // 菜单
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).menu,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context).viewFullMenu,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // 调用获取餐厅菜单的方法
                                      _getRestaurantMenu(context, restaurant.id.toString());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context).viewMenu,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 构建菜品标签
  Widget _buildDishChip(String dishName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        dishName,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

