import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';

/// 餐厅详情页头部图片组件
class ShopDetailHeader extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const ShopDetailHeader({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    String displayImageUrl = imageUrl ?? '';
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      displayImageUrl = ApiService.getFullImageUrl(imageUrl!);
    }

    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Image.network(
          displayImageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  name.isNotEmpty ? name.substring(0, 1) : '',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
