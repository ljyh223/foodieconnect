import '../../core/errors/api_error.dart';
import '../../data/models/dish_review_model.dart';
import 'dish_review_api.dart';

/// 菜品评价仓库类
class DishReviewRepository {
  /// 获取菜品评价列表
  Future<List<DishReview>> getDishReviews(
    String restaurantId,
    String menuItemId, {
    int page = 0,
    int size = 20,
    String sortBy = 'latest',
  }) async {
    try {
      return await DishReviewApi.getDishReviews(
        restaurantId,
        menuItemId,
        page: page,
        size: size,
        sortBy: sortBy,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 创建菜品评价
  Future<DishReview> createDishReview(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
    List<String> images,
  ) async {
    try {
      return await DishReviewApi.createDishReview(
        restaurantId,
        menuItemId,
        rating,
        comment,
        images,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 更新菜品评价
  Future<DishReview> updateDishReview(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
    List<String> images,
  ) async {
    try {
      return await DishReviewApi.updateDishReview(
        restaurantId,
        reviewId,
        rating,
        comment,
        images,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 删除菜品评价
  Future<void> deleteDishReview(
    String restaurantId,
    String reviewId,
  ) async {
    try {
      await DishReviewApi.deleteDishReview(restaurantId, reviewId);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取菜品评分统计
  Future<DishReviewStats> getDishReviewStats(
    String restaurantId,
    String menuItemId,
  ) async {
    try {
      return await DishReviewApi.getDishReviewStats(
        restaurantId,
        menuItemId,
      );
    } catch (e) {
      // 如果获取失败，返回默认值
      return DishReviewStats(
        averageRating: 0.0,
        totalReviews: 0,
        ratingDistribution: {},
      );
    }
  }

  /// 检查是否已评价
  Future<DishReviewCheck> checkUserReviewed(
    String restaurantId,
    String menuItemId,
  ) async {
    try {
      return await DishReviewApi.checkUserReviewed(
        restaurantId,
        menuItemId,
      );
    } catch (e) {
      // 如果获取失败，返回未评价
      return DishReviewCheck(hasReviewed: false);
    }
  }

  /// 获取用户的菜品评价
  Future<List<DishReview>> getMyDishReviews(
    String restaurantId, {
    int page = 0,
    int size = 20,
    String? menuItemId,
  }) async {
    try {
      return await DishReviewApi.getMyDishReviews(
        restaurantId,
        page: page,
        size: size,
        menuItemId: menuItemId,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取菜品评价详情
  Future<DishReview> getDishReviewDetail(
    String restaurantId,
    String menuItemId,
    String reviewId,
  ) async {
    try {
      return await DishReviewApi.getDishReviewDetail(
        restaurantId,
        menuItemId,
        reviewId,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }
}
