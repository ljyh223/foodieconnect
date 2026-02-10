import '../../data/models/staff_model.dart';
import '../../features/staff/staff_repository.dart';
import 'package:flutter/foundation.dart';

class StaffService {
  static final StaffRepository _staffRepository = StaffRepository();

  static Future<Staff> getById(String id) async {
    try {
      return await _staffRepository.getStaffById(id);
    } catch (e) {
      throw Exception('Failed to retrieve employee details');
    }
  }

  static Future<List<Staff>> listByRestaurant(String restaurantId) async {
    try {
      return await _staffRepository.getStaffByRestaurant(restaurantId);
    } catch (e) {
      debugPrint('Failed to get staff by restaurant: $e');
      return <Staff>[];
    }
  }

  static Future<List<Staff>> listByStatus(String status) async {
    try {
      return await _staffRepository.getStaffByStatus(status);
    } catch (e) {
      debugPrint('Failed to get staff by status: $e');
      return <Staff>[];
    }
  }

  /// 获取店员评价列表
  static Future<List<StaffReview>> getStaffReviews(
    String staffId, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      return await _staffRepository.getStaffReviews(
        staffId,
        page: page,
        size: size,
      );
    } catch (e) {
      debugPrint('Failed to get staff reviews: $e');
      return <StaffReview>[];
    }
  }

  /// 创建店员评价
  static Future<StaffReview> createReview(
    String staffId, {
    required double rating,
    required String content,
  }) async {
    return await _staffRepository.createReview(
      staffId,
      rating: rating,
      content: content,
    );
  }
}
