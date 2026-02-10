import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../presentation/providers/dish_review_provider.dart';
import '../mixins/create_review_mixin.dart';
import 'dart:io';

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

class _CreateDishReviewScreenState extends State<CreateDishReviewScreen>
    with CreateReviewMixin {
  final TextEditingController _controller = TextEditingController();
  double _rating = 5.0;
  bool _submitting = false;
  final List<File> _images = [];

  bool get _isEditing => widget.reviewId != null;

  @override
  List<File> get reviewImages => _images;

  @override
  void setReviewImages(List<File> images) {
    setState(() {
      _images.clear();
      _images.addAll(images);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _loadExistingReview();
    }
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
              buildReviewRatingSection(
                rating: _rating,
                onRatingChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              buildReviewCommentSection(
                controller: _controller,
              ),
              const SizedBox(height: 16),
              buildReviewImageSection(
                onShowPicker: _showImagePickerOptions,
              ),
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

  void _showImagePickerOptions() {
    showImagePicker(
      onCameraSelected: () => pickImageFromCamera(),
      onGallerySelected: () => pickImageFromGallery(),
    );
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
}
