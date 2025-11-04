import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/api_service.dart';
import '../core/services/food_preference_service.dart';
import '../core/services/follow_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/user_model.dart';
import '../data/models/food_preference_model.dart';
import '../presentation/widgets/app_bar_widget.dart';

/// 其他用户个人主页界面
class OtherUserProfileScreen extends StatefulWidget {
  final int userId;

  const OtherUserProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  User? _user;
  List<FoodPreference> _foodPreferences = [];
  bool _isLoading = true;
  bool _isFollowing = false;
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
      // 获取当前用户ID
      final currentUserId = await AuthService.getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('未找到当前用户信息');
      }

      // 并行加载用户信息、喜好食物和关注状态
      await Future.wait([
        _loadUserInfo(),
        _loadFoodPreferences(),
        _checkFollowStatus(currentUserId),
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
  Future<User> _loadUserInfo() async {
    // 这里应该调用获取用户信息的API
    // 暂时使用模拟数据，实际应该调用类似这样的API：
    // final response = await ApiService.get('/users/${widget.userId}');
    // _user = User.fromJson(response['data']);
    
    // 模拟数据
    _user = User(
      id: widget.userId,
      email: 'user$widget.userId@example.com',
      displayName: '用户$widget.userId',
      avatarUrl: null,
      bio: '这是用户$widget.userId的个人简介',
    );
    
    return _user!;
  }

  /// 加载用户喜好食物
  Future<void> _loadFoodPreferences() async {
    try {
      _foodPreferences = await FoodPreferenceService.getUserPreferences(widget.userId);
    } catch (e) {
      // 如果获取失败，使用空列表
      _foodPreferences = [];
    }
  }

  /// 检查关注状态
  Future<void> _checkFollowStatus(int currentUserId) async {
    try {
      _isFollowing = await FollowService.isFollowing(
        followerId: currentUserId,
        followingId: widget.userId,
      );
    } catch (e) {
      // 如果检查失败，默认为未关注
      _isFollowing = false;
    }
  }

  /// 关注/取消关注用户
  Future<void> _toggleFollow() async {
    try {
      final currentUserId = await AuthService.getCurrentUserId();
      if (currentUserId == null) {
        throw Exception('未找到当前用户信息');
      }

      setState(() {
        _isFollowing = !_isFollowing;
      });

      if (_isFollowing) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: '用户主页',
        showBackButton: true,
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
          _buildUserInfo(),
          const SizedBox(height: 24),
          
          // 喜好食物标签
          _buildFoodPreferences(),
          const SizedBox(height: 32),
          
          // 连接按钮
          _buildConnectButton(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        // 头像
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.outline,
              width: 1,
            ),
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
        const SizedBox(height: 16),
        
        // 昵称
        Text(
          _user!.displayName ?? '未知用户',
          style: AppTextStyles.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        // 邮箱
        Text(
          _user!.email,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
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
    if (_foodPreferences.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outline),
        ),
        child: Text(
          '暂无喜好食物信息',
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
          '喜好食物',
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _foodPreferences.map((preference) {
            return _buildFoodPreferenceTag(preference.foodName);
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _toggleFollow,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isFollowing ? AppColors.surface : AppColors.primary,
          foregroundColor: _isFollowing ? AppColors.primary : AppColors.onPrimary,
          side: BorderSide(
            color: _isFollowing ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          _isFollowing ? '已关注' : 'Connect',
          style: AppTextStyles.button.copyWith(
            color: _isFollowing ? AppColors.primary : AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}