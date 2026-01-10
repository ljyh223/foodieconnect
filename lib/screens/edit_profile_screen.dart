import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foodieconnect/core/services/api_service.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import 'package:foodieconnect/core/services/auth_service.dart';
import 'package:foodieconnect/data/models/user_model.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/user_service.dart';
import '../core/utils/form_validator.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late User _user;
  final ImagePicker _imagePicker = ImagePicker();
  File? _newAvatarFile;
  String? _pendingAvatarUrl; // 保存上传后的URL，但不立即应用到_user

  late TextEditingController _displayNameController;
  late TextEditingController _bioController;

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeUser());
  }

  Future<void> _initializeUser() async {
    setState(() => _isLoading = true);
    try {
      _user = await AuthService.me();
      _displayNameController = TextEditingController(
        text: _user.displayName ?? '',
      );
      _bioController = TextEditingController(text: _user.bio ?? '');
    } catch (e) {
      print('Error initializing user: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveUserInfo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      String? avatarUrlToSave;

      // 如果有新头像，先上传头像
      if (_newAvatarFile != null) {
        try {
          final uploadResponse = await ApiService().uploadImage(
            _newAvatarFile!,
          );
          avatarUrlToSave = uploadResponse['url'];
          if (avatarUrlToSave == null || avatarUrlToSave.isEmpty) {
            throw Exception('Avatar upload failed: unable to get image URL');
          }
        } catch (e) {
          _showSnackBar('${t.profile.avatarUploadFailed}: $e', AppColors.error);
          rethrow;
        }
      }

      // 更新用户信息（包含可能的新头像URL）
      _user =
          (await UserService.updateUserInfo(
                displayName: _displayNameController.text.trim().isEmpty
                    ? null
                    : _displayNameController.text.trim(),
                bio: _bioController.text.trim().isEmpty
                    ? null
                    : _bioController.text.trim(),
                avatarUrl: avatarUrlToSave,
              ))
              as User;

      _showSnackBar(t.profile.saveSuccess, AppColors.primary);
      Navigator.of(context).pop(_user);
    } catch (e) {
      _showSnackBar(
        '${t.profile.saveFailed}: ${e.toString()}',
        AppColors.error,
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: backgroundColor),
      );
    }
  }

  void _cancelEdit() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(t.profile.editProfile, overflow: TextOverflow.ellipsis),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        foregroundColor: AppColors.onSurface,
        titleSpacing: 0,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _cancelEdit,
            child: Text(
              t.app.cancel,
              style: TextStyle(
                color: _isSaving
                    ? AppColors.onSurfaceVariant
                    : AppColors.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: _isSaving ? null : _saveUserInfo,
            child: _isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    t.profile.save,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildAvatarSection(),
            const SizedBox(height: 24),
            _buildReadOnlyField(label: t.profile.email, value: _user.email),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _displayNameController,
              label: t.profile.username,
              hintText: t.profile.usernameHint,
              validator: FormValidator.validateDisplayName,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _bioController,
              label: t.profile.personalBio,
              hintText: t.profile.introduceYourself,
              validator: FormValidator.validateBio,
              maxLines: 4,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _saveUserInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSaving
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 12),
                          Text(t.profile.saving),
                        ],
                      )
                    : Text(
                        t.profile.save,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isSaving ? null : _cancelEdit,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  t.app.cancel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.outline, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: _newAvatarFile != null
                  ? Image.file(
                      _newAvatarFile!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : (_user.avatarUrl != null && _user.avatarUrl!.isNotEmpty)
                  ? Image.network(
                      _user.avatarUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildDefaultAvatar(),
                    )
                  : _buildDefaultAvatar(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surface, width: 2),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.camera_alt,
                  color: AppColors.onPrimary,
                  size: 16,
                ),
                onPressed: _showAvatarOptions,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Center(
      child: Text(
        _user.displayName?.isNotEmpty == true
            ? _user.displayName!.substring(0, 1).toUpperCase()
            : 'U',
        style: AppTextStyles.headlineMedium.copyWith(
          color: AppColors.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showAvatarOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Text(t.profile.changeAvatar, style: AppTextStyles.titleMedium),
            const SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.photo_camera, color: AppColors.primary),
              title: Text(t.profile.takePhoto, style: AppTextStyles.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: Text(
                t.profile.selectFromGallery,
                style: AppTextStyles.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    final photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 800,
      maxHeight: 800,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (photo != null) await _handleSelectedImage(File(photo.path));
  }

  Future<void> _pickImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (image != null) await _handleSelectedImage(File(image.path));
  }

  Future<void> _handleSelectedImage(File imageFile) async {
    try {
      final processedImage = await _processImageFile(imageFile);
      if (processedImage != null && mounted) {
        setState(() => _newAvatarFile = processedImage);
      }
    } catch (e) {
      _showSnackBar('${t.review.selectImageFailed}$e', AppColors.error);
    }
  }

  Future<File?> _processImageFile(File imageFile) async {
    try {
      final fileExtension = path.extension(imageFile.path).toLowerCase();
      if (fileExtension == '.jpg' ||
          fileExtension == '.jpeg' ||
          fileExtension == '.png' ||
          fileExtension == '.gif' ||
          fileExtension == '.webp') {
        return imageFile;
      }

      final imageBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) return imageFile;

      final tempDir = Directory.systemTemp;
      final jpegFile = File(
        path.join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg'),
      );
      final jpegBytes = img.encodeJpg(originalImage, quality: 85);
      await jpegFile.writeAsBytes(jpegBytes);
      return jpegFile;
    } catch (e) {
      return imageFile;
    }
  }

  Widget _buildReadOnlyField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outline),
          ),
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          t.profile.emailCannotBeChanged,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.onSurfaceVariant,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
            fillColor: AppColors.surface,
            filled: true,
          ),
        ),
      ],
    );
  }
}
