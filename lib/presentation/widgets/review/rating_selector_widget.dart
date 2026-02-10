import 'package:flutter/material.dart';

/// 评分选择组件 - 可交互的星星评分
class RatingSelectorWidget extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const RatingSelectorWidget({
    super.key,
    required this.rating,
    required this.onChanged,
    this.size = 32,
    this.activeColor = Colors.orange,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: index < rating ? activeColor : inactiveColor,
            size: size,
          ),
          onPressed: () {
            onChanged((index + 1).toDouble());
          },
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(
            minWidth: size + 16,
            minHeight: size + 16,
          ),
        );
      }),
    );
  }
}
