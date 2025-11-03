import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// 新消息提示组件
class NewMessageIndicator extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onTap;

  const NewMessageIndicator({
    super.key,
    required this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100, // 在输入框上方
      right: 16,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$unreadCount条新消息',
                style: const TextStyle(
                  color: AppColors.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.onPrimary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}