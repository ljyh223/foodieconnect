import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// 关注按钮组件
class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback? onTap;
  final String? followText;
  final String? followingText;

  const FollowButton({
    super.key,
    required this.isFollowing,
    this.onTap,
    this.followText,
    this.followingText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? AppColors.surface : AppColors.primary,
          foregroundColor: isFollowing ? AppColors.primary : AppColors.onPrimary,
          side: BorderSide(
            color: isFollowing ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          isFollowing ? (followingText ?? '已关注') : (followText ?? '关注'),
          style: AppTextStyles.button.copyWith(
            color: isFollowing ? AppColors.primary : AppColors.onPrimary,
          ),
        ),
      ),
    );
  }
}