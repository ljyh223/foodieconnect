class Staff {
  final String id;
  final String name;
  final String position;
  final String status;
  final String experience;
  final double rating;
  final String? restaurantId;
  final String? avatarUrl;
  final List<String> skills;
  final List<String> languages;
  final List<StaffReview> reviews;
  
  Staff({
    required this.id,
    required this.name,
    required this.position,
    required this.status,
    required this.experience,
    required this.rating,
    this.restaurantId,
    this.avatarUrl,
    required this.skills,
    required this.languages,
    required this.reviews,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: (json['id'] ?? '').toString(),
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      status: json['status'] ?? '',
      experience: json['experience'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      restaurantId: (json['restaurantId'] ?? '').toString(),
      avatarUrl: json['avatarUrl'],
      skills: List<String>.from(json['skills'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((review) => StaffReview.fromJson(review))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'status': status,
      'experience': experience,
      'rating': rating,
      'restaurantId': restaurantId,
      'avatarUrl': avatarUrl,
      'skills': skills,
      'languages': languages,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }

  Staff copyWith({
    String? id,
    String? name,
    String? position,
    String? status,
    String? experience,
    double? rating,
    String? restaurantId,
    String? avatarUrl,
    List<String>? skills,
    List<String>? languages,
    List<StaffReview>? reviews,
  }) {
    return Staff(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      status: status ?? this.status,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      restaurantId: restaurantId ?? this.restaurantId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      skills: skills ?? this.skills,
      languages: languages ?? this.languages,
      reviews: reviews ?? this.reviews,
    );
  }
}

class StaffReview {
  final String id;
  final String userName;
  final String content;
  final double rating;
  final DateTime date;
  
  StaffReview({
    required this.id,
    required this.userName,
    required this.content,
    required this.rating,
    required this.date,
  });

  factory StaffReview.fromJson(Map<String, dynamic> json) {
    return StaffReview(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      content: json['content'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'content': content,
      'rating': rating,
      'date': date.toIso8601String(),
    };
  }
}