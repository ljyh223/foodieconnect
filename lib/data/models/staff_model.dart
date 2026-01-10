import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_model.freezed.dart';

@freezed
class Staff with _$Staff {
  const factory Staff({
    required String id,
    required String name,
    required String position,
    required String status,
    required String experience,
    required double rating,
    String? restaurantId,
    String? avatarUrl, // 头像URL字段，与API保持一致
    @Default([]) List<String> skills,
    @Default([]) List<String> languages,
    @Default([]) List<StaffReview> reviews,
  }) = _Staff;

  factory Staff.fromJson(Map<String, dynamic> json) {
    // 处理StaffReview列表
    List<StaffReview> reviews = [];
    if (json['reviews'] != null && json['reviews'] is List) {
      reviews = (json['reviews'] as List<dynamic>)
          .map((review) => StaffReview.fromJson(review as Map<String, dynamic>))
          .toList();
    }

    return Staff(
      id: (json['id'] ?? '').toString(),
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      status: json['status'] ?? '',
      experience: json['experience'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      restaurantId: (json['restaurantId'] ?? '').toString(),
      avatarUrl: json['avatarUrl'], // 直接使用API返回的avatarUrl字段
      skills: List<String>.from(json['skills'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      reviews: reviews,
    );
  }
}

@freezed
class StaffReview with _$StaffReview {
  const factory StaffReview({
    required String id,
    required String userName,
    required String content,
    required double rating,
    required DateTime createdAt,
    DateTime? updatedAt,
    required String staffId,
    required String userId,
    String? userAvatar,
  }) = _StaffReview;

  factory StaffReview.fromJson(Map<String, dynamic> json) {
    return StaffReview(
      id: json['id']?.toString() ?? '',
      userName: json['userName'] ?? '',
      content: json['content'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      staffId: json['staffId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      userAvatar: json['userAvatar'],
    );
  }
}
