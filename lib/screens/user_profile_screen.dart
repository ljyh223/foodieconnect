import 'package:flutter/material.dart';
import 'package:tabletalk/core/services/localization_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/auth_service.dart';
import '../core/services/user_service.dart';
import '../core/services/review_service.dart';
import '../data/models/user_model.dart';
import '../data/models/restaurant_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/user_profile_header.dart';
import '../presentation/widgets/user_bio_section.dart';
import '../presentation/widgets/recommended_restaurants_grid.dart';
import '../generated/profile/profile_localizations.dart';

/// 当前用户的个人主页界面
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? _user;
  List<Restaurant> _recommendedRestaurants = [];
  bool _isLoading = true;
  bool _isEditing = false;
  String? _error;

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

  /// 加载当前用户数据
  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 并行加载用户信息和推荐餐厅
      await Future.wait([
        _loadUserInfo(),
        _loadRecommendedRestaurants(),
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

  /// 加载当前用户基本信息
  Future<User> _loadUserInfo() async {
    try {
      // 使用AuthService获取当前用户信息
      _user = await AuthService.me();
      
      // 初始化编辑控制器
      _displayNameController.text = _user!.displayName ?? '';
      _bioController.text = _user!.bio ?? '';
      
      return _user!;
    } catch (e) {
      // 如果API调用失败，尝试使用UserService
      try {
        final currentUserId = await AuthService.getCurrentUserId();
        if (currentUserId != null) {
          _user = await UserService.getUserInfo(currentUserId);
          _displayNameController.text = _user!.displayName ?? '';
          _bioController.text = _user!.bio ?? '';
          return _user!;
        }
      } catch (secondError) {

        
        _displayNameController.text = _user!.displayName ?? '';
        _bioController.text = _user!.bio ?? '';
        
        return _user!;
      }
      
      throw Exception('无法获取用户信息');
    }
  }

  /// 加载推荐餐厅
  Future<void> _loadRecommendedRestaurants() async {
    try {
      if (_user != null) {
        _recommendedRestaurants = await ReviewService.getRecommendedRestaurants(_user!.id);
      }
    } catch (e) {
      // 如果获取失败，使用空列表
      _recommendedRestaurants = [];
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
    if (_user == null) return;
    
    try {
      // 调用更新用户信息的API
      _user = await UserService.updateUserInfo(
        userId: _user!.id,
        displayName: _displayNameController.text,
        bio: _bioController.text,
      );

      setState(() {
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocalizationService.I.profile.saveSuccess),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocalizationService.I.profile.saveFailed(e.toString())),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: LocalizationService.I.profile.profileTitle,
        showBackButton: true,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEditMode,
            )
          else
            TextButton(
              onPressed: _saveUserInfo,
              child: Text(LocalizationService.I.profile.save),
            ),
        ],
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
              LocalizationService.I.profile.loadingFailed,
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
              child: Text(LocalizationService.I.profile.retry),
            ),
          ],
        ),
      );
    }

    if (_user == null) {
      return Center(
        child: Text(
          LocalizationService.I.profile.userNotFound,
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
            isEditing: _isEditing,
            displayNameController: _isEditing ? _displayNameController : null,
          ),
          const SizedBox(height: 24),
          
          // 喜好食物标签
          _buildFoodPreferences(),
          const SizedBox(height: 24),
          
          // 个人简介
          UserBioSection(
            bio: _user!.bio,
            isEditing: _isEditing,
            controller: _isEditing ? _bioController : null,
          ),
          const SizedBox(height: 24),
          
          // 推荐餐厅
          RecommendedRestaurantsGrid(
            restaurants: _recommendedRestaurants,
            onFollowingTap: _navigateToFollowingList,
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
          LocalizationService.I.profile.noFoodPreferences,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationService.I.profile.foodPreferences,
          style: AppTextStyles.titleMedium,
        ),
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