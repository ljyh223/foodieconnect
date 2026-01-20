import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/auth_service.dart';
import '../core/services/user_service.dart';
import '../core/services/restaurant_recommendation_service.dart';
import '../data/models/user_model.dart';
import '../data/models/recommendation_model.dart';
import '../presentation/widgets/user_profile_header.dart';
import '../presentation/widgets/user_bio_section.dart';
import '../presentation/widgets/recommended_restaurants_grid.dart';

/// 用户个人资料查看界面
/// 只显示用户信息，不包含编辑功能
class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  User? _user;
  List<RecommendationWithRestaurant> _myRecommendations = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// 加载当前用户数据
  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 并行加载用户信息和我的推荐餐厅
      await Future.wait([_loadUserInfo(), _loadMyRecommendations()]);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// 加载当前用户基本信息
  Future<User> _loadUserInfo() async {
    try {
      // 使用AuthService获取当前用户信息
      _user = await AuthService.me();
      return _user!;
    } catch (e) {
      // 如果API调用失败，尝试使用UserService
      try {
        final currentUserId = await AuthService.getCurrentUserId();
        if (currentUserId != null) {
          _user = await UserService.getUserInfo(currentUserId);
          return _user!;
        }
      } catch (secondError) {
        throw Exception(t.profile.userNotFound);
      }

      throw Exception(t.profile.userNotFound);
    }
  }

  /// 加载我的推荐餐厅列表
  Future<void> _loadMyRecommendations() async {
    try {
      _myRecommendations =
          await RestaurantRecommendationService.getMyRecommendations();
    } catch (e) {
      // 如果获取失败，使用空列表
      _myRecommendations = [];
    }
  }

  /// 导航到编辑个人资料页面
  void _navigateToEditProfile() {
    if (_user != null) {
      Navigator.pushNamed(context, '/edit_profile').then((result) {
        // 从编辑页面返回后刷新数据
        _loadUserData();
      });
    } else {
      // 如果用户数据还没有加载完成，等待加载完成后再导航
      _loadUserData().then((_) {
        if (_user != null) {
          Navigator.pushNamed(
            context,
            '/edit_profile',
            arguments: {'user': _user},
          ).then((result) {
            // 从编辑页面返回后刷新数据
            _loadUserData();
          });
        }
      });
    }
  }

  /// 导航到关注列表
  void _navigateToFollowingList() {
    if (_user != null) {
      Navigator.pushNamed(
        context,
        '/following_list',
        arguments: {'userId': _user!.id},
      );
    }
  }

  /// 导航到设置页面
  void _navigateToSettings() {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(t.profile.profileTitle),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _navigateToSettings,
            tooltip: '设置',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEditProfile,
            tooltip: '编辑资料',
          ),
        ],
      ),
      body: SafeArea(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.profile.loadingFailed, style: AppTextStyles.titleMedium),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUserData,
              child: Text(t.profile.retry),
            ),
          ],
        ),
      );
    }

    if (_user == null) {
      return Center(
        child: Text(t.profile.userNotFound, style: AppTextStyles.titleMedium),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户头像和基本信息
          UserProfileHeader(user: _user!, isEditing: false),
          const SizedBox(height: 24),

          // 喜好食物标签
          _buildFoodPreferences(),
          const SizedBox(height: 24),

          // 个人简介
          UserBioSection(bio: _user!.bio, isEditing: false),
          const SizedBox(height: 24),

          // 我的推荐餐厅
          if (_myRecommendations.isNotEmpty)
            RecommendedRestaurantsGrid(
              recommendations: _myRecommendations,
              title: t.profile.myRecommendedRestaurants,
              onFollowingTap: _navigateToFollowingList,
              onDeleteRecommendation: (recommendationId) async {
                try {
                  await RestaurantRecommendationService.deleteRecommendation(
                    recommendationId,
                  );
                  setState(() {
                    _myRecommendations.removeWhere(
                      (r) => r.recommendation.id == recommendationId,
                    );
                  });
                  if (mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('删除推荐成功')));
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('删除推荐失败: $e')));
                  }
                }
              },
            ),
        ],
      ),
    );
  }

  /// 构建喜好食物部分
  Widget _buildFoodPreferences() {
    final favoriteFoods = _user?.favoriteFoods ?? [];

    if (favoriteFoods.isEmpty) {
      return Container(
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
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.profile.foodPreferences, style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: favoriteFoods.map((foodName) {
            return _buildFoodPreferenceTag(foodName);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFoodPreferenceTag(String foodName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      child: Text(
        foodName,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
