import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/food_preference_model.dart';

/// 喜好食物标签组件
class FoodPreferenceTags extends StatelessWidget {
  final List<FoodPreference> preferences;

  const FoodPreferenceTags({
    super.key,
    required this.preferences,
  });

  @override
  Widget build(BuildContext context) {
    if (preferences.isEmpty) {
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
          children: preferences.map((preference) {
            return FoodPreferenceTag(name: preference.foodName);
          }).toList(),
        ),
      ],
    );
  }
}

/// 单个喜好食物标签组件
class FoodPreferenceTag extends StatelessWidget {
  final String name;

  const FoodPreferenceTag({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      child: Text(
        name,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}