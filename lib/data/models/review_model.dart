class Review {
  final int id;
  final int userId;
  final int restaurantId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ReviewImage> images;
  final String userName;
  final String userAvatar;
  
  Review({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    this.images = const [], // 默认为空列表
    this.userName = '', // 默认为空字符串
    this.userAvatar = '', // 默认为空字符串
  });

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
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      images: images,
      userName: json['userName'] ?? json['user_name'] ?? '用户${json['userId'] ?? ''}',
      userAvatar: json['userAvatar'] ?? json['user_avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'images': images.map((image) => image.toJson()).toList(),
      'userName': userName,
      'userAvatar': userAvatar,
    };
  }

  Review copyWith({
    int? id,
    int? userId,
    int? restaurantId,
    int? rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<ReviewImage>? images,
    String? userName,
    String? userAvatar,
  }) {
    return Review(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
    );
  }

  // 为了兼容UI，保留getter方法
  DateTime get date => createdAt;
}

class ReviewImage {
  final int? id;
  final int? reviewId;
  final String imageUrl;
  final int? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReviewImage({
    this.id,
    this.reviewId,
    required this.imageUrl,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reviewId': reviewId,
      'imageUrl': imageUrl,
      'sortOrder': sortOrder,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}