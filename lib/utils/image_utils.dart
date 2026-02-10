import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

/// 图片处理工具类
class ImageUtils {
  /// 处理图片文件，确保格式为JPEG
  ///
  /// 如果图片不是JPEG格式，会转换为JPEG
  /// 转换失败则返回原文件
  static Future<File> convertToJpeg(File imageFile) async {
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
        return imageFile; // 返回原文件，让服务器处理
      }

      // 创建临时JPEG文件
      final tempDir = Directory.systemTemp;
      final jpegFileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final jpegFile = File(path.join(tempDir.path, jpegFileName));

      // 将图片保存为JPEG格式
      final jpegBytes = img.encodeJpg(originalImage, quality: 85);
      await jpegFile.writeAsBytes(jpegBytes);

      return jpegFile;
    } catch (e) {
      return imageFile; // 返回原文件，让服务器处理
    }
  }

  /// 处理图片文件列表，确保格式为JPEG
  static Future<List<File>> convertListToJpeg(List<File> imageFiles) async {
    final List<File> results = [];
    for (final file in imageFiles) {
      final converted = await convertToJpeg(file);
      results.add(converted);
    }
    return results;
  }
}
