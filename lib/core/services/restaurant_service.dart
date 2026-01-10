import '../../data/models/restaurant_model.dart';
import '../../features/restaurant/restaurant_repository.dart';

class RestaurantService {
  static final RestaurantRepository _repository = RestaurantRepository();

  /// 获取餐厅列表，返回 { content: List<Restaurant>, meta: {...} }
  static Future<Map<String, dynamic>> list({int page = 0, int size = 20, String? type, double? lat, double? lng, int? radius, String? keyword, String? sort}) async {
    return await _repository.fetchRestaurants(
      page: page,
      size: size,
      type: type,
      lat: lat,
      lng: lng,
      radius: radius,
      keyword: keyword,
      sort: sort,
    );
  }

  /// 获取餐厅详情
  static Future<Restaurant> get(String id) async {
    return await _repository.fetchRestaurantDetail(id);
  }

  /// 获取热门餐厅
  static Future<List<Restaurant>> popular() async {
    return await _repository.fetchPopularRestaurants();
  }

  /// 获取餐厅菜单
  static Future<Map<String, dynamic>> getMenu(String restaurantId) async {
    return await _repository.fetchRestaurantMenu(restaurantId);
  }

  /// 获取餐厅推荐菜品
  static Future<List<String>> getRecommendedDishes(String restaurantId) async {
    try {
      return await _repository.fetchRecommendedDishes(restaurantId);
    } catch (e) {
      return [];
    }
  }
}
