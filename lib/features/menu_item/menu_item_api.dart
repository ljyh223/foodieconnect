import '../../network/dio_client.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/menu_category_model.dart';

/// 菜品API类
class MenuItemApi {
  /// 获取餐厅菜品列表
  static Future<List<MenuItem>> getMenuItems(String restaurantId, {int page = 0, int size = 20}) async {
    final response = await DioClient.dio.get(
      '/restaurants/$restaurantId/menu-items',
      queryParameters: {
        'page': page,
        'size': size,
      },
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<MenuItem> menuItems = [];

    if (payload is Map<String, dynamic>) {
      // 分页响应格式，检查 records 字段
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        menuItems = records
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('items')) {
        final items = payload['items'] as List<dynamic>? ?? [];
        menuItems = items
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('categories')) {
        // 如果有分类，需要处理
        final categories = payload['categories'] as List<dynamic>? ?? [];
        for (var category in categories) {
          if (category is Map<String, dynamic> && category['items'] != null) {
            final items = category['items'] as List<dynamic>? ?? [];
            menuItems.addAll(
              items.map((e) => MenuItem.fromJson(e as Map<String, dynamic>)),
            );
          }
        }
      } else if (payload['data'] is List) {
        final items = payload['data'] as List<dynamic>? ?? [];
        menuItems = items
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      menuItems = payload
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return menuItems;
  }

  /// 获取推荐菜品
  static Future<List<MenuItem>> getRecommendedItems(String restaurantId) async {
    final allItems = await getMenuItems(restaurantId);
    return allItems.where((item) => item.isRecommended).toList();
  }

  /// 获取餐厅菜品分类列表
  static Future<List<MenuCategory>> getCategories(String restaurantId) async {
    final response = await DioClient.dio.get(
      '/restaurants/$restaurantId/menu-categories',
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<MenuCategory> categories = [];

    if (payload is List) {
      categories = payload
          .map((e) => MenuCategory.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (payload is Map<String, dynamic> && payload.containsKey('categories')) {
      final list = payload['categories'] as List<dynamic>? ?? [];
      categories = list
          .map((e) => MenuCategory.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return categories;
  }

  /// 根据分类获取菜品
  static Future<List<MenuItem>> getItemsByCategory(
    String restaurantId,
    int categoryId, {
    int page = 0,
    int size = 20,
  }) async {
    final response = await DioClient.dio.get(
      '/restaurants/$restaurantId/menu-items/category/$categoryId',
      queryParameters: {
        'page': page,
        'size': size,
      },
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<MenuItem> menuItems = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        menuItems = records
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('items')) {
        final items = payload['items'] as List<dynamic>? ?? [];
        menuItems = items
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final items = payload['data'] as List<dynamic>? ?? [];
        menuItems = items
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      menuItems = payload
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return menuItems;
  }

  /// 全局搜索菜品
  static Future<List<MenuItem>> searchMenuItems(
    String keyword, {
    int page = 0,
    int size = 20,
  }) async {
    final response = await DioClient.dio.get(
      '/menu-items/search',
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
      },
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<MenuItem> menuItems = [];

    if (payload is Map<String, dynamic>) {
      if (payload.containsKey('records')) {
        final records = payload['records'] as List<dynamic>? ?? [];
        menuItems = records
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('items')) {
        final items = payload['items'] as List<dynamic>? ?? [];
        menuItems = items
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload.containsKey('results')) {
        final results = payload['results'] as List<dynamic>? ?? [];
        menuItems = results
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (payload['data'] is List) {
        final items = payload['data'] as List<dynamic>? ?? [];
        menuItems = items
            .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else if (payload is List) {
      menuItems = payload
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return menuItems;
  }
}
