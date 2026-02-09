import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../data/models/review_model.dart';
import '../../core/services/api_service.dart';
import '../../core/services/review_service.dart';

/// 餐厅评价组件
class ShopReviewsSection extends StatelessWidget {
  final String restaurantId;
  final VoidCallback onTap;

  const ShopReviewsSection({
    super.key,
    required this.restaurantId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.reviews,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Restaurant Reviews',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Review>>(
              future: _loadReviews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text(
                    t.review.noReviews,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  );
                }

                final reviews = snapshot.data!.take(3).toList();

                return Column(
                  children: reviews.map((review) => _buildReviewCard(review)).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Review>> _loadReviews() async {
    try {
      return await ReviewService.listByRestaurant(restaurantId);
    } catch (e) {
      debugPrint('加载餐厅评价失败: $e');
      return [];
    }
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserAvatar(review.userAvatar, review.userName),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildRatingStars(review.rating),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String avatar, String name) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: avatar.isNotEmpty
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

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 14,
        );
      }),
    );
  }
}
