import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../presentation/providers/dish_review_provider.dart';
import '../presentation/widgets/review_image_grid.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

/// 创建/编辑菜品评价页面
class CreateDishReviewScreen extends StatefulWidget {
  final String? restaurantId;
  final String? menuItemId;
  final String? itemName;
  final String? reviewId;

  const CreateDishReviewScreen({
    super.key,
    this.restaurantId,
    this.menuItemId,
    this.itemName,
    this.reviewId,
  });

  @override
  State<CreateDishReviewScreen> createState() => _CreateDishReviewScreenState();
}

class _CreateDishReviewScreenState extends State<CreateDishReviewScreen> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 5.0;
  bool _submitting = false;
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  bool get _isEditing => widget.reviewId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadExistingReview();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadExistingReview() async {
    setState(() {
      _controller.text = '';
      _rating = 5.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.restaurantId != null
        ? null
        : (ModalRoute.of(context)?.settings.arguments as Map?);
    final itemName = widget.itemName ?? args?['itemName'] as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(itemName),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (itemName != null) _buildDishInfo(itemName),
              _buildRatingSection(),
              const SizedBox(height: 16),
              _buildCommentSection(),
              const SizedBox(height: 16),
              _buildImageSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String? itemName) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        _isEditing ? t.review.publishReview : '评价菜品 - ${itemName ?? ''}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  _isEditing ? t.review.publish : t.review.publish,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildDishInfo(String itemName) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant_menu, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '评价菜品: $itemName',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '评分',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    _rating = (index + 1).toDouble();
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '评价内容',
          style: TextStyle(
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
            controller: _controller,
            maxLines: null,
            expands: false,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: '分享您的用餐体验...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '添加图片 (最多9张)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        ReviewImageGrid(
          images: _images,
          onAddImage: _showImagePickerOptions,
          onRemoveImage: _removeImage,
        ),
        if (_images.length < 9) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt, size: 18),
                  label: const Text('拍照'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.photo_library, size: 18),
                  label: const Text('相册'),
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

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.black),
              title: const Text('拍照',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.black),
              title: const Text('从相册选择',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (image != null) {
        final processedImage = await _processImageFile(File(image.path));
        if (processedImage != null) {
          setState(() {
            _images.add(processedImage);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('拍照失败: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final images = await _picker.pickMultiImage(
        imageQuality: 80,
      );
      final List<File> processedImages = [];

      for (final xFile in images) {
        if (processedImages.length >= (9 - _images.length)) break;

        final processedImage = await _processImageFile(File(xFile.path));
        if (processedImage != null) {
          processedImages.add(processedImage);
        }
      }

      setState(() {
        _images.addAll(processedImages);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('选择图片失败: $e')),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();

    final args = widget.restaurantId != null
        ? null
        : (ModalRoute.of(context)?.settings.arguments as Map?);
    final restaurantId = widget.restaurantId ?? args?['restaurantId'] as String?;
    final menuItemId = widget.menuItemId ?? args?['menuItemId'] as String?;
    final reviewId = widget.reviewId ?? args?['reviewId'] as String?;

    if (restaurantId == null || menuItemId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('参数错误')),
      );
      return;
    }

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入评价内容')),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      final provider = Provider.of<DishReviewProvider>(
        context,
        listen: false,
      );

      if (_isEditing && reviewId != null) {
        await provider.updateReviewWithImageFiles(
          restaurantId,
          reviewId,
          _rating.toInt(),
          text,
          _images,
        );
      } else {
        await provider.createReviewWithImageFiles(
          restaurantId,
          menuItemId,
          _rating.toInt(),
          text,
          _images,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing ? '评价已更新' : t.review.reviewPublished)),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${t.review.publishFailed}$e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<File?> _processImageFile(File imageFile) async {
    try {
      final fileExtension = path.extension(imageFile.path).toLowerCase();

      if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
        return imageFile;
      }

      final imageBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        return imageFile;
      }

      final tempDir = Directory.systemTemp;
      final jpegFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final jpegFile = File(path.join(tempDir.path, jpegFileName));

      final jpegBytes = img.encodeJpg(originalImage, quality: 85);
      await jpegFile.writeAsBytes(jpegBytes);

      return jpegFile;
    } catch (e) {
      return imageFile;
    }
  }
}
