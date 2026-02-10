import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/auth_service.dart';

/// 用户头像组件，支持点击跳转到个人中心
class UserAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final String userName;
  final double radius;
  final VoidCallback? onTap;

  const UserAvatarWidget({
    super.key,
    this.avatarUrl,
    required this.userName,
    this.radius = 24,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: radius,
      backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
          ? NetworkImage(ApiService.getFullImageUrl(avatarUrl!))
          : null,
      backgroundColor: AppColors.primaryContainer,
      child: avatarUrl == null || avatarUrl!.isEmpty
          ? Center(
              child: Text(
                userName.isNotEmpty ? userName[0] : '',
                style: TextStyle(
                  color: AppColors.onPrimaryContainer,
                  fontSize: radius * 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: avatar,
      );
    }

    return avatar;
  }
}

/// 用户头像点击处理器
mixin UserAvatarHandlerMixin<T extends StatefulWidget> on State<T> {
  /// 处理头像点击事件，根据用户类型跳转到相应的个人中心
  Future<void> handleAvatarTap(int userId) async {
    try {
      final currentUserId = await AuthService.getCurrentUserId();

      if (!mounted) return;

      if (currentUserId != null && userId == currentUserId) {
        // 跳转到自己的个人中心
        Navigator.of(context).pushNamed('/user_profile');
      } else {
        // 跳转到他人的个人中心
        Navigator.of(context).pushNamed(
          '/other_user_profile',
          arguments: {'userId': userId},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('跳转失败: $e')),
        );
      }
    }
  }
}
