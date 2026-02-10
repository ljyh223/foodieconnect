import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import 'package:foodieconnect/mixins/create_review_mixin.dart';
import 'package:foodieconnect/core/services/staff_service.dart';
import 'dart:io';

/// 创建服务员评价页面
class CreateStaffReviewScreen extends StatefulWidget {
  final String? staffId;
  final String? staffName;

  const CreateStaffReviewScreen({
    super.key,
    this.staffId,
    this.staffName,
  });

  @override
  State<CreateStaffReviewScreen> createState() => _CreateStaffReviewScreenState();
}

class _CreateStaffReviewScreenState extends State<CreateStaffReviewScreen>
    with CreateReviewMixin {
  final TextEditingController _controller = TextEditingController();
  double _rating = 5.0;
  bool _submitting = false;
  final List<File> _images = []; // 不使用图片，但 mixin 需要

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
  Widget build(BuildContext context) {
    final args = widget.staffId != null
        ? null
        : (ModalRoute.of(context)?.settings.arguments as Map?);
    final staffName = widget.staffName ?? args?['staffName'] as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(staffName),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (staffName != null) _buildStaffInfo(staffName),
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
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String? staffName) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        '评价服务员 - ${staffName ?? ''}',
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
    );
  }

  Widget _buildStaffInfo(String staffName) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '评价服务员: $staffName',
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

  Future<void> _submit() async {
    final text = _controller.text.trim();

    final args = widget.staffId != null
        ? null
        : (ModalRoute.of(context)?.settings.arguments as Map?);
    final staffId = widget.staffId ?? args?['staffId'] as String?;

    if (staffId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('缺少服务员ID')),
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
      await StaffService.createReview(
        staffId,
        rating: _rating,
        content: text,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('评价已发布')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('评价失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }
}
