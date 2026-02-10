import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/api_service.dart';
import '../core/services/user_service.dart';
import '../core/services/follow_service.dart';
import '../core/services/restaurant_recommendation_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/user_model.dart';
import '../data/models/recommendation_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/recommended_restaurants_grid.dart';

/// 其他用户个人主页界面
class OtherUserProfileScreen extends StatefulWidget {
  final int userId;

  const OtherUserProfileScreen({super.key, required this.userId});

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  User? _user;
  List<RecommendationWithRestaurant> _userRecommendations = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// 加载用户数据
  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 加载用户信息，包含喜欢的食物和关注状态
      await Future.wait([_loadUserInfo(), _loadUserRecommendations()]);

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

  /// 加载用户基本信息
  Future<User> _loadUserInfo() async {
    _user = await UserService.getUserInfo(widget.userId);
    return _user!;
  }

  /// 加载用户的推荐餐厅列表
  Future<void> _loadUserRecommendations() async {
    try {
      _userRecommendations =
          await RestaurantRecommendationService.getUserRecommendations(
            widget.userId,
          );
    } catch (e) {
      // 如果获取失败，使用空列表
      _userRecommendations = [];
    }
  }

  /// 关注/取消关注用户
  Future<void> _toggleFollow() async {
    if (_user == null) return;

    try {
      final currentUserId = await AuthService.getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('未找到当前用户信息');
      }

      // 更新本地状态
      final newIsFollowing = !(_user!.isFollowing ?? false);
      setState(() {
        _user = _user!.copyWith(isFollowing: newIsFollowing);
      });

      // 调用API
      if (newIsFollowing) {
        await FollowService.followUser(
          followerId: currentUserId,
          followingId: widget.userId,
        );
      } else {
        await FollowService.unfollowUser(
          followerId: currentUserId,
          followingId: widget.userId,
        );
      }
    } catch (e) {
      // 如果操作失败，恢复原状态
      setState(() {
        _user = _user!.copyWith(isFollowing: _user!.isFollowing);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              (_user!.isFollowing ?? false)
                  ? t.profile.disconnectFailed
                  : t.profile.connectFailed,
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: t.profile.otherProfileTitle,
        showBackButton: true,
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
          _buildUserInfo(),
          const SizedBox(height: 24),

          // 喜好食物标签
          _buildFoodPreferences(),
          const SizedBox(height: 32),

          // 连接按钮
          _buildConnectButton(),
          const SizedBox(height: 32),

          // 用户推荐餐厅
          if (_userRecommendations.isNotEmpty)
            RecommendedRestaurantsGrid(
              recommendations: _userRecommendations,
              title: t.profile.userRecommendedRestaurants,
              onFollowingTap: () {},
            ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 头像（左侧）
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.outline, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: _user!.avatarUrl != null && _user!.avatarUrl!.isNotEmpty
                ? Image.network(
                    ApiService.getFullImageUrl(_user!.avatarUrl!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildDefaultAvatar();
                    },
                  )
                : _buildDefaultAvatar(),
          ),
        ),
        const SizedBox(width: 16), // 水平间距
        // 昵称和邮箱（右侧，垂直排列）
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 左对齐
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中对齐（与头像中部对齐）
          children: [
            Text(
              _user!.displayName ?? t.profile.unknownUser,
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4), // 减小昵称与邮箱间距更紧凑（可选）
            Text(
              _user!.email,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Center(
      child: Text(
        _user!.displayName?.isNotEmpty == true
            ? _user!.displayName!.substring(0, 1).toUpperCase()
            : 'U',
        style: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

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

  Widget _buildConnectButton() {
    final isFollowing = _user?.isFollowing ?? false;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _toggleFollow,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? AppColors.surface : AppColors.primary,
          foregroundColor: isFollowing
              ? AppColors.primary
              : AppColors.onPrimary,
          side: BorderSide(
            color: isFollowing ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          isFollowing ? t.profile.connected : t.profile.connect,
          style: AppTextStyles.button.copyWith(
            color: isFollowing ? AppColors.primary : AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}
