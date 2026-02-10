import 'package:flutter/material.dart';

/// 图片选择器底部弹窗
void showImagePickerBottomSheet(
  BuildContext context, {
  required VoidCallback onCameraSelected,
  required VoidCallback onGallerySelected,
  String cameraText = '拍照',
  String galleryText = '从相册选择',
  Color? iconColor,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: iconColor ?? Colors.black),
            title: Text(
              cameraText,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
              onCameraSelected();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: iconColor ?? Colors.black),
            title: Text(
              galleryText,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.pop(context);
              onGallerySelected();
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
