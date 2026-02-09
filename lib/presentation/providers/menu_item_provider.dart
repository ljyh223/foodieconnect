import 'package:flutter/foundation.dart';
import '../../features/menu_item/menu_item_repository.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/menu_category_model.dart';

class MenuItemProvider with ChangeNotifier {
  final MenuItemRepository _repository = MenuItemRepository();

  List<MenuItem> _menuItems = [];
  List<MenuCategory> _categories = [];
  bool _isLoading = false;
  String? _error;
  int? _selectedCategoryId;
  bool _isAllSelected = true; // 初始状态为"全部"选中
  String _searchKeyword = '';

  List<MenuItem> get menuItems => _menuItems;
  List<MenuItem> get availableItems =>
      _menuItems.where((item) => item.isAvailable).toList();
  List<MenuCategory> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int? get selectedCategoryId => _selectedCategoryId;
  bool get isAllSelected => _isAllSelected;
  String get searchKeyword => _searchKeyword;

  Future<void> fetchMenuItems(String restaurantId) async {
    _setLoading(true);
    _error = null;
    _selectedCategoryId = null;
    _isAllSelected = true; // 获取全部菜品时，"全部"为选中状态
    try {
      _menuItems = await _repository.fetchMenuItems(restaurantId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _menuItems = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCategories(String restaurantId) async {
    _error = null;
    try {
      _categories = await _repository.fetchCategories(restaurantId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _categories = [];
      notifyListeners();
    }
  }

  Future<void> fetchItemsByCategory(String restaurantId, int categoryId) async {
    _setLoading(true);
    _error = null;
    _selectedCategoryId = categoryId;
    _isAllSelected = false; // 选择分类时，"全部"不是选中状态
    try {
      _menuItems = await _repository.fetchItemsByCategory(restaurantId, categoryId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _menuItems = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> searchMenuItems(String keyword) async {
    _setLoading(true);
    _error = null;
    _searchKeyword = keyword;
    _selectedCategoryId = null;
    _isAllSelected = false; // 搜索时，"全部"不是选中状态
    try {
      if (keyword.trim().isEmpty) {
        _menuItems = [];
      } else {
        _menuItems = await _repository.searchMenuItems(keyword);
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
      _menuItems = [];
    } finally {
      _setLoading(false);
    }
  }

  void clearCategoryFilter() {
    _selectedCategoryId = null;
    _isAllSelected = true;
    _searchKeyword = '';
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void clear() {
    _menuItems = [];
    _categories = [];
    _error = null;
    _selectedCategoryId = null;
    _isAllSelected = true;
    _searchKeyword = '';
    notifyListeners();
  }
}
