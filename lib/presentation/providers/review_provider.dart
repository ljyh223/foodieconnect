import 'package:flutter/foundation.dart';
import 'package:tabletalk/generated/translations.g.dart';
import '../../data/models/review_model.dart';
import '../../core/services/review_service.dart';
import 'dart:io';

class ReviewProvider with ChangeNotifier {
  List<Review> _reviews = [];
  bool _isLoading = false;
  String? _error;

  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchByRestaurant(String restaurantId) async {
    _setLoading(true);
    _error = null;
    try {
      _reviews = await ReviewService.listByRestaurant(restaurantId);
    } catch (e) {
      _error = t.review.loadReviewFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> postReview(String restaurantId, int rating, String comment) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await ReviewService.post(restaurantId, rating, comment);
      _reviews.insert(0, review);
    } catch (e) {
      _error = t.review.postReviewFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// 发布带图片的评价
  Future<void> postReviewWithImages(String restaurantId, int rating, String comment, List<String> imageUrls, int userId) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await ReviewService.postWithImages(restaurantId, rating, comment, imageUrls);
      _reviews.insert(0, review);
    } catch (e) {
      _error = t.review.postReviewFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// 上传图片并发布评价
  Future<void> postReviewWithImageFiles(String restaurantId, int rating, String comment, List<File> imageFiles, int userId) async {
    _setLoading(true);
    _error = null;
    try {
      final review = await ReviewService.postWithImageFiles(restaurantId, rating, comment, imageFiles);
      _reviews.insert(0, review);
    } catch (e) {
      _error = t.review.postReviewFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
