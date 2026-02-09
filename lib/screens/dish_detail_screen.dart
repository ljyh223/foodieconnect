import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/recommended_dish_model.dart';
import '../data/models/dish_review_model.dart';
import '../core/services/api_service.dart';
import '../presentation/providers/dish_review_provider.dart';

/// 菜品详情页面 - 包含菜品信息和评价
class DishDetailScreen extends StatefulWidget {
  final String restaurantId;
  final RecommendedDish dish;

  const DishDetailScreen({
    super.key,
    required this.restaurantId,
    required this.dish,
  });

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  DishReviewStats? _stats;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<DishReviewProvider>(context, listen: false);
    await provider.fetchByMenuItem(
      widget.restaurantId,
      widget.dish.id.toString(),
    );
    await provider.fetchStats(
      widget.restaurantId,
      widget.dish.id.toString(),
    );
    if (mounted) {
      setState(() {
        _stats = provider.stats;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // 菜品图片 Header
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildDishImage(),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 菜品信息
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 菜品名称和价格
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.dish.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (widget.dish.price > 0) ...[
                        const SizedBox(width: 16),
                        Text(
                          '¥${widget.dish.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 评分统计
                  if (_stats != null) _buildRatingStats(),

                  const SizedBox(height: 12),

                  // 描述
                  if (widget.dish.description.isNotEmpty) ...[
                    Text(
                      widget.dish.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 其他信息
                  _buildDishInfo(),

                  const SizedBox(height: 24),

                  // 评价部分标题
                  Row(
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      if (_stats != null)
                        Text(
                          '${_stats!.totalReviews} reviews',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // 评价列表
          Consumer<DishReviewProvider>(
            builder: (context, provider, child) {
              final reviews = provider.reviews;

              if (provider.isLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              if (reviews.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No reviews yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildReviewCard(reviews[index]);
                  },
                  childCount: reviews.length,
                ),
              );
            },
          ),
        ],
      ),

      // 写评价按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateReview(),
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildDishImage() {
    String displayImageUrl = '';
    if (widget.dish.imageUrl != null && widget.dish.imageUrl!.isNotEmpty) {
      displayImageUrl = ApiService.getFullImageUrl(widget.dish.imageUrl!);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        displayImageUrl.isNotEmpty
            ? Image.network(
                displayImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderImage();
                },
              )
            : _buildPlaceholderImage(),
        // 渐变遮罩
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent,
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Text(
          widget.dish.name.isNotEmpty ? widget.dish.name.substring(0, 1) : '',
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStats() {
    return Row(
      children: [
        // 平均评分
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 20),
              const SizedBox(width: 4),
              Text(
                _stats!.averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // 评价数量
        Text(
          '${_stats!.totalReviews} reviews',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDishInfo() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (widget.dish.spiceLevel != null && widget.dish.spiceLevel!.isNotEmpty)
          _buildInfoChip(_getSpiceLevelIcon(widget.dish.spiceLevel!), _getSpiceLevelText(widget.dish.spiceLevel!)),
        if (widget.dish.preparationTime != null && widget.dish.preparationTime! > 0)
          _buildInfoChip(Icons.schedule, '${widget.dish.preparationTime} min'),
        if (widget.dish.calories != null && widget.dish.calories! > 0)
          _buildInfoChip(Icons.local_fire_department, '${widget.dish.calories} cal'),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSpiceLevelIcon(String level) {
    switch (level.toUpperCase()) {
      case 'NONE':
        return Icons.grain;
      case 'MILD':
        return Icons.whatshot_outlined;
      case 'MEDIUM':
        return Icons.whatshot;
      case 'HOT':
        return Icons.local_fire_department;
      default:
        return Icons.grain;
    }
  }

  String _getSpiceLevelText(String level) {
    switch (level.toUpperCase()) {
      case 'NONE':
        return 'No Spice';
      case 'MILD':
        return 'Mild';
      case 'MEDIUM':
        return 'Medium';
      case 'HOT':
        return 'Hot';
      default:
        return level;
    }
  }

  Widget _buildReviewCard(DishReview review) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息和评分
          Row(
            children: [
              _buildUserAvatar(review.userAvatar, review.userName),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rating ? Icons.star : Icons.star_border,
                            color: Colors.orange,
                            size: 14,
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                _formatDate(review.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),

          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              review.comment,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],

          if (review.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        ApiService.getFullImageUrl(review.images[index]),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[200],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String? avatar, String name) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: avatar != null && avatar.isNotEmpty
            ? Image.network(
                ApiService.getFullImageUrl(avatar),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      name.isNotEmpty ? name.substring(0, 1) : '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  name.isNotEmpty ? name.substring(0, 1) : '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
      ),
    );
  }

  void _navigateToCreateReview() {
    Navigator.pushNamed(
      context,
      '/create_dish_review',
      arguments: {
        'restaurantId': widget.restaurantId,
        'menuItemId': widget.dish.id.toString(),
        'itemName': widget.dish.name,
      },
    ).then((_) => _loadData());
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}
