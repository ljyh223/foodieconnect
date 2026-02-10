import 'package:flutter/material.dart';
import 'dart:io';
import '../../../core/services/api_service.dart';

/// 图片查看器页面 - 支持网络图片和本地图片
class ImageViewerScreen extends StatefulWidget {
  final List<dynamic> images; // List<String> for URLs or List<File> for local files
  final int initialIndex;

  const ImageViewerScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${_currentIndex + 1} / ${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final image = widget.images[index];
          return Center(
            child: InteractiveViewer(
              child: _buildImage(image),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(dynamic image) {
    if (image is File) {
      return Image.file(image, fit: BoxFit.contain);
    } else if (image is String) {
      return Image.network(
        ApiService.getFullImageUrl(image),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.white,
              size: 64,
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
