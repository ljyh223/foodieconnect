import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../presentation/providers/restaurant_provider.dart';
import '../presentation/providers/recommendation_provider.dart';
import '../presentation/widgets/home_recommendation_section.dart';
import '../core/services/api_service.dart';
import 'dart:math';
import 'dart:async';

class ShopsScreen extends StatefulWidget {
  const ShopsScreen({super.key});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Random _random = Random();
  Timer? _debounce;

  // 随机在线图片列表
  final List<String> _randomImages = [
    'https://wp.upx8.com/api.php',
    'https://wp.upx8.com/api.php',
    'https://wp.upx8.com/api.php',
    'https://wp.upx8.com/api.php',
  ];

  @override
  void initState() {
    super.initState();
    // Trigger fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(
        context,
        listen: false,
      ).fetchRestaurants();
      Provider.of<RecommendationProvider>(
        context,
        listen: false,
      ).getHomeRecommendations();
    });
    
    // 添加搜索监听器
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _debounce?.cancel();
    super.dispose();
  }

  /// 搜索输入变化处理（带防抖）
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text.trim();
      Provider.of<RestaurantProvider>(
        context,
        listen: false,
      ).fetchRestaurants(keyword: query);
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
    Navigator.pushNamed(context, '/user_profile');
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
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: t.app.search,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              isDense: true, // 减少垂直空间
            ),
          ),
        ),
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
                t.restaurant.noRestaurants,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            );
          }

          // 创建一个ListView，将推荐用户组件和餐厅列表合并
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount:
                restaurants.length + 1, // +1 for the recommendation section
            itemBuilder: (context, index) {
              // 第一个item是推荐用户组件
              if (index == 0) {
                return Column(
                  children: [
                    const HomeRecommendationSection(),
                    const SizedBox(height: 16), // 添加间距
                  ],
                );
              }

              // 其他item是餐厅
              final restaurant =
                  restaurants[index -
                      1]; // -1 because first item is recommendation section
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
                          _getRestaurantImageUrl(restaurant.imageUrl),
                          width:
                              MediaQuery.of(context).size.width *
                              0.67, // 占宽度2/3
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.67,
                              height: 200,
                              color: Colors.grey[200],
                              child: Center(
                                child: Text(
                                  restaurant.name.isNotEmpty
                                      ? restaurant.name.substring(0, 1)
                                      : '',
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
                                  restaurant.isOpen ? t.app.open : t.app.closed,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: restaurant.isOpen
                                        ? Colors.green
                                        : Colors.grey,
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
                              children: restaurant.recommendedDishes
                                  .take(3)
                                  .map((dish) {
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
                                  })
                                  .toList(),
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
