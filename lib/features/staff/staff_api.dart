import '../../network/dio_client.dart';
import '../../data/models/staff_model.dart';

class StaffApi {
  /// 获取员工详情
  static Future<Staff> getStaffById(String id) async {
    final endpoint = '/staff/$id';
    final response = await DioClient.dio.get(endpoint);

    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return Staff.fromJson(payload);
    }
    throw Exception('Failed to retrieve staff details');
  }

  /// 根据餐厅获取员工列表
  static Future<List<Staff>> getStaffByRestaurant(String restaurantId) async {
    final endpoint = '/staff/restaurant/$restaurantId';
    final response = await DioClient.dio.get(endpoint);

    final dynamic payload = response.data['data'] ?? response.data;

    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list
          .map((e) => Staff.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (payload is List) {
      return payload
          .map((e) => Staff.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return <Staff>[];
  }

  /// 根据状态获取员工列表
  static Future<List<Staff>> getStaffByStatus(String status) async {
    final endpoint = '/staff/status/$status';
    final response = await DioClient.dio.get(endpoint);

    final dynamic payload = response.data['data'] ?? response.data;

    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list
          .map((e) => Staff.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (payload is List) {
      return payload
          .map((e) => Staff.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return <Staff>[];
  }

  /// 获取员工评价列表
  static Future<List<StaffReview>> getStaffReviews(
    String staffId, {
    int page = 0,
    int size = 10,
  }) async {
    final endpoint = '/staff/$staffId/reviews';
    final response = await DioClient.dio.get(
      endpoint,
      queryParameters: {'page': page, 'size': size},
    );

    final dynamic payload = response.data['data'] ?? response.data;

    List<StaffReview> reviews = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        reviews = records
            .map((e) => StaffReview.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('content')) {
        final content = payload['content'] as List<dynamic>? ?? [];
        reviews = content
            .map((e) => StaffReview.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final data = payload['data'] as List<dynamic>? ?? [];
        reviews = data
            .map((e) => StaffReview.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      reviews = payload
          .map((e) => StaffReview.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return reviews;
  }
}
