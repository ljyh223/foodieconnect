import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/review_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class ReviewService {
  static final ApiService _api = ApiService();

  /// 获取餐厅评论列表
  static Future<List<Review>> listByRestaurant(String restaurantId, {int page = 0, int size = 20}) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final res = await _api.get(endpoint, queryParams: {'page': page.toString(), 'size': size.toString()});
    final dynamic payload = res['data'] ?? res;
    
    // 调试输出，帮助分析数据结构
    debugPrint('ReviewService API Response: $payload');
    
    if (payload is Map<String, dynamic>) {
      // 检查是否有records字段（分页结构）
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        debugPrint('Found ${records.length} reviews in records field');
        return records.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
      // 检查是否有content字段
      else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        debugPrint('Found ${content.length} reviews in content field');
        return content.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
      // 直接是数组
      else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        debugPrint('Found ${data.length} reviews in data field');
        return data.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
      }
    }
    if (payload is List) {
      debugPrint('Found ${payload.length} reviews in payload list');
      return payload.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    debugPrint('No reviews found, returning empty list');
    return <Review>[];
  }

  /// 发布评论
  static Future<Review> post(String restaurantId, int rating, String comment) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final body = {'rating': rating, 'comment': comment};
    final res = await _api.post(endpoint, body: body);
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return Review.fromJson(payload);
    throw Exception('发布评论失败');
  }

  /// 发布带图片的评论
  static Future<Review> postWithImages(String restaurantId, int rating, String comment, List<String> imageUrls) async {
    final endpoint = AppConstants.restaurantsReviewsEndpoint.replaceFirst('{restaurantId}', restaurantId);
    final body = {
      'rating': rating,
      'comment': comment,
      'imageUrls': imageUrls.isNotEmpty ? imageUrls.join(',') : null, // 图片URL列表，多个URL用逗号分隔
    };
    final res = await _api.post(endpoint, body: body);
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return Review.fromJson(payload);
    throw Exception('发布评论失败');
  }

  /// 上传图片并发布评论
  static Future<Review> postWithImageFiles(String restaurantId, int rating, String comment, List<File> imageFiles) async {
    List<String> imageUrls = [];
    
    // 如果有图片，先上传图片
    if (imageFiles.isNotEmpty) {
      imageUrls = await _api.uploadImages(imageFiles);
    }
    
    // 发布带图片URL的评论
    return postWithImages(restaurantId, rating, comment, imageUrls);
  }
}
