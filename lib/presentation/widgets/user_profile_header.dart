import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/api_service.dart';
import '../../data/models/user_model.dart';

/// 用户个人主页头部组件
class UserProfileHeader extends StatelessWidget {
  final User user;
  final bool isEditing;
  final TextEditingController? displayNameController;

  const UserProfileHeader({
    super.key,
    required this.user,
    required this.isEditing,
    this.displayNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            child: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                ? Image.network(
                    ApiService.getFullImageUrl(user.avatarUrl!),
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
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.displayName ?? '未知用户',
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
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
        user.displayName?.isNotEmpty == true 
            ? user.displayName!.substring(0, 1).toUpperCase()
            : 'U',
        style: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}