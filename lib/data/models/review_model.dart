import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required int id,
    required int userId,
    required int restaurantId,
    required int rating,
    required String comment,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<ReviewImage> images,
    @Default('') String userName,
    @Default('') String userAvatar,
  }) = _Review;

  // 添加私有构造函数以支持getter方法
  const Review._();

  factory Review.fromJson(Map<String, dynamic> json) {
    // 处理图片列表
    List<ReviewImage> images = [];
    if (json['images'] != null && json['images'] is List) {
      images = (json['images'] as List<dynamic>)
          .map((e) => ReviewImage.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return Review(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      restaurantId: json['restaurantId'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      images: images,
      userName:
          json['userName'] ?? json['user_name'] ?? '用户${json['userId'] ?? ''}',
      userAvatar: json['userAvatar'] ?? json['user_avatar'] ?? '',
    );
  }

  // 为了兼容UI，保留getter方法
  DateTime get date => createdAt;
}

@freezed
class ReviewImage with _$ReviewImage {
  const factory ReviewImage({
    int? id,
    int? reviewId,
    required String imageUrl,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ReviewImage;

  factory ReviewImage.fromJson(Map<String, dynamic> json) {
    return ReviewImage(
      id: json['id'],
      reviewId: json['reviewId'],
      imageUrl: json['imageUrl'] ?? '',
      sortOrder: json['sortOrder'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
