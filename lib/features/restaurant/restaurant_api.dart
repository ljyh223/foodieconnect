import '../../network/dio_client.dart';
import '../../data/models/restaurant_model.dart';
import '../../core/constants/app_constants.dart';

/// 餐厅API层，处理与服务器的直接通信
class RestaurantApi {
  /// 获取餐厅列表
  static Future<Map<String, dynamic>> list({
    int page = 0,
    int size = 20,
    String? type,
    double? lat,
    double? lng,
    int? radius,
    String? keyword,
    String? sort,
  }) async {
    final query = <String, dynamic>{
      'page': page.toString(),
      'size': size.toString(),
    };
    if (type != null) query['type'] = type;
    if (lat != null) query['lat'] = lat.toString();
    if (lng != null) query['lng'] = lng.toString();
    if (radius != null) query['radius'] = radius.toString();
    if (keyword != null) query['keyword'] = keyword;
    if (sort != null) query['sort'] = sort;

    final response = await DioClient.dio.get(
      AppConstants.restaurantsEndpoint,
      queryParameters: query,
    );
    return response.data;
  }

  /// 获取餐厅详情
  static Future<Map<String, dynamic>> get(String id) async {
    final response = await DioClient.dio.get(
      '${AppConstants.restaurantsEndpoint}/$id',
    );
    return response.data;
  }

  /// 获取热门餐厅
  static Future<List<Restaurant>> popular() async {
    final response = await DioClient.dio.get(
      '${AppConstants.restaurantsEndpoint}/popular',
    );
    final dynamic payload = response.data['data'] ?? response.data;
    final List<dynamic> list = payload is List
        ? payload
        : (payload is Map<String, dynamic>
              ? (payload['content'] as List<dynamic>? ?? [])
              : []);
    return list
        .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取餐厅菜单
  static Future<Map<String, dynamic>> getMenu(String restaurantId) async {
    final response = await DioClient.dio.get(
      '${AppConstants.restaurantsEndpoint}/$restaurantId/menu',
    );
    return response.data;
  }

  /// 获取餐厅推荐菜品
  static Future<List<String>> getRecommendedDishes(String restaurantId) async {
    final response = await DioClient.dio.get(
      '${AppConstants.restaurantsEndpoint}/$restaurantId/recommended-dishes',
    );
    final dynamic payload = response.data['data'] ?? response.data;

    List<String> result = [];
    if (payload is List) {
      result = payload
          .map((item) {
            if (item is String) return item;
            if (item is Map<String, dynamic>) {
              return item['name'] ?? item['dishName'] ?? '';
            }
            return '';
          })
          .where((name) => name.isNotEmpty)
          .cast<String>()
          .toList();
    } else if (payload is Map<String, dynamic>) {
      final dishes = payload['dishes'] ?? payload['recommendedDishes'] ?? [];
      if (dishes is List) {
        result = dishes
            .map((item) {
              if (item is String) return item;
              if (item is Map<String, dynamic>) {
                return item['name'] ?? item['dishName'] ?? '';
              }
              return '';
            })
            .where((name) => name.isNotEmpty)
            .cast<String>()
            .toList();
      }
    }

    return result;
  }
}
