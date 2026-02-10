import 'package:flutter/material.dart';
import '../core/services/api_service.dart';
import '../presentation/widgets/review/image_viewer_screen.dart';

/// 评价列表通用逻辑 Mixin
mixin ReviewListMixin<T extends StatefulWidget> on State<T> {
  /// 构建图片网格
  Widget buildReviewImageGrid(List<String> images) {
    final imageCount = images.length;

    if (imageCount == 1) {
      return _buildSingleImage(images[0]);
    } else if (imageCount <= 3) {
      return _buildHorizontalImages(images);
    } else {
      return _buildGridImages(images);
    }
  }

  /// 单张图片
  Widget _buildSingleImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        ApiService.getFullImageUrl(imageUrl),
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 200,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  /// 2-3张图片水平排列
  Widget _buildHorizontalImages(List<String> images) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              ApiService.getFullImageUrl(images[index]),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// 多张图片网格布局
  Widget _buildGridImages(List<String> images) {
    final imageCount = images.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: imageCount > 9 ? 9 : imageCount,
      itemBuilder: (context, index) {
        if (index == 8 && imageCount > 9) {
          // 第9个位置显示剩余图片数量
          return GestureDetector(
            onTap: () => showImageViewer(context, images, index),
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: Center(
                child: Text(
                  '+${imageCount - 9}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () => showImageViewer(context, images, index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              ApiService.getFullImageUrl(images[index]),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// 显示图片查看器
  void showImageViewer(
    BuildContext context,
    List<String> images,
    int initialIndex,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}
