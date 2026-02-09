import 'package:flutter/foundation.dart';
import '../../data/models/dish_review_model.dart';
import '../../core/services/dish_review_service.dart';
import 'dart:io';

/// 菜品评价 Provider
class DishReviewProvider with ChangeNotifier {
  List<DishReview> _reviews = [];
  bool _isLoading = false;
  String? _error;
  DishReviewStats? _stats;
  DishReviewCheck? _checkResult;

  List<DishReview> get reviews => _reviews;
  bool get isLoading => _isLoading;
  String? get error => _error;
  DishReviewStats? get stats => _stats;
  DishReviewCheck? get checkResult => _checkResult;

  /// 获取菜品评价列表
  Future<void> fetchByMenuItem(
    String restaurantId,
    String menuItemId, {
    int page = 0,
    int size = 20,
    String sortBy = 'latest',
  }) async {
    _setLoading(true);
    _error = null;
    try {
      _reviews = await DishReviewService.listByMenuItem(
        restaurantId,
        menuItemId,
        page: page,
        size: size,
        sortBy: sortBy,
      );
    } catch (e) {
      _error = '获取菜品评价失败: $e';
    } finally {
      _setLoading(false);
    }
  }

  /// 创建菜品评价
  Future<void> createReview(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await DishReviewService.create(
        restaurantId,
        menuItemId,
        rating,
        comment,
      );
      _reviews.insert(0, review);
    } catch (e) {
      _error = '创建菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 创建带图片的菜品评价
  Future<void> createReviewWithImages(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
    List<String> imageUrls,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await DishReviewService.createWithImages(
        restaurantId,
        menuItemId,
        rating,
        comment,
        imageUrls,
      );
      _reviews.insert(0, review);
    } catch (e) {
      _error = '创建菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 创建带图片文件的菜品评价
  Future<void> createReviewWithImageFiles(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
    List<File> imageFiles,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await DishReviewService.createWithImageFiles(
        restaurantId,
        menuItemId,
        rating,
        comment,
        imageFiles,
      );
      _reviews.insert(0, review);
    } catch (e) {
      _error = '创建菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 更新菜品评价
  Future<void> updateReview(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await DishReviewService.update(
        restaurantId,
        reviewId,
        rating,
        comment,
      );
      // 更新列表中的评价
      final reviewIdInt = int.tryParse(reviewId) ?? 0;
      final index = _reviews.indexWhere((r) => r.id == reviewIdInt);
      if (index != -1) {
        _reviews[index] = review;
      }
    } catch (e) {
      _error = '更新菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 更新带图片的菜品评价
  Future<void> updateReviewWithImages(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
    List<String> imageUrls,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await DishReviewService.updateWithImages(
        restaurantId,
        reviewId,
        rating,
        comment,
        imageUrls,
      );
      // 更新列表中的评价
      final reviewIdInt = int.tryParse(reviewId) ?? 0;
      final index = _reviews.indexWhere((r) => r.id == reviewIdInt);
      if (index != -1) {
        _reviews[index] = review;
      }
    } catch (e) {
      _error = '更新菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 更新带图片文件的菜品评价
  Future<void> updateReviewWithImageFiles(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
    List<File> imageFiles,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await DishReviewService.updateWithImageFiles(
        restaurantId,
        reviewId,
        rating,
        comment,
        imageFiles,
      );
      // 更新列表中的评价
      final reviewIdInt = int.tryParse(reviewId) ?? 0;
      final index = _reviews.indexWhere((r) => r.id == reviewIdInt);
      if (index != -1) {
        _reviews[index] = review;
      }
    } catch (e) {
      _error = '更新菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 删除菜品评价
  Future<void> deleteReview(
    String restaurantId,
    String reviewId,
  ) async {
    _setLoading(true);
    _error = null;
    try {
      await DishReviewService.delete(
        restaurantId,
        reviewId,
      );
      // 从列表中移除评价
      final reviewIdInt = int.tryParse(reviewId) ?? 0;
      _reviews.removeWhere((r) => r.id == reviewIdInt);
    } catch (e) {
      _error = '删除菜品评价失败: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 获取菜品评分统计
  Future<void> fetchStats(
    String restaurantId,
    String menuItemId,
  ) async {
    _error = null;
    try {
      _stats = await DishReviewService.getStats(
        restaurantId,
        menuItemId,
      );
    } catch (e) {
      _error = '获取菜品评分统计失败: $e';
    }
  }

  /// 检查是否已评价
  Future<void> checkReviewed(
    String restaurantId,
    String menuItemId,
  ) async {
    _error = null;
    try {
      _checkResult = await DishReviewService.checkReviewed(
        restaurantId,
        menuItemId,
      );
    } catch (e) {
      _error = '检查是否已评价失败: $e';
    }
  }

  /// 获取用户的菜品评价
  Future<void> fetchMyReviews(
    String restaurantId, {
    int page = 0,
    int size = 20,
    String? menuItemId,
  }) async {
    _setLoading(true);
    _error = null;
    try {
      _reviews = await DishReviewService.getMyReviews(
        restaurantId,
        page: page,
        size: size,
        menuItemId: menuItemId,
      );
    } catch (e) {
      _error = '获取用户菜品评价失败: $e';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  /// 清空数据
  void clear() {
    _reviews = [];
    _stats = null;
    _checkResult = null;
    _error = null;
    notifyListeners();
  }
}
