import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk/core/services/api_service.dart';
import 'package:tabletalk/core/services/localization_service.dart';
import '../data/models/review_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/providers/review_provider.dart';

class ReviewsScreen extends StatefulWidget {
  final String? restaurantId;

  const ReviewsScreen({super.key, this.restaurantId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = widget.restaurantId ?? (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String?;
      if (id != null) {
        Provider.of<ReviewProvider>(context, listen: false).fetchByRestaurant(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: LocalizationService.I.userComments,
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.send, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/create_review',
                arguments: {'restaurantId': widget.restaurantId},
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ReviewProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) return const Center(child: CircularProgressIndicator());
              if (provider.error != null) return Center(child: Text(provider.error!));

              final List<Review> reviews = provider.reviews;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return CardWidget(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryContainer,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Center(
                                      child: Text(
                                        review.userName.isNotEmpty ? review.userName[0] : '',
                                        style: TextStyle(
                                          color: AppColors.onPrimaryContainer,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
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
                                            review.date.toIso8601String().split('T').first,
                                            style: AppTextStyles.bodySmall.copyWith(
                                              color: AppColors.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

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

  // 构建图片网格显示
  Widget _buildImageGrid(List<ReviewImage> images) {
    final int imageCount = images.length;
    final List<String> imageUrls = images.map((image) => image.imageUrl).toList();
    
    if (imageCount == 1) {
      // 单张图片，显示较大尺寸
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          ApiService.getFullImageUrl(imageUrls[0]),
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
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      );
    } else if (imageCount <= 3) {
      // 2-3张图片，水平排列
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
                ApiService.getFullImageUrl(imageUrls[index]),
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
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    } else {
      // 多张图片，使用网格布局
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
            // 第9个位置显示剩余图片数量
            return GestureDetector(
              onTap: () {
                _showImageViewer(context, imageUrls, index);
              },
              child: Container(
                color: Colors.black.withValues(alpha: 0.6),
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
            onTap: () {
              _showImageViewer(context, imageUrls, index);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                ApiService.getFullImageUrl(imageUrls[index]),
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
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  // 显示图片查看器
  void _showImageViewer(BuildContext context, List<String> images, int initialIndex) {
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

// 图片查看器页面
class _ImageViewerScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _ImageViewerScreen({
    required this.images,
    required this.initialIndex,
  });

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
