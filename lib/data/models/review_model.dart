class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final int rating;
  final String comment;
  final DateTime date;
  final String restaurantId;
  
  Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.restaurantId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      restaurantId: json['restaurantId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'restaurantId': restaurantId,
    };
  }

  Review copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    int? rating,
    String? comment,
    DateTime? date,
    String? restaurantId,
  }) {
    return Review(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }
}