import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';

/// 餐厅基础信息组件
class ShopBasicInfoSection extends StatelessWidget {
  final String hours;
  final String phone;
  final double rating;
  final int reviewCount;
  final VoidCallback onTap;

  const ShopBasicInfoSection({
    super.key,
    required this.hours,
    required this.phone,
    required this.rating,
    required this.reviewCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  t.restaurant.basicInfo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: Icons.schedule,
              label: t.restaurant.businessHours,
              value: hours,
            ),
            _buildInfoRow(
              icon: Icons.phone,
              label: t.restaurant.phone,
              value: phone,
            ),
            _buildInfoRow(
              icon: Icons.star,
              label: t.restaurant.rating,
              value: '$rating/5.0',
              subtitle: t.restaurant.totalReviews(count: reviewCount),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$label：$value',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
