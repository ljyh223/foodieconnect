import 'package:flutter/foundation.dart';
import '../../data/models/review_model.dart';
import '../../core/services/review_service.dart';

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
      _error = '获取评论失败，使用本地回退：${e.toString()}';
      _reviews = [];
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
      _error = '发布评论失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
