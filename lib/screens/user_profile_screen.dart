import 'package:flutter/material.dart';
import 'package:tabletalk/core/services/api_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/auth_service.dart';
import '../core/services/food_preference_service.dart';
import '../core/services/follow_service.dart';
import '../core/services/review_service.dart';
import '../data/models/user_model.dart';
import '../data/models/food_preference_model.dart';
import '../data/models/restaurant_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/user_profile_header.dart';
import '../presentation/widgets/food_preference_tags.dart';
import '../presentation/widgets/user_bio_section.dart';
import '../presentation/widgets/follow_button.dart';
import '../presentation/widgets/recommended_restaurants_grid.dart';

/// 重构后的详细个人主页界面（自己和他人共用）
class UserProfileScreen extends StatefulWidget {
  final int? userId; // 如果为null，则显示当前用户的个人主页

  const UserProfileScreen({
    super.key,
    this.userId,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? _user;
  List<FoodPreference> _foodPreferences = [];
  List<Restaurant> _recommendedRestaurants = [];
  bool _isLoading = true;
  bool _isEditing = false;
  bool _isFollowing = false;
  String? _error;
  int? _currentUserId;

  // 编辑控制器
  late TextEditingController _displayNameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadUserData();
  }

  void _initializeControllers() {
    _displayNameController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  /// 加载用户数据
  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 获取当前用户ID
      _currentUserId = await AuthService.getCurrentUserId();
      if (_currentUserId == null) {
        throw Exception('未找到当前用户信息');
      }

      // 确定要查看的用户ID
      final targetUserId = widget.userId ?? _currentUserId!;

      // 并行加载用户信息、喜好食物、推荐餐厅和关注状态
      await Future.wait([
        _loadUserInfo(targetUserId),
        _loadFoodPreferences(targetUserId),
        _loadRecommendedRestaurants(targetUserId),
        if (targetUserId != _currentUserId) _checkFollowStatus(targetUserId),
      ]);

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
  Future<User> _loadUserInfo(int userId) async {
    try {
      // 如果是当前用户，使用AuthService.me()
      if (userId == _currentUserId) {
        _user = await AuthService.me();
      } else {
        // 其他用户，调用用户信息API
        final response = await ApiService().get('/users/$userId');
        final data = response['data'] as Map<String, dynamic>;
        _user = User.fromJson(data);
      }
      
      // 初始化编辑控制器
      _displayNameController.text = _user!.displayName ?? '';
      _bioController.text = _user!.bio ?? '';
      
      return _user!;
    } catch (e) {
      // 如果API不存在，使用模拟数据
      _user = User(
        id: userId,
        email: 'user$userId@example.com',
        displayName: '用户$userId',
        avatarUrl: null,
        bio: '这是用户$userId的个人简介，喜欢美食和旅行。',
      );
      
      _displayNameController.text = _user!.displayName ?? '';
      _bioController.text = _user!.bio ?? '';
      
      return _user!;
    }
  }

  /// 加载用户喜好食物
  Future<void> _loadFoodPreferences(int userId) async {
    try {
      _foodPreferences = await FoodPreferenceService.getUserPreferences(userId);
    } catch (e) {
      // 如果获取失败，使用模拟数据
      _foodPreferences = [
        FoodPreference(id: 1, userId: userId, foodName: '川菜'),
        FoodPreference(id: 2, userId: userId, foodName: '日料'),
        FoodPreference(id: 3, userId: userId, foodName: '甜品'),
        FoodPreference(id: 4, userId: userId, foodName: '咖啡'),
      ];
    }
  }

  /// 加载推荐餐厅
  Future<void> _loadRecommendedRestaurants(int userId) async {
    try {
      _recommendedRestaurants = await ReviewService.getRecommendedRestaurants(userId);
    } catch (e) {
      // 如果获取失败，使用空列表
      _recommendedRestaurants = [];
    }
  }

  /// 检查关注状态
  Future<void> _checkFollowStatus(int userId) async {
    try {
      _isFollowing = await FollowService.isFollowing(
        followerId: _currentUserId!,
        followingId: userId,
      );
    } catch (e) {
      // 如果检查失败，默认为未关注
      _isFollowing = false;
    }
  }

  /// 切换编辑模式
  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  /// 保存用户信息
  Future<void> _saveUserInfo() async {
    try {
      // 这里应该调用更新用户信息的API
      // await ApiService.put('/users/${_user!.id}', body: {
      //   'displayName': _displayNameController.text,
      //   'bio': _bioController.text,
      // });

      // 更新本地用户信息
      setState(() {
        _user = _user!.copyWith(
          displayName: _displayNameController.text,
          bio: _bioController.text,
        );
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('保存成功'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('保存失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  /// 关注/取消关注用户
  Future<void> _toggleFollow() async {
    if (_currentUserId == null || _user == null) return;

    try {
      setState(() {
        _isFollowing = !_isFollowing;
      });

      if (_isFollowing) {
        await FollowService.followUser(
          followerId: _currentUserId!,
          followingId: _user!.id,
        );
      } else {
        await FollowService.unfollowUser(
          followerId: _currentUserId!,
          followingId: _user!.id,
        );
      }
    } catch (e) {
      // 如果操作失败，恢复原状态
      setState(() {
        _isFollowing = !_isFollowing;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isFollowing ? '关注失败' : '取消关注失败'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  /// 导航到关注列表
  void _navigateToFollowingList() {
    Navigator.pushNamed(
      context,
      '/following_list',
      arguments: {'userId': _user!.id},
    );
  }

  /// 导航到餐厅详情
  void _navigateToRestaurant(Restaurant restaurant) {
    Navigator.pushNamed(
      context,
      '/shop_detail',
      arguments: {'restaurantId': restaurant.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = _user?.id == _currentUserId;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: isCurrentUser ? '个人主页' : '用户主页',
        showBackButton: true,
        actions: isCurrentUser ? [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEditMode,
            )
          else
            TextButton(
              onPressed: _saveUserInfo,
              child: const Text('保存'),
            ),
        ] : null,
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '加载失败',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUserData,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_user == null) {
      return Center(
        child: Text(
          '用户不存在',
          style: AppTextStyles.titleMedium,
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户头像和基本信息
          UserProfileHeader(
            user: _user!,
            isEditing: _isEditing && _user!.id == _currentUserId,
            displayNameController: _isEditing && _user!.id == _currentUserId ? _displayNameController : null,
          ),
          const SizedBox(height: 24),
          
          // 喜好食物标签
          FoodPreferenceTags(preferences: _foodPreferences),
          const SizedBox(height: 24),
          
          // 个人简介
          UserBioSection(
            bio: _user!.bio,
            isEditing: _isEditing && _user!.id == _currentUserId,
            controller: _isEditing && _user!.id == _currentUserId ? _bioController : null,
          ),
          const SizedBox(height: 24),
          
          // 关注按钮（仅其他用户显示）
          if (_user!.id != _currentUserId) ...[
            FollowButton(
              isFollowing: _isFollowing,
              onTap: _toggleFollow,
            ),
            const SizedBox(height: 24),
          ],
          
          // 推荐餐厅
          RecommendedRestaurantsGrid(
            restaurants: _recommendedRestaurants,
            onFollowingTap: _user!.id == _currentUserId ? _navigateToFollowingList : null,
          ),
        ],
      ),
    );
  }
}