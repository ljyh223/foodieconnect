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
    if (payload is! Map<String, dynamic>) throw Exception('Failed to retrieve restaurant details');
    
    // 根据API文档，data字段包含餐厅信息
    // 尝试获取推荐菜品（如果API返回了）
    List<String> recommendedDishes = [];
    if (payload.containsKey('recommendedDishes')) {
      final dishes = payload['recommendedDishes'] as List<dynamic>?;
      if (dishes != null) {
        for (var dish in dishes) {
          if (dish is String) {
            recommendedDishes.add(dish);
          } else if (dish is Map<String, dynamic>) {
            // 如果是对象，尝试提取name字段
            final name = dish['name'] ?? dish['dishName'] ?? '';
            if (name.isNotEmpty) {
              recommendedDishes.add(name);
            }
          }
        }
      }
    }
    
    // 创建餐厅对象，并添加推荐菜品
    final restaurantData = Map<String, dynamic>.from(payload['restaurant']);
    restaurantData['recommendedDishes'] = recommendedDishes;
    
    return Restaurant.fromJson(restaurantData);
  }

  /// 获取热门餐厅
  static Future<List<Restaurant>> popular() async {
    final res = await _api.get('${AppConstants.restaurantsEndpoint}/popular');
    final dynamic payload = res['data'] ?? res;
    final List<dynamic> list = payload is List ? payload : (payload is Map<String, dynamic> ? (payload['content'] as List<dynamic>? ?? []) : []);
    return list.map((e) => Restaurant.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// 获取餐厅菜单
  static Future<Map<String, dynamic>> getMenu(String restaurantId) async {
    try {
      final res = await _api.get('${AppConstants.restaurantsEndpoint}/$restaurantId/menu');
      final dynamic payload = res['data'] ?? res;
      if (payload is! Map<String, dynamic>) throw Exception('Failed to retrieve restaurant menu');
      return payload;
    } catch (e) {
      // 如果菜单API不存在或失败，返回空数据
      throw Exception('Menu function is not yet available.');
    }
  }

  /// 获取餐厅推荐菜品
  static Future<List<String>> getRecommendedDishes(String restaurantId) async {
    try {
      final res = await _api.get('${AppConstants.restaurantsEndpoint}/$restaurantId/recommended-dishes');
      final dynamic payload = res['data'] ?? res;
      
      if (payload is List) {
        // 如果返回的是列表，直接处理
        final List<String> result = payload.map((item) {
          if (item is String) return item;
          if (item is Map<String, dynamic>) {
            return item['name'] ?? item['dishName'] ?? '';
          }
          return '';
        }).where((name) => name.isNotEmpty).cast<String>().toList();
        return result;
      } else if (payload is Map<String, dynamic>) {
        // 如果返回的是对象，尝试提取菜品列表
        final dishes = payload['dishes'] ?? payload['recommendedDishes'] ?? [];
        if (dishes is List) {
          final List<String> result = dishes.map((item) {
            if (item is String) return item;
            if (item is Map<String, dynamic>) {
              return item['name'] ?? item['dishName'] ?? '';
            }
            return '';
          }).where((name) => name.isNotEmpty).cast<String>().toList();
          return result;
        }
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
