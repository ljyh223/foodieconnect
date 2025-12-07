class Restaurant {
  final int id;
  final String name;
  final String type;
  final String distance;
  final String description;
  final String address;
  final String phone;
  final String hours;
  final double rating;
  final int reviewCount;
  final bool isOpen;
  final String? imageUrl; // 改为可空类型，与API保持一致
  final List<String> recommendedDishes;
  final double? averagePrice;
  final String? createdAt;
  final String? updatedAt;
  
  Restaurant({
    required this.id,
    required this.name,
    required this.type,
    required this.distance,
    required this.description,
    required this.address,
    required this.phone,
    required this.hours,
    required this.rating,
    required this.reviewCount,
    required this.isOpen,
    this.imageUrl, // 改为可选参数
    required this.recommendedDishes,
    this.averagePrice, // 人均消费价格，可选参数
    this.createdAt,
    this.updatedAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    // 处理recommendedDishes字段，可能是字符串列表或对象列表
    List<String> recommendedDishes = [];
    if (json['recommendedDishes'] != null) {
      final dishes = json['recommendedDishes'] as List<dynamic>;
      for (var dish in dishes) {
        if (dish is String) {
          recommendedDishes.add(dish);
        } else if (dish is Map<String, dynamic>) {
          // 如果是对象，尝试提取name字段
          final name = dish['name'] ?? dish['dishName'] ?? '';
          if (name.isNotEmpty) {
            recommendedDishes.add(name);
          }
        }
      }
    }

    return Restaurant(
      id: json['id'], // 提供默认值
      name: json['name'],
      type: json['type'],
      distance: json['distance'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'] ,
      hours: json['hours'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isOpen: json['isOpen'] ?? false,
      imageUrl: json['imageUrl'], // 直接使用，允许为null
      recommendedDishes: recommendedDishes,
      averagePrice: json['averagePrice']?.toDouble(), // 从API获取人均消费价格
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'distance': distance,
      'description': description,
      'address': address,
      'phone': phone,
      'hours': hours,
      'rating': rating,
      'reviewCount': reviewCount,
      'isOpen': isOpen,
      'imageUrl': imageUrl,
      'recommendedDishes': recommendedDishes,
      'averagePrice': averagePrice,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  Restaurant copyWith({
    int? id,
    String? name,
    String? type,
    String? distance,
    String? description,
    String? address,
    String? phone,
    String? hours,
    double? rating,
    int? reviewCount,
    bool? isOpen,
    String? imageUrl,
    List<String>? recommendedDishes,
    double? averagePrice,
    String? createdAt,
    String? updatedAt,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      distance: distance ?? this.distance,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      hours: hours ?? this.hours,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isOpen: isOpen ?? this.isOpen,
      imageUrl: imageUrl ?? this.imageUrl,
      recommendedDishes: recommendedDishes ?? this.recommendedDishes,
      averagePrice: averagePrice ?? this.averagePrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}