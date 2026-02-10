import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../presentation/providers/restaurant_provider.dart';
import '../presentation/providers/recommendation_provider.dart';
import '../presentation/providers/language_provider.dart';
import '../screens/shops_screen.dart';
import '../screens/recommendations_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/following_list_screen.dart';

/// 主页面 - 底部Tab导航
class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // 初始化数据
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 监听LanguageProvider的变化，确保语言切换时Tab文本更新
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          body: TabBarView(
            controller: _tabController,
            children: [
              // 首页内容 - 餐厅列表
              const ShopsScreen(),
              // 推荐发现内容
              const RecommendationsScreen(),
              // 关注列表内容
              const FollowingListScreen(),
              // 个人中心内容
              const UserProfileScreen(),
            ],
          ),
          bottomNavigationBar: TabBar(
            controller: _tabController,
            tabs: [
              // 首页Tab - 餐厅列表
              Tab(icon: const Icon(Icons.store), text: t.app.home),
              // 发现Tab
              Tab(
                icon: const Icon(Icons.people_alt_outlined),
                text: t.app.recommendations,
              ),
              // 连接列表Tab
              Tab(
                icon: const Icon(Icons.favorite_outline),
                text: t.app.connectionsList,
              ),
              // 个人中心Tab
              Tab(icon: const Icon(Icons.person), text: t.app.userProfile),
            ],
          ),
        );
      },
    );
  }
}
