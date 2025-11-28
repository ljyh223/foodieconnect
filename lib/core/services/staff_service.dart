import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/staff_model.dart';
import 'package:flutter/foundation.dart';

class StaffService {
  static final ApiService _api = ApiService();

  static Future<Staff> getById(String id) async {
  final res = await _api.get(
    '${AppConstants.staffEndpoint}/$id',
    requireAuth: false, // 获取员工详情不需要认证
  );
  final dynamic payload = res['data'] ?? res;
    if (payload is! Map<String, dynamic> || payload.isEmpty) throw Exception('Failed to retrieve employee details');
    return Staff.fromJson(payload);
  }

  static Future<List<Staff>> listByRestaurant(String restaurantId) async {
  final res = await _api.get(
    '${AppConstants.staffEndpoint}/restaurant/$restaurantId',
    requireAuth: false, // 获取餐厅员工列表不需要认证
  );
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    return <Staff>[];
  }

  static Future<List<Staff>> listByStatus(String status) async {
  final res = await _api.get(
    '${AppConstants.staffEndpoint}/status/$status',
    requireAuth: false, // 按状态获取员工列表不需要认证
  );
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    return <Staff>[];
  }

  /// 获取店员评价列表
  static Future<List<StaffReview>> getStaffReviews(String staffId, {int page = 0, int size = 10}) async {
    final endpoint = '${AppConstants.staffEndpoint}/$staffId/reviews';
    final res = await _api.get(
      endpoint,
      queryParams: {
        'page': page.toString(),
        'size': size.toString(),
      },
      requireAuth: false, // 获取员工评价不需要认证
    );
    final dynamic payload = res['data'] ?? res;
    
    debugPrint('StaffService.getStaffReviews API Response: $payload');
    
    if (payload is Map<String, dynamic>) {
      // 检查是否有records字段（分页结构）
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        debugPrint('Found ${records.length} staff reviews in records field');
        return records.map((e) => StaffReview.fromJson(e)).toList();
      }
      // 检查是否有content字段
      else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        debugPrint('Found ${content.length} staff reviews in content field');
        return content.map((e) => StaffReview.fromJson(e)).toList();
      }
      // 直接是数组
      else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        debugPrint('Found ${data.length} staff reviews in data field');
        return data.map((e) => StaffReview.fromJson(e)).toList();
      }
    }
    if (payload is List) {
      debugPrint('Found ${payload.length} staff reviews in payload list');
      return payload.map((e) => StaffReview.fromJson(e)).toList();
    }
    
    debugPrint('No staff reviews found, returning empty list');
    return <StaffReview>[];
  }
}
