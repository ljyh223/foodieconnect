import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../providers/recommendation_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/user_recommendation_model.dart';
import '../../core/services/api_service.dart';

/// 推荐用户卡片组件 - 极简设计
class RecommendedUserCard extends StatelessWidget {
  final UserRecommendation recommendation;
  final VoidCallback? onTap;
  final VoidCallback? onUserTap;

  const RecommendedUserCard({
    super.key,
    required this.recommendation,
    this.onTap,
    this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    final recommendationProvider = Provider.of<RecommendationProvider>(
      context,
      listen: false,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap ?? () => _handleCardTap(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户头像和基本信息行
              Row(
                children: [
                  // 用户头像
                  GestureDetector(
                    onTap: onUserTap ?? () => _handleUserTap(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceVariant,
                      ),
                      child: ClipOval(
                        child:
                            recommendation.userAvatar != null &&
                                recommendation.userAvatar!.isNotEmpty
                            ? Image.network(
                                ApiService.getFullImageUrl(
                                  recommendation.userAvatar,
                                ),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildDefaultAvatar();
                                },
                              )
                            : _buildDefaultAvatar(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // 用户昵称和推荐分数
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation.userName,
                          style: AppTextStyles.titleMedium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              recommendation.starRatingString,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFFD700),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${recommendation.score.toStringAsFixed(1)})',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                            // 显示相似度（如果有）
                            if (recommendation.similarity != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                '相似度: ${recommendation.similarityPercentage}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // 推荐理由
              _buildRecommendationReason(),

              // 共同餐厅信息（如果有）
              if (recommendation.commonRestaurants != null &&
                  recommendation.commonRestaurants!.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildCommonRestaurants(),
              ],

              const SizedBox(height: 12),

              // 操作按钮
              _buildActionButtons(context, recommendationProvider),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建默认头像
  Widget _buildDefaultAvatar() {
    return Container(
      color: AppColors.primaryContainer,
      child: Center(
        child: Text(
          recommendation.userName.isNotEmpty
              ? recommendation.userName[0].toUpperCase()
              : 'U',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// 构建推荐理由
  Widget _buildRecommendationReason() {
    String reasonText = recommendation.recommendationReason;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        reasonText,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.onSurfaceVariant,
          fontSize: 12,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// 构建共同餐厅信息
  Widget _buildCommonRestaurants() {
    final restaurants = recommendation.commonRestaurants!;
    final displayCount = restaurants.length > 2 ? 2 : restaurants.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '共同餐厅 (${restaurants.length})',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            ...restaurants
                .take(displayCount)
                .map(
                  (restaurant) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      restaurant.name,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            if (restaurants.length > 2)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+${restaurants.length - 2}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  /// 构建操作按钮
  Widget _buildActionButtons(
    BuildContext context,
    RecommendationProvider provider,
  ) {
    return Row(
      children: [
        // 关注按钮
        Expanded(
          child: SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () => _handleFollowTap(context, provider),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                t.app.connect,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 不感兴趣按钮
        Expanded(
          child: SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () => _handleNotInterestedTap(context, provider),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.onSurfaceVariant,
                side: BorderSide(
                  color: AppColors.outline.withValues(alpha: 0.5),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                t.app.notInterested,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 处理卡片点击
  void _handleCardTap(BuildContext context) {
    // 可以跳转到推荐详情页面
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.app.recommendationDetail),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  /// 处理用户头像点击
  void _handleUserTap(BuildContext context) {
    // 跳转到用户详情页面
    Navigator.pushNamed(
      context,
      '/other_user_profile',
      arguments: {'userId': recommendation.userId},
    );
  }

  /// 处理关注按钮点击
  Future<void> _handleFollowTap(
    BuildContext context,
    RecommendationProvider provider,
  ) async {
    if (!context.mounted) return;

    try {
      // 标记为感兴趣
      final success = await provider.markAsInterested(recommendation.id);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.app.markAsInterested),
            duration: const Duration(seconds: 1),
          ),
        );

        // 可以在这里添加关注逻辑
        // await FollowService.followUser(recommendation.userId);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.app.operationFailed(error: e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 处理不感兴趣按钮点击
  Future<void> _handleNotInterestedTap(
    BuildContext context,
    RecommendationProvider provider,
  ) async {
    if (!context.mounted) return;

    try {
      // 标记为不感兴趣
      final success = await provider.markAsNotInterested(recommendation.id);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.app.markAsNotInterested),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.app.operationFailed(error: e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
