import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'package:foodieconnect/generated/translations.g.dart';

/// 用户个人简介组件
class UserBioSection extends StatelessWidget {
  final String? bio;
  final bool isEditing;
  final TextEditingController? controller;

  const UserBioSection({
    super.key,
    this.bio,
    required this.isEditing,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.profile.personalBio, style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        isEditing && controller != null
            ? TextField(
                controller: controller!,
                style: AppTextStyles.bodyMedium,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  hintText: t.profile.introduceYourself,
                ),
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.outline),
                ),
                child: Text(
                  bio ?? 'This person is lazy and left nothing...',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
      ],
    );
  }
}
