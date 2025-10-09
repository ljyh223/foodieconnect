import 'package:flutter/foundation.dart';
import '../../data/models/restaurant_model.dart';
import '../../core/services/restaurant_service.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  Restaurant? _selectedRestaurant;
  bool _isLoading = false;
  String? _error;
  String? _searchQuery;
  String? _selectedType;

  List<Restaurant> get restaurants => _restaurants;
  Restaurant? get selectedRestaurant => _selectedRestaurant;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get searchQuery => _searchQuery;
  String? get selectedType => _selectedType;

  // 获取餐厅列表
  Future<void> fetchRestaurants({String? type, String? keyword}) async {
    _setLoading(true);
    _error = null;
    _searchQuery = keyword;
    _selectedType = type;

    try {
      final result = await RestaurantService.list(type: type, keyword: keyword);
      _restaurants = result['content'] as List<Restaurant>;

      // 应用过滤（当服务端未支持过滤时）
      if (type != null && type.isNotEmpty) {
        _restaurants = _restaurants.where((r) => r.type == type).toList();
      }

      if (keyword != null && keyword.isNotEmpty) {
        _restaurants = _restaurants
            .where((r) => r.name.contains(keyword) || r.description.contains(keyword))
            .toList();
      }
    } catch (e) {
      // 回退到模拟数据，保持页面在无后端情况下可用
      _error = '获取餐厅失败，使用本地数据回退：${e.toString()}';
      _restaurants = [
        Restaurant(
          id: 1,
          name: '川味轩',
          type: '川菜',
          distance: '500m',
          description: '正宗川菜，麻辣鲜香，环境优雅',
          address: '市中心街道123号',
          phone: '(021) 1234-5678',
          hours: '10:00 - 22:00',
          rating: 4.8,
          reviewCount: 128,
          isOpen: true,
          avatar: '川',
          recommendedDishes: ['宫保鸡丁', '麻婆豆腐'],
        ),
      ];
    } finally {
      _setLoading(false);
    }
  }

  // 设置加载状态
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // 选择餐厅
  void selectRestaurant(Restaurant restaurant) {
    _selectedRestaurant = restaurant;
    notifyListeners();
  }

  // 清除选择
  void clearSelection() {
    _selectedRestaurant = null;
    notifyListeners();
  }

  // 刷新餐厅列表
  Future<void> refreshRestaurants() async {
    fetchRestaurants(type: _selectedType, keyword: _searchQuery);
  }
}
