import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/staff_model.dart';

class StaffService {
  static final ApiService _api = ApiService();

  static Future<Staff> getById(String id) async {
  final res = await _api.get('${AppConstants.staffEndpoint}/$id');
  final dynamic payload = res['data'] ?? res;
    if (payload is! Map<String, dynamic> || payload.isEmpty) throw Exception('获取店员详情失败');
    return Staff.fromJson(payload);
  }

  static Future<List<Staff>> listByRestaurant(String restaurantId) async {
  final res = await _api.get('${AppConstants.staffEndpoint}/restaurant/$restaurantId');
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    return <Staff>[];
  }

  static Future<List<Staff>> listByStatus(String status) async {
  final res = await _api.get('${AppConstants.staffEndpoint}/status/$status');
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
    return <Staff>[];
  }
}
