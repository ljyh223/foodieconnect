import 'package:dio/dio.dart';
import '../../core/errors/api_error.dart';
import '../../data/models/restaurant_model.dart';
import 'restaurant_api.dart';

/// 餐厅仓库层，封装业务逻辑
class RestaurantRepository {
  /// 获取餐厅列表
  Future<Map<String, dynamic>> fetchRestaurants({
    int page = 0,
    int size = 20,
    String? type,
    double? lat,
    double? lng,
    int? radius,
    String? keyword,
    String? sort,
  }) async {
    try {
      final response = await RestaurantApi.list(
        page: page,
        size: size,
        type: type,
        lat: lat,
        lng: lng,
        radius: radius,
        keyword: keyword,
        sort: sort,
      );

      // 统一 payload：优先使用 res['data']，否则使用 res
      final dynamic payload = response['data'] ?? response;

      List<dynamic> content = [];
      if (payload is List) {
        // 如果 data 直接是数组
        content = payload;
      } else if (payload is Map<String, dynamic>) {
        // 如果 data 是对象，尝试获取 records 或 content
        if (payload.containsKey('records')) {
          content = payload['records'] as List<dynamic>? ?? [];
        } else if (payload.containsKey('content')) {
          content = payload['content'] as List<dynamic>? ?? [];
        }
      }

      final restaurants = content
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList();

      final metaKeys = ['totalElements', 'totalPages', 'currentPage', 'size'];
      final meta = <String, dynamic>{};
      if (payload is Map<String, dynamic>) {
        for (final k in metaKeys) {
          if (payload.containsKey(k)) meta[k] = payload[k];
        }
      }
      return {'content': restaurants, 'meta': meta};
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取餐厅详情
  Future<Restaurant> fetchRestaurantDetail(String id) async {
    try {
      final response = await RestaurantApi.get(id);
      final dynamic payload = response['data'] ?? response;

      if (payload is! Map<String, dynamic>) {
        throw Exception('Failed to retrieve restaurant details');
      }

      // 根据API文档，data字段包含餐厅信息
      // 尝试获取推荐菜品（如果API返回了）
      List<dynamic> recommendedDishes = [];
      if (payload.containsKey('recommendedDishes')) {
        final dishes = payload['recommendedDishes'] as List<dynamic>?;
        if (dishes != null) {
          for (var dish in dishes) {
            if (dish is String) {
              // 兼容旧格式，只有名称的情况
              recommendedDishes.add(dish);
            } else if (dish is Map<String, dynamic>) {
              // 新格式：完整的菜品对象，直接保存
              recommendedDishes.add(dish);
            }
          }
        }
      }

      // 创建餐厅对象，并添加推荐菜品
      final restaurantData = Map<String, dynamic>.from(payload['restaurant']);
      restaurantData['recommendedDishes'] = recommendedDishes;

      return Restaurant.fromJson(restaurantData);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取热门餐厅
  Future<List<Restaurant>> fetchPopularRestaurants() async {
    try {
      return await RestaurantApi.popular();
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取餐厅菜单
  Future<Map<String, dynamic>> fetchRestaurantMenu(String restaurantId) async {
    try {
      final response = await RestaurantApi.getMenu(restaurantId);
      final dynamic payload = response['data'] ?? response;
      if (payload is! Map<String, dynamic>) {
        throw Exception('Failed to retrieve restaurant menu');
      }
      return payload;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      // 如果菜单API不存在或失败，返回空数据
      throw ApiError.unknown('Menu function is not yet available.');
    }
  }

  /// 获取餐厅推荐菜品
  Future<List<String>> fetchRecommendedDishes(String restaurantId) async {
    try {
      return await RestaurantApi.getRecommendedDishes(restaurantId);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
