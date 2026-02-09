import 'package:freezed_annotation/freezed_annotation.dart';

part 'dish_review_model.freezed.dart';

/// 菜品评价模型
@freezed
class DishReview with _$DishReview {
  const factory DishReview({
    required int id,
    required int menuItemId,
    required String itemName,
    required double itemPrice,
    required String itemImage,
    required int userId,
    required String userName,
    required String userAvatar,
    required int rating,
    required String comment,
    @Default([]) List<String> images,
    required DateTime createdAt,
  }) = _DishReview;

  // 添加私有构造函数以支持getter方法
  const DishReview._();

  factory DishReview.fromJson(Map<String, dynamic> json) {
    // 处理图片列表
    List<String> images = [];
    if (json['images'] != null && json['images'] is List) {
      images = (json['images'] as List<dynamic>)
          .map((e) => e.toString())
          .toList();
    }

    // 处理价格
    double itemPrice = 0.0;
    if (json['itemPrice'] != null) {
      if (json['itemPrice'] is num) {
        itemPrice = (json['itemPrice'] as num).toDouble();
      } else if (json['itemPrice'] is String) {
        itemPrice = double.tryParse(json['itemPrice']) ?? 0.0;
      }
    }

    return DishReview(
      id: json['id'] ?? 0,
      menuItemId: json['menuItemId'] ?? 0,
      itemName: json['itemName'] ?? '',
      itemPrice: itemPrice,
      itemImage: json['itemImage'] ?? '',
      userId: json['userId'] ?? 0,
      userName:
          json['userName'] ?? json['user_name'] ?? '用户${json['userId'] ?? ''}',
      userAvatar: json['userAvatar'] ?? json['user_avatar'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      images: images,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}

/// 菜品评价统计数据模型
@freezed
class DishReviewStats with _$DishReviewStats {
  const factory DishReviewStats({
    required double averageRating,
    required int totalReviews,
    @Default({}) Map<String, int> ratingDistribution,
  }) = _DishReviewStats;

  factory DishReviewStats.fromJson(Map<String, dynamic> json) {
    // 处理评分分布
    Map<String, int> ratingDistribution = {};
    if (json['ratingDistribution'] != null) {
      final distribution = json['ratingDistribution'];
      if (distribution is Map<String, dynamic>) {
        distribution.forEach((key, value) {
          if (value is int) {
            ratingDistribution[key] = value;
          } else if (value is double) {
            ratingDistribution[key] = value.toInt();
          }
        });
      }
    }

    // 处理平均评分
    double averageRating = 0.0;
    if (json['averageRating'] != null) {
      if (json['averageRating'] is num) {
        averageRating = (json['averageRating'] as num).toDouble();
      } else if (json['averageRating'] is String) {
        averageRating = double.tryParse(json['averageRating']) ?? 0.0;
      }
    }

    // 处理总评价数
    int totalReviews = 0;
    if (json['totalReviews'] != null) {
      if (json['totalReviews'] is int) {
        totalReviews = json['totalReviews'];
      } else if (json['totalReviews'] is double) {
        totalReviews = (json['totalReviews'] as double).toInt();
      }
    }

    return DishReviewStats(
      averageRating: averageRating,
      totalReviews: totalReviews,
      ratingDistribution: ratingDistribution,
    );
  }
}

/// 菜品评价检查结果模型
@freezed
class DishReviewCheck with _$DishReviewCheck {
  const factory DishReviewCheck({
    required bool hasReviewed,
    int? reviewId,
    DishReview? review,
  }) = _DishReviewCheck;

  factory DishReviewCheck.fromJson(Map<String, dynamic> json) {
    bool hasReviewed = false;
    int? reviewId;
    DishReview? review;

    if (json['hasReviewed'] is bool) {
      hasReviewed = json['hasReviewed'];
    } else if (json['hasReviewed'] is String) {
      hasReviewed = json['hasReviewed'] == 'true';
    }

    if (json['reviewId'] != null) {
      if (json['reviewId'] is int) {
        reviewId = json['reviewId'];
      } else if (json['reviewId'] is String) {
        reviewId = int.tryParse(json['reviewId']);
      }
    }

    if (json['review'] != null && json['review'] is Map) {
      review = DishReview.fromJson(json['review'] as Map<String, dynamic>);
    }

    return DishReviewCheck(
      hasReviewed: hasReviewed,
      reviewId: reviewId,
      review: review,
    );
  }
}
