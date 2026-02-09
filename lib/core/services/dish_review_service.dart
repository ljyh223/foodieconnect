import 'dart:io';
import 'dart:developer' as logger;
import '../../data/models/dish_review_model.dart';
import '../../features/dish_review/dish_review_repository.dart';
import 'api_service.dart';

/// 菜品评价服务类
class DishReviewService {
  static final DishReviewRepository _repository = DishReviewRepository();
  static final ApiService _apiService = ApiService();

  /// 获取菜品评价列表
  static Future<List<DishReview>> listByMenuItem(
    String restaurantId,
    String menuItemId, {
    int page = 0,
    int size = 20,
    String sortBy = 'latest',
  }) async {
    try {
      return await _repository.getDishReviews(
        restaurantId,
        menuItemId,
        page: page,
        size: size,
        sortBy: sortBy,
      );
    } catch (e) {
      logger.log('获取菜品评价失败: $e');
      return <DishReview>[];
    }
  }

  /// 创建菜品评价
  static Future<DishReview> create(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
  ) async {
    try {
      return await _repository.createDishReview(
        restaurantId,
        menuItemId,
        rating,
        comment,
        [],
      );
    } catch (e) {
      logger.log('创建菜品评价失败: $e');
      rethrow;
    }
  }

  /// 创建带图片的菜品评价
  static Future<DishReview> createWithImages(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
    List<String> imageUrls,
  ) async {
    try {
      return await _repository.createDishReview(
        restaurantId,
        menuItemId,
        rating,
        comment,
        imageUrls,
      );
    } catch (e) {
      logger.log('创建带图片的菜品评价失败: $e');
      rethrow;
    }
  }

  /// 创建带图片文件的菜品评价
  static Future<DishReview> createWithImageFiles(
    String restaurantId,
    String menuItemId,
    int rating,
    String comment,
    List<File> imageFiles,
  ) async {
    try {
      // 先上传图片获取URL
      final List<String> imageUrls = [];
      if (imageFiles.isNotEmpty) {
        imageUrls.addAll(await _apiService.uploadImagesAndGetUrls(imageFiles));
      }

      // 创建评价
      return await createWithImages(
        restaurantId,
        menuItemId,
        rating,
        comment,
        imageUrls,
      );
    } catch (e) {
      logger.log('创建带图片文件的菜品评价失败: $e');
      rethrow;
    }
  }

  /// 更新菜品评价
  static Future<DishReview> update(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
  ) async {
    try {
      return await _repository.updateDishReview(
        restaurantId,
        reviewId,
        rating,
        comment,
        [],
      );
    } catch (e) {
      logger.log('更新菜品评价失败: $e');
      rethrow;
    }
  }

  /// 更新带图片的菜品评价
  static Future<DishReview> updateWithImages(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
    List<String> imageUrls,
  ) async {
    try {
      return await _repository.updateDishReview(
        restaurantId,
        reviewId,
        rating,
        comment,
        imageUrls,
      );
    } catch (e) {
      logger.log('更新带图片的菜品评价失败: $e');
      rethrow;
    }
  }

  /// 更新带图片文件的菜品评价
  static Future<DishReview> updateWithImageFiles(
    String restaurantId,
    String reviewId,
    int rating,
    String comment,
    List<File> imageFiles,
  ) async {
    try {
      // 先上传图片获取URL
      final List<String> imageUrls = [];
      if (imageFiles.isNotEmpty) {
        imageUrls.addAll(await _apiService.uploadImagesAndGetUrls(imageFiles));
      }

      // 更新评价
      return await updateWithImages(
        restaurantId,
        reviewId,
        rating,
        comment,
        imageUrls,
      );
    } catch (e) {
      logger.log('更新带图片文件的菜品评价失败: $e');
      rethrow;
    }
  }

  /// 删除菜品评价
  static Future<void> delete(
    String restaurantId,
    String reviewId,
  ) async {
    try {
      await _repository.deleteDishReview(restaurantId, reviewId);
    } catch (e) {
      logger.log('删除菜品评价失败: $e');
      rethrow;
    }
  }

  /// 获取菜品评分统计
  static Future<DishReviewStats> getStats(
    String restaurantId,
    String menuItemId,
  ) async {
    try {
      return await _repository.getDishReviewStats(
        restaurantId,
        menuItemId,
      );
    } catch (e) {
      logger.log('获取菜品评分统计失败: $e');
      return DishReviewStats(
        averageRating: 0.0,
        totalReviews: 0,
        ratingDistribution: {},
      );
    }
  }

  /// 检查是否已评价
  static Future<DishReviewCheck?> checkReviewed(
    String restaurantId,
    String menuItemId,
  ) async {
    try {
      return await _repository.checkUserReviewed(
        restaurantId,
        menuItemId,
      );
    } catch (e) {
      logger.log('检查是否已评价失败: $e');
      return null;
    }
  }

  /// 获取用户的菜品评价
  static Future<List<DishReview>> getMyReviews(
    String restaurantId, {
    int page = 0,
    int size = 20,
    String? menuItemId,
  }) async {
    try {
      return await _repository.getMyDishReviews(
        restaurantId,
        page: page,
        size: size,
        menuItemId: menuItemId,
      );
    } catch (e) {
      logger.log('获取用户菜品评价失败: $e');
      return <DishReview>[];
    }
  }

  /// 获取菜品评价详情
  static Future<DishReview?> getDetail(
    String restaurantId,
    String menuItemId,
    String reviewId,
  ) async {
    try {
      return await _repository.getDishReviewDetail(
        restaurantId,
        menuItemId,
        reviewId,
      );
    } catch (e) {
      logger.log('获取菜品评价详情失败: $e');
      return null;
    }
  }
}
