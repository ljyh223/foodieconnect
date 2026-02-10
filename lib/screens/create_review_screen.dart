import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../presentation/providers/review_provider.dart';
import '../presentation/providers/auth_provider.dart';
import '../mixins/create_review_mixin.dart';
import 'dart:io';

class CreateReviewScreen extends StatefulWidget {
  final String? restaurantId;

  const CreateReviewScreen({super.key, this.restaurantId});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen>
    with CreateReviewMixin {
  final TextEditingController _controller = TextEditingController();
  double _rating = 5.0;
  bool _submitting = false;
  final List<File> _images = [];

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

  Future<int?> _getCurrentUserId() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.setContext(context);
      return await authProvider.getCurrentUserId();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          t.review.publishReview,
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
                    t.review.publish,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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

  void _showImagePickerOptions() {
    showImagePicker(
      onCameraSelected: () => pickImageFromCamera(),
      onGallerySelected: () => pickImageFromGallery(),
    );
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    final restaurantId = widget.restaurantId;

    if (restaurantId == null || restaurantId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.restaurant.restaurantInfoInvalid)),
      );
      return;
    }

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.review.pleaseEnterReviewContent)),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      await Provider.of<ReviewProvider>(
        context,
        listen: false,
      ).postReviewWithImageFiles(
        restaurantId,
        _rating.toInt(),
        text,
        _images,
        await _getCurrentUserId() ?? 1,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.review.reviewPublished)),
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
