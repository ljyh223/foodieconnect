import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/restaurant_model.dart';

class RestaurantService {
  static final ApiService _api = ApiService();

  /// 获取餐厅列表，返回 { content: List<Restaurant>, meta: {...} }
  static Future<Map<String, dynamic>> list({int page = 0, int size = 20, String? type, double? lat, double? lng, int? radius, String? keyword, String? sort}) async {
    final query = <String, dynamic>{'page': page.toString(), 'size': size.toString()};
    if (type != null) query['type'] = type;
    if (lat != null) query['lat'] = lat.toString();
    if (lng != null) query['lng'] = lng.toString();
    if (radius != null) query['radius'] = radius.toString();
    if (keyword != null) query['keyword'] = keyword;
    if (sort != null) query['sort'] = sort;

  final res = await _api.get(AppConstants.restaurantsEndpoint, queryParams: query);

  // 统一 payload：优先使用 res['data']，否则使用 res
  final dynamic payload = res['data'] ?? res;
    final content = payload['records'] as List<dynamic>? ?? [];
    final restaurants = content.map((e) => Restaurant.fromJson(e as Map<String, dynamic>)).toList();
    final metaKeys = ['totalElements', 'totalPages', 'currentPage', 'size'];
    final meta = <String, dynamic>{};
    for (final k in metaKeys) {
      if (payload.containsKey(k)) meta[k] = payload[k];
    }
    return {'content': restaurants, 'meta': meta};
  }

  /// 获取餐厅详情
  static Future<Restaurant> get(String id) async {
    final res = await _api.get('${AppConstants.restaurantsEndpoint}/$id');
    final dynamic payload = res['data'] ?? res;
    if (payload is! Map<String, dynamic>) throw Exception('获取餐厅详情失败');
    
    // 根据API文档，data字段包含restaurant和recommendedDishes两个字段
    if (payload.containsKey('restaurant')) {
      final restaurantData = payload['restaurant'] as Map<String, dynamic>;
      // 如果API返回了recommendedDishes，将其合并到餐厅数据中
      if (payload.containsKey('recommendedDishes')) {
        restaurantData['recommendedDishes'] = payload['recommendedDishes'];
      }
      return Restaurant.fromJson(restaurantData);
    } else {
      // 如果没有restaurant字段，假设payload本身就是餐厅数据（向后兼容）
      return Restaurant.fromJson(payload);
    }
  }

  /// 获取热门餐厅
  static Future<List<Restaurant>> popular() async {
    final res = await _api.get('${AppConstants.restaurantsEndpoint}/popular');
    final dynamic payload = (res is Map<String, dynamic> && res.containsKey('data')) ? res['data'] : res;
    final List<dynamic> list = payload is List ? payload : (payload is Map<String, dynamic> ? (payload['content'] as List<dynamic>? ?? []) : []);
    return list.map((e) => Restaurant.fromJson(e as Map<String, dynamic>)).toList();
  }
}
