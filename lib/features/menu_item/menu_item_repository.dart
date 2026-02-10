import 'package:dio/dio.dart';
import '../../core/errors/api_error.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/menu_category_model.dart';
import 'menu_item_api.dart';

class MenuItemRepository {
  /// 获取餐厅的所有菜品
  Future<List<MenuItem>> fetchMenuItems(String restaurantId, {int page = 0, int size = 20}) async {
    try {
      final response = await MenuItemApi.getMenuItems(restaurantId, page: page, size: size);
      return response;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取餐厅菜品分类
  Future<List<MenuCategory>> fetchCategories(String restaurantId) async {
    try {
      final response = await MenuItemApi.getCategories(restaurantId);
      return response;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 根据分类获取菜品
  Future<List<MenuItem>> fetchItemsByCategory(
    String restaurantId,
    int categoryId, {
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await MenuItemApi.getItemsByCategory(
        restaurantId,
        categoryId,
        page: page,
        size: size,
      );
      return response;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 全局搜索菜品
  Future<List<MenuItem>> searchMenuItems(
    String keyword, {
    int page = 0,
    int size = 20,
  }) async {
    try {
      final response = await MenuItemApi.searchMenuItems(
        keyword,
        page: page,
        size: size,
      );
      return response;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取菜品详情
  Future<MenuItem> fetchMenuItemDetail(String menuItemId) async {
    try {
      final response = await MenuItemApi.getMenuItemDetail(menuItemId);
      return response;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
