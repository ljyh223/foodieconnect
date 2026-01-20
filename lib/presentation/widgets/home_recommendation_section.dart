import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/core/services/api_service.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../providers/recommendation_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/user_recommendation_model.dart';

/// 首页推荐区域组件
class HomeRecommendationSection extends StatelessWidget {
  const HomeRecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendationProvider>(
      builder: (context, provider, child) {
        // 如果没有推荐且不在加载中，不显示组件
        if (provider.recommendations.isEmpty && !provider.isLoading) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题行
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.app.recommendedUsers,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _navigateToRecommendations(context),
                    child: Text(
                      t.app.viewMore,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 推荐用户列表
            _buildRecommendationList(context, provider),

            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  /// 构建推荐用户列表
  Widget _buildRecommendationList(
    BuildContext context,
    RecommendationProvider provider,
  ) {
    final recommendations = provider.recommendations.take(5).toList();

    // 如果有推荐数据，直接显示，不显示加载状态
    if (recommendations.isNotEmpty) {
      return SizedBox(
        height: 160, // 设置固定高度但允许内容滑动
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: recommendations.length,
          itemBuilder: (context, index) {
            final recommendation = recommendations[index];
            return _buildCompactRecommendationCard(context, recommendation);
          },
        ),
      );
    }

    // 只在没有数据且正在加载时显示加载状态
    if (provider.isLoading && recommendations.isEmpty) {
      return _buildLoadingState();
    }

    // 没有数据且不在加载中时显示空状态
    return _buildEmptyState();
  }

  /// 构建紧凑型推荐卡片（用于首页横向滚动）
  Widget _buildCompactRecommendationCard(
    BuildContext context,
    UserRecommendation recommendation,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48) / 2.5; // 2.5个卡片宽度

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => _handleCardTap(context, recommendation),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 使用最小尺寸
            children: [
              // 用户头像
              Center(
                child: Container(
                  width: 48,
                  height: 48,
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
                              return _buildDefaultAvatar(recommendation);
                            },
                          )
                        : _buildDefaultAvatar(recommendation),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // 用户昵称
              Text(
                recommendation.userName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 1),

              // 推荐分数
              Row(
                children: [
                  Text(
                    recommendation.starRatingString,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '(${recommendation.score.toStringAsFixed(1)})',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 2),

              // 推荐理由（简化版）
              Flexible(
                child: Text(
                  _getCompactReason(recommendation),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 4), // 使用固定高度替代Spacer
              // 关注按钮
              SizedBox(
                width: double.infinity,
                height: 28,
                child: ElevatedButton(
                  onPressed: () => _handleFollowTap(context, recommendation),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    t.app.follow,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建默认头像
  Widget _buildDefaultAvatar(UserRecommendation recommendation) {
    return Container(
      color: AppColors.primaryContainer,
      child: Center(
        child: Text(
          recommendation.userName.isNotEmpty
              ? recommendation.userName[0].toUpperCase()
              : 'U',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  /// 获取紧凑版推荐理由
  String _getCompactReason(UserRecommendation recommendation) {
    String reasonText = recommendation.recommendationReason;

    // 如果推荐理由太长，截取前15个字符
    if (reasonText.length > 15) {
      return '${reasonText.substring(0, 15)}...';
    }

    return reasonText;
  }

  /// 构建加载状态
  Widget _buildLoadingState() {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          3,
          (index) => Expanded(
            child: Container(
              height: 140,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search_outlined,
              size: 32,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              '暂无推荐用户',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 处理卡片点击
  void _handleCardTap(BuildContext context, UserRecommendation recommendation) {
    Navigator.pushNamed(
      context,
      '/other_user_profile',
      arguments: {'userId': recommendation.userId},
    );
  }

  /// 处理关注按钮点击
  Future<void> _handleFollowTap(
    BuildContext context,
    UserRecommendation recommendation,
  ) async {
    if (!context.mounted) return;

    final provider = Provider.of<RecommendationProvider>(
      context,
      listen: false,
    );

    try {
      final success = await provider.markAsInterested(recommendation.id);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('已标记为感兴趣'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('操作失败: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  /// 跳转到推荐页面
  void _navigateToRecommendations(BuildContext context) {
    Navigator.pushNamed(context, '/recommendations');
  }
}
