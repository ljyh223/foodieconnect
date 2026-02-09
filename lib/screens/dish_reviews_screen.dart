import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../data/models/dish_review_model.dart';
import '../core/services/api_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/widgets/menu_items_list_widget.dart';
import '../presentation/providers/dish_review_provider.dart';
import '../core/services/auth_service.dart';

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

class _DishReviewsScreenState extends State<DishReviewsScreen> {
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        if (_stats != null) _buildStatsCard(_stats!),
                        const SizedBox(height: 16),
                        // 评价列表
                        Expanded(
                          child: ListView.builder(
                            itemCount: reviews.length,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CardWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Row(
              children: [
                InkWell(
                  onTap: () => _handleAvatarTap(review.userId),
                  borderRadius: BorderRadius.circular(24),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        review.userAvatar.isNotEmpty
                            ? NetworkImage(
                              ApiService.getFullImageUrl(review.userAvatar),
                            )
                            : null,
                    backgroundColor: AppColors.primaryContainer,
                    child: review.userAvatar.isEmpty
                        ? Center(
                          child: Text(
                            review.userName.isNotEmpty
                                ? review.userName[0]
                                : '',
                            style: TextStyle(
                              color: AppColors.onPrimaryContainer,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                        : null,
                  ),
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
                          Text(
                            _buildRatingStars(review.rating.toDouble()),
                            style: TextStyle(
                              color: AppColors.ratingStar,
                              fontSize: 12,
                            ),
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
              _buildImageGrid(review.images),
            ],
          ],
        ),
        ),
      ),
    );
  }

  /// 构建评分星星
  String _buildRatingStars(double rating) {
    String stars = '';
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars += '★';
      } else if (i - 0.5 <= rating) {
        stars += '☆';
      } else {
        stars += '☆';
      }
    }
    return stars;
  }

  /// 处理头像点击事件
  Future<void> _handleAvatarTap(int userId) async {
    try {
      final currentUserId = await AuthService.getCurrentUserId();

      if (currentUserId != null && userId == currentUserId) {
        Navigator.of(context).pushNamed('/user_profile');
      } else {
        Navigator.of(
          context,
        ).pushNamed('/other_user_profile', arguments: {'userId': userId});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('跳转失败: $e')));
      }
    }
  }

  /// 构建图片网格
  Widget _buildImageGrid(List<String> images) {
    final int imageCount = images.length;

    if (imageCount == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          ApiService.getFullImageUrl(images[0]),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: AppColors.surfaceVariant,
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 200,
              color: AppColors.surfaceVariant,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      );
    } else if (imageCount <= 3) {
      return SizedBox(
        height: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: imageCount,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                ApiService.getFullImageUrl(images[index]),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: AppColors.surfaceVariant,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 120,
                    height: 120,
                    color: AppColors.surfaceVariant,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            );
          },
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
        itemCount: imageCount > 9 ? 9 : imageCount,
        itemBuilder: (context, index) {
          if (index == 8 && imageCount > 9) {
            return GestureDetector(
              onTap: () => _showImageViewer(context, images, index),
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Text(
                    '+${imageCount - 9}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: () => _showImageViewer(context, images, index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                ApiService.getFullImageUrl(images[index]),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surfaceVariant,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: AppColors.surfaceVariant,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  /// 显示图片查看器
  void _showImageViewer(
    BuildContext context,
    List<String> images,
    int initialIndex,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ImageViewerScreen(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

/// 图片查看器页面
class _ImageViewerScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _ImageViewerScreen({required this.images, required this.initialIndex});

  @override
  State<_ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<_ImageViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${widget.images.length}'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Center(
            child: InteractiveViewer(
              child: Image.network(
                ApiService.getFullImageUrl(widget.images[index]),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 64,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
