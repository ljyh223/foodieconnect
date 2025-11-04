import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/api_service.dart';
import '../core/services/follow_service.dart';
import '../core/services/auth_service.dart';
import '../data/models/user_model.dart';
import '../presentation/widgets/app_bar_widget.dart';

/// 关注列表界面
class FollowingListScreen extends StatefulWidget {
  final int? userId; // 如果为null，则显示当前用户的关注列表

  const FollowingListScreen({
    super.key,
    this.userId,
  });

  @override
  State<FollowingListScreen> createState() => _FollowingListScreenState();
}

class _FollowingListScreenState extends State<FollowingListScreen> {
  List<User> _followingList = [];
  bool _isLoading = true;
  String? _error;
  int? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadFollowingList();
  }

  /// 加载关注列表
  Future<void> _loadFollowingList() async {
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

      // 获取关注列表
      _followingList = await FollowService.getFollowingList(targetUserId);

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

  /// 导航到用户详情页
  void _navigateToUserProfile(User user) {
    // 如果是当前用户，导航到个人主页
    if (user.id == _currentUserId) {
      Navigator.pushNamed(context, '/user_profile');
    } else {
      // 其他用户，导航到其他用户主页
      Navigator.pushNamed(
        context,
        '/other_user_profile',
        arguments: {'userId': user.id},
      );
    }
  }

  /// 取消关注用户
  Future<void> _unfollowUser(User user) async {
    try {
      if (_currentUserId == null) return;

      await FollowService.unfollowUser(
        followerId: _currentUserId!,
        followingId: user.id,
      );

      // 从列表中移除
      setState(() {
        _followingList.removeWhere((u) => u.id == user.id);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('已取消关注'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('取消关注失败: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  /// 显示取消关注确认对话框
  void _showUnfollowDialog(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('取消关注'),
          content: Text('确定要取消关注 ${user.displayName ?? user.email} 吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _unfollowUser(user);
              },
              child: Text(
                '确定',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: widget.userId == null ? '我的关注' : '关注列表',
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
              onPressed: _loadFollowingList,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_followingList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              '暂无关注',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '去发现感兴趣的用户吧',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadFollowingList,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _followingList.length,
        itemBuilder: (context, index) {
          final user = _followingList[index];
          return _buildUserTile(user);
        },
      ),
    );
  }

  Widget _buildUserTile(User user) {
    final isCurrentUser = user.id == _currentUserId;
    final canUnfollow = !isCurrentUser && widget.userId == null; // 只有在自己的关注列表中才能取消关注

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outline),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.outline),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                  ? Image.network(
                      ApiService.getFullImageUrl(user.avatarUrl!),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar(user);
                      },
                    )
                  : _buildDefaultAvatar(user),
            ),
          ),
          title: Text(
            user.displayName ?? '未知用户',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            user.email,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          trailing: canUnfollow
              ? PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.onSurfaceVariant,
                  ),
                  onSelected: (value) {
                    if (value == 'unfollow') {
                      _showUnfollowDialog(user);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<String>(
                      value: 'unfollow',
                      child: Text('取消关注'),
                    ),
                  ],
                )
              : null,
          onTap: () => _navigateToUserProfile(user),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(User user) {
    return Center(
      child: Text(
        user.displayName?.isNotEmpty == true 
            ? user.displayName!.substring(0, 1).toUpperCase()
            : 'U',
        style: AppTextStyles.titleLarge.copyWith(
          color: AppColors.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}