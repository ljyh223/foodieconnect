import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../data/models/staff_model.dart';
import '../../core/services/api_service.dart';

/// 店员评价组件
class ShopStaffSection extends StatelessWidget {
  final String restaurantId;
  final Future<List<Staff>> Function() loadStaff;
  final VoidCallback onViewAllStaff;

  const ShopStaffSection({
    super.key,
    required this.restaurantId,
    required this.loadStaff,
    required this.onViewAllStaff,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.sentiment_neutral_outlined,
                color: Colors.black,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                t.staff.staffReviews,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<Staff>>(
            future: loadStaff(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                return _buildEmptyState();
              }

              final staffList = snapshot.data!.take(3).toList();

              return Column(
                children: [
                  ...staffList.map((staff) => _buildStaffCard(staff)),
                  const SizedBox(height: 12),
                  _buildViewAllButton(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        Text(
          t.staff.noStaffInfo,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onViewAllStaff,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              t.staff.viewAllStaff,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStaffCard(Staff staff) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStaffAvatar(staff),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStaffInfo(staff),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffAvatar(Staff staff) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: staff.avatarUrl != null && staff.avatarUrl!.isNotEmpty
            ? Image.network(
                ApiService.getFullImageUrl(staff.avatarUrl!),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      staff.name.isNotEmpty ? staff.name.substring(0, 1) : '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  staff.name.isNotEmpty ? staff.name.substring(0, 1) : '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildStaffInfo(Staff staff) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              staff.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              staff.position,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildRatingStars(staff.rating),
            const SizedBox(width: 8),
            Text(
              staff.rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        if (staff.experience.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            '${t.staff.experience}：${staff.experience}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.orange,
          size: 14,
        );
      }),
    );
  }

  Widget _buildViewAllButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onViewAllStaff,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          t.staff.viewAllStaff,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
