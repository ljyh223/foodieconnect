import 'package:flutter/material.dart';

/// 评分显示组件 - 只显示星星，不可交互
class RatingDisplayWidget extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final String? suffix;

  const RatingDisplayWidget({
    super.key,
    required this.rating,
    this.size = 14,
    this.color = Colors.orange,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _buildStars(),
          style: TextStyle(
            color: color,
            fontSize: size,
            letterSpacing: 2,
          ),
        ),
        if (suffix != null) ...[
          const SizedBox(width: 4),
          Text(
            suffix!,
            style: TextStyle(
              color: color,
              fontSize: size,
            ),
          ),
        ],
      ],
    );
  }

  String _buildStars() {
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
