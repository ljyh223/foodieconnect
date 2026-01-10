import '../../core/errors/api_error.dart';
import '../../data/models/staff_model.dart';
import 'staff_api.dart';

class StaffRepository {
  /// 获取员工详情
  Future<Staff> getStaffById(String id) async {
    try {
      return await StaffApi.getStaffById(id);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 根据餐厅获取员工列表
  Future<List<Staff>> getStaffByRestaurant(String restaurantId) async {
    try {
      return await StaffApi.getStaffByRestaurant(restaurantId);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 根据状态获取员工列表
  Future<List<Staff>> getStaffByStatus(String status) async {
    try {
      return await StaffApi.getStaffByStatus(status);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取员工评价列表
  Future<List<StaffReview>> getStaffReviews(
    String staffId, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      return await StaffApi.getStaffReviews(staffId, page: page, size: size);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }
}
