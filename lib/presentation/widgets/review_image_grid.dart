import 'package:flutter/material.dart';
import 'dart:io';
import 'review/image_viewer_screen.dart';

/// 菜品评价图片网格组件
class ReviewImageGrid extends StatelessWidget {
  final List<File> images;
  final VoidCallback onAddImage;
  final Function(int) onRemoveImage;
  final int maxImages;

  const ReviewImageGrid({
    super.key,
    required this.images,
    required this.onAddImage,
    required this.onRemoveImage,
    this.maxImages = 9,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return _buildEmptyGrid(context);
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: images.length < maxImages ? images.length + 1 : images.length,
      itemBuilder: (context, index) {
        if (index == images.length && images.length < maxImages) {
          return _buildAddButton(context);
        }

        return _buildImageItem(context, index);
      },
    );
  }

  Widget _buildEmptyGrid(BuildContext context) {
    return GestureDetector(
      onTap: onAddImage,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate,
                size: 32,
                color: Colors.grey,
              ),
              SizedBox(height: 4),
              Text(
                '添加图片',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: onAddImage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 32, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _viewImage(context, index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemoveImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  void _viewImage(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }
}
