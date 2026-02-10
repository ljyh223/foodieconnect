import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../data/models/review_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/providers/review_provider.dart';
import '../presentation/widgets/review/rating_display_widget.dart';
import '../presentation/widgets/review/user_avatar_widget.dart';
import '../mixins/review_list_mixin.dart';

class ReviewsScreen extends StatefulWidget {
  final String? restaurantId;

  const ReviewsScreen({super.key, this.restaurantId});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen>
    with ReviewListMixin, UserAvatarHandlerMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id =
          widget.restaurantId ??
          (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId']
              as String?;
      if (id != null) {
        Provider.of<ReviewProvider>(
          context,
          listen: false,
        ).fetchByRestaurant(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: t.review.userComments,
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
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.error != null) {
                return Center(child: Text(provider.error!));
              }

              final List<Review> reviews = provider.reviews;

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: reviews.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        final imageUrls = review.images
                            .map((img) => img.imageUrl)
                            .toList();

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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                review.date
                                                    .toIso8601String()
                                                    .split('T')
                                                    .first,
                                                style: AppTextStyles.bodySmall
                                                    .copyWith(
                                                  color: AppColors
                                                      .onSurfaceVariant,
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
                                if (imageUrls.isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  buildReviewImageGrid(imageUrls),
                                ],
                              ],
                            ),
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
}
