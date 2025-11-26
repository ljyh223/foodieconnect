import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk/generated/translations.g.dart';
import '../core/constants/app_colors.dart';
import '../presentation/providers/review_provider.dart';
import '../presentation/providers/auth_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class CreateReviewScreen extends StatefulWidget {
  final String? restaurantId;

  const CreateReviewScreen({super.key, this.restaurantId});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 5.0;
  bool _submitting = false;
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 获取当前用户ID
  Future<int?> _getCurrentUserId() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.setContext(context);
      final userId = await authProvider.getCurrentUserId();
      return userId;
    } catch (e) {
      debugPrint('获取用户ID失败: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                : Text(t.review.publish),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 评分选择
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.review.ratingScore,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
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
                ),
              ),
              const SizedBox(height: 16),
              
              // 评价内容输入
              Expanded(
                flex: 2,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.review.reviewContent,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintText: t.review.shareDiningExperience,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // 图片上传区域
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.review.addImages,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_images.isEmpty)
                        _buildEmptyImageGrid()
                      else
                        _buildImageGrid(),
                      const SizedBox(height: 8),
                      if (_images.length < 9)
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _pickImageFromCamera,
                                icon: const Icon(Icons.camera_alt),
                                label: Text(t.review.takePhoto),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _pickImageFromGallery,
                                icon: const Icon(Icons.photo_library),
                                label: Text(t.review.selectFromGallery),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建空图片网格
  Widget _buildEmptyImageGrid() {
    return GestureDetector(
      onTap: _showImagePickerOptions,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_photo_alternate, size: 32, color: Colors.grey),
              const SizedBox(height: 4),
              Text(t.review.addImage, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  // 构建图片网格
  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.0,
      ),
      itemCount: _images.length < 9 ? _images.length + 1 : _images.length,
      itemBuilder: (context, index) {
        if (index == _images.length && _images.length < 9) {
          // 添加图片按钮
          return GestureDetector(
            onTap: _showImagePickerOptions,
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
        
        return Stack(
          children: [
            GestureDetector(
              onTap: () => _viewImage(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _images[index],
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
                onTap: () => _removeImage(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 显示图片选择器选项
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(t.review.takePhoto),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(t.review.selectFromAlbum),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  // 从相机拍照
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        // 强制使用JPEG格式
        preferredCameraDevice: CameraDevice.rear,
      );
      if (image != null) {
        // 确保图片格式为JPEG
        final processedImage = await _processImageFile(File(image.path));
        if (processedImage != null) {
          setState(() {
            _images.add(processedImage);
          });
        }
      }
    } catch (e) {
      // 处理图片选择错误
      if (mounted) {
        debugPrint("拍照失败$e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${t.review.takePhotoFailed}${e.toString()}')),
        );
      }
    }
  }

  // 从相册选择图片
  Future<void> _pickImageFromGallery() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(
        imageQuality: 80,
      );
      if (images != null) {
        // 处理每个选中的图片，确保格式正确
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
      }
    } catch (e) {
      // 处理图片选择错误
      if (mounted) {
        debugPrint("选择图片失败$e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${t.review.selectImageFailed}${e.toString()}')),
        );
      }
    }
  }

  // 查看图片
  void _viewImage(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _ImageViewerScreen(
          images: _images,
          initialIndex: index,
        ),
      ),
    );
  }

  // 删除图片
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  // 提交评价
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
      // 发布评价（包含图片上传）
      await Provider.of<ReviewProvider>(context, listen: false)
          .postReviewWithImageFiles(restaurantId, _rating.toInt(), text, _images, await _getCurrentUserId() ?? 1);
      
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.review.reviewPublished)),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${t.review.publishFailed}${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  // 处理图片文件，确保格式为JPEG
  Future<File?> _processImageFile(File imageFile) async {
    try {
      // 获取文件扩展名
      final fileExtension = path.extension(imageFile.path).toLowerCase();
      
      // 如果已经是JPEG格式，直接返回
      if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
        return imageFile;
      }
      
      // 读取图片
      final imageBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);
      
      if (originalImage == null) {
        debugPrint('无法解码图片文件');
        return imageFile; // 返回原文件，让服务器处理
      }
      
      // 创建临时JPEG文件
      final tempDir = Directory.systemTemp;
      final jpegFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final jpegFile = File(path.join(tempDir.path, jpegFileName));
      
      // 将图片保存为JPEG格式
      final jpegBytes = img.encodeJpg(originalImage, quality: 85);
      await jpegFile.writeAsBytes(jpegBytes);
      
      debugPrint('图片格式已转换为JPEG: ${jpegFile.path}');
      return jpegFile;
    } catch (e) {
      debugPrint('处理图片格式失败: $e');
      return imageFile; // 返回原文件，让服务器处理
    }
  }

}

// 图片查看器页面
class _ImageViewerScreen extends StatefulWidget {
  final List<File> images;
  final int initialIndex;

  const _ImageViewerScreen({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<_ImageViewerScreen> {
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
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${widget.images.length}'),
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
          return Center(
            child: InteractiveViewer(
              child: Image.file(
                widget.images[index],
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
