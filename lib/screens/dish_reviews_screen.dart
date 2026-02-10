import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../data/models/dish_review_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/widgets/menu_items_list_widget.dart';
import '../presentation/providers/dish_review_provider.dart';
import '../presentation/widgets/review/rating_display_widget.dart';
import '../presentation/widgets/review/user_avatar_widget.dart';
import '../mixins/review_list_mixin.dart';

/// 菜品评价列表页面
class DishReviewsScreen extends StatefulWidget {
  final String? restaurantId;
  final String? menuItemId;
  final String? itemName;

  const DishReviewsScreen({
    super.key,
    this.restaurantId,
    this.menuItemId,
    this.itemName,
  });

  @override
  State<DishReviewsScreen> createState() => _DishReviewsScreenState();
}

class _DishReviewsScreenState extends State<DishReviewsScreen>
    with ReviewListMixin, UserAvatarHandlerMixin {
  DishReviewStats? _stats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final restaurantId =
        widget.restaurantId ??
        (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId']
            as String?;
    final menuItemId =
        widget.menuItemId ??
        (ModalRoute.of(context)?.settings.arguments as Map?)?['menuItemId']
            as String?;

    if (restaurantId != null && menuItemId != null) {
      final provider = Provider.of<DishReviewProvider>(
        context,
        listen: false,
      );
      await provider.fetchByMenuItem(restaurantId, menuItemId);
      await provider.fetchStats(restaurantId, menuItemId);
      setState(() {
        _stats = provider.stats;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        widget.restaurantId != null
            ? null
            : (ModalRoute.of(context)?.settings.arguments as Map?);
    final restaurantId = widget.restaurantId ?? args?['restaurantId'] as String?;
    final menuItemId = widget.menuItemId ?? args?['menuItemId'] as String?;
    final itemName = widget.itemName ?? args?['itemName'] as String?;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: itemName != null
            ? '${t.review.dishReviews} - $itemName'
            : t.review.dishReviews,
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/create_dish_review',
                arguments: {
                  'restaurantId': restaurantId,
                  'menuItemId': menuItemId,
                  'itemName': itemName,
                },
              ).then((_) => _loadData());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 菜品列表组件
            SizedBox(
              height: 180,
              child: MenuItemsListWidget(
                restaurantId: restaurantId ?? '',
                selectedMenuItemId: menuItemId,
                onItemSelected: (selectedItemId, selectedName) {
                  // 当用户选择菜品时，重新加载该菜品的评价
                  _loadReviewsForItem(restaurantId!, selectedItemId, selectedName);
                },
              ),
            ),
            // 评价列表部分
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<DishReviewProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (provider.error != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(provider.error!),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _loadData(),
                              child: const Text('重试'),
                            ),
                          ],
                        ),
                      );
                    }

                    final List<DishReview> reviews = provider.reviews;

                    if (reviews.isEmpty) {
                      return Center(
                        child: Text(
                          t.review.noReviews,
                          style: AppTextStyles.bodyLarge,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        // 评分统计卡片
                        if (_stats != null) ...[
                          _buildStatsCard(_stats!),
                          const SizedBox(height: 12),
                        ],
                        // 评价列表
                        Expanded(
                          child: ListView.separated(
                            itemCount: reviews.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final review = reviews[index];
                              return _buildReviewCard(review);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 加载指定菜品的评价
  Future<void> _loadReviewsForItem(
    String restaurantId,
    String menuItemId,
    String itemName,
  ) async {
    final provider = Provider.of<DishReviewProvider>(context, listen: false);
    await provider.fetchByMenuItem(restaurantId, menuItemId);
    await provider.fetchStats(restaurantId, menuItemId);
    setState(() {
      _stats = provider.stats;
    });
  }

  /// 构建评分统计卡片
  Widget _buildStatsCard(DishReviewStats stats) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '评分统计',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // 平均评分
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        stats.averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${stats.totalReviews}条评价',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // 评分分布
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(5, (index) {
                      final star = 5 - index;
                      final count = stats.ratingDistribution[star.toString()] ?? 0;
                      final percentage = stats.totalReviews > 0
                          ? count / stats.totalReviews
                          : 0.0;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              '$star',
                              style: AppTextStyles.bodySmall,
                            ),
                            const Icon(Icons.star, color: Colors.amber, size: 12),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: percentage,
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 30,
                              child: Text(
                                count.toString(),
                                style: AppTextStyles.bodySmall,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建评价卡片
  Widget _buildReviewCard(DishReview review) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                UserAvatarWidget(
                  avatarUrl: review.userAvatar.isNotEmpty
                      ? review.userAvatar
                      : null,
                  userName: review.userName,
                  onTap: () => handleAvatarTap(review.userId),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: AppTextStyles.titleMedium,
                      ),
                      Row(
                        children: [
                          RatingDisplayWidget(
                            rating: review.rating.toDouble(),
                            size: 12,
                            color: AppColors.ratingStar,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review.createdAt
                                .toIso8601String()
                                .split('T')
                                .first,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: AppTextStyles.bodyMedium,
            ),
            // 显示评价图片
            if (review.images.isNotEmpty) ...[
              const SizedBox(height: 12),
              buildReviewImageGrid(review.images),
            ],
          ],
        ),
      ),
    );
  }
}
