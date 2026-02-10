import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../utils/image_utils.dart';
import '../presentation/widgets/review/image_viewer_screen.dart';
import '../presentation/widgets/review/image_picker_bottom_sheet.dart';
import '../presentation/widgets/review/rating_selector_widget.dart';

/// 创建评价界面的通用逻辑 Mixin
mixin CreateReviewMixin<T extends StatefulWidget> on State<T> {
  final ImagePicker _picker = ImagePicker();

  /// 获取图片列表
  List<File> get reviewImages;

  /// 设置图片列表
  void setReviewImages(List<File> images);

  /// 构建评分区域
  Widget buildReviewRatingSection({
    required double rating,
    required ValueChanged<double> onRatingChanged,
    String title = '评分',
    Color activeColor = Colors.orange,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          RatingSelectorWidget(
            rating: rating,
            onChanged: onRatingChanged,
            activeColor: activeColor,
          ),
        ],
      ),
    );
  }

  /// 构建评价内容区域
  Widget buildReviewCommentSection({
    required TextEditingController controller,
    String title = '评价内容',
    String hintText = '分享您的用餐体验...',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          constraints: const BoxConstraints(minHeight: 150),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: false,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12.0),
            ),
          ),
        ),
      ],
    );
  }

  /// 构建图片区域
  Widget buildReviewImageSection({
    required VoidCallback onShowPicker,
    bool showButtons = true,
    String title = '添加图片 (最多9张)',
    String addImageText = '添加图片',
    String buttonCameraText = '拍照',
    String buttonGalleryText = '相册',
    String cameraFailedText = '拍照失败',
    String galleryFailedText = '选择图片失败',
  }) {
    final images = reviewImages;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        _buildImageGrid(images, onShowPicker, addImageText),
        if (showButtons && images.length < 9) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => pickImageFromCamera(failedText: cameraFailedText),
                  icon: const Icon(Icons.camera_alt, size: 18),
                  label: Text(buttonCameraText),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => pickImageFromGallery(failedText: galleryFailedText),
                  icon: const Icon(Icons.photo_library, size: 18),
                  label: Text(buttonGalleryText),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildImageGrid(List<File> images, VoidCallback onShowPicker, String addImageText) {
    if (images.isEmpty) {
      return GestureDetector(
        onTap: onShowPicker,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey),
                SizedBox(height: 4),
                Text(addImageText, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      );
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
      itemCount: images.length < 9 ? images.length + 1 : images.length,
      itemBuilder: (context, index) {
        if (index == images.length && images.length < 9) {
          return GestureDetector(
            onTap: onShowPicker,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.add, size: 32, color: Colors.grey),
              ),
            ),
          );
        }

        return Stack(
          children: [
            GestureDetector(
              onTap: () => viewImage(index),
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
                onTap: () => removeImage(index),
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
      },
    );
  }

  /// 显示图片选择器
  void showImagePicker({
    required VoidCallback onCameraSelected,
    required VoidCallback onGallerySelected,
    String cameraText = '拍照',
    String galleryText = '从相册选择',
    Color? iconColor,
  }) {
    showImagePickerBottomSheet(
      context,
      cameraText: cameraText,
      galleryText: galleryText,
      iconColor: iconColor ?? Colors.black,
      onCameraSelected: onCameraSelected,
      onGallerySelected: onGallerySelected,
    );
  }

  /// 从相机拍照
  Future<void> pickImageFromCamera({String failedText = '拍照失败'}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (image != null) {
        final processedImage = await ImageUtils.convertToJpeg(File(image.path));
        if (reviewImages.length < 9) {
          setReviewImages([...reviewImages, processedImage]);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$failedText: $e')),
        );
      }
    }
  }

  /// 从相册选择图片
  Future<void> pickImageFromGallery({String failedText = '选择图片失败'}) async {
    try {
      final images = await _picker.pickMultiImage(imageQuality: 80);
      final newImages = <File>[];
      for (final xFile in images) {
        if (reviewImages.length + newImages.length >= 9) break;
        final processedImage = await ImageUtils.convertToJpeg(File(xFile.path));
        newImages.add(processedImage);
      }
      if (newImages.isNotEmpty) {
        setReviewImages([...reviewImages, ...newImages]);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$failedText: $e')),
        );
      }
    }
  }

  /// 查看图片
  void viewImage(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(
          images: reviewImages,
          initialIndex: index,
        ),
      ),
    );
  }

  /// 删除图片
  void removeImage(int index) {
    final newImages = List<File>.from(reviewImages);
    newImages.removeAt(index);
    setReviewImages(newImages);
  }
}
