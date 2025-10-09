import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/providers/review_provider.dart';
import '../data/models/review_model.dart';

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
        title: '用户评论',
        showBackButton: true,
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
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // 评论输入区
                  const SizedBox(height: 12),
                  _CommentInputSection(restaurantId: widget.restaurantId),
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
}

class _CommentInputSection extends StatefulWidget {
  final String? restaurantId;
  const _CommentInputSection({this.restaurantId});

  @override
  State<_CommentInputSection> createState() => _CommentInputSectionState();
}

class _CommentInputSectionState extends State<_CommentInputSection> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 5.0;
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text('评分：'),
                Expanded(
                  child: Slider(
                    value: _rating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _rating.toString(),
                    onChanged: (v) => setState(() => _rating = v),
                  ),
                ),
                Text(_rating.toStringAsFixed(0)),
              ],
            ),
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(hintText: '写下你的评论...'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _submitting ? null : _submit,
              child: _submitting ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('发布评论'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    final restaurantId = widget.restaurantId;
    if (restaurantId == null || restaurantId.isEmpty) return;
    if (text.isEmpty) return;

    setState(() => _submitting = true);
    try {
      await Provider.of<ReviewProvider>(context, listen: false).postReview(restaurantId, _rating.toInt(), text);
      _controller.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('评论已发布')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('发布失败：${e.toString()}')));
    } finally {
      setState(() => _submitting = false);
    }
  }
}