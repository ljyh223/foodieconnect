import 'package:flutter/foundation.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../data/models/staff_model.dart';
import '../../core/services/staff_service.dart';

class StaffProvider with ChangeNotifier {
  List<Staff> _staffs = [];
  Staff? _selectedStaff;
  bool _isLoading = false;
  String? _error;

  List<Staff> get staffs => _staffs;
  Staff? get selectedStaff => _selectedStaff;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchByRestaurant(String restaurantId) async {
    _setLoading(true);
    _error = null;
    try {
      _staffs = await StaffService.listByRestaurant(restaurantId);
    } catch (e) {
      _error = t.staff.loadStaffFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchDetail(String id) async {
    _setLoading(true);
    _error = null;
    try {
      _selectedStaff = await StaffService.getById(id);
    } catch (e) {
      _error = t.staff.loadStaffDetailFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
