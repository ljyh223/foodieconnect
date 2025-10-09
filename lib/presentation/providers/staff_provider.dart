import 'package:flutter/foundation.dart';
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
			_error = '获取店员失败，使用本地回退：${e.toString()}';
			_staffs = [
				Staff(
					id: '1',
					name: '张三',
					position: '服务员',
					status: 'ACTIVE',
					experience: '2年',
					rating: 4.5,
					skills: ['接待','点餐'],
					languages: ['中文'],
					reviews: [],
				),
			];
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
			_error = '获取店员详情失败：${e.toString()}';
		} finally {
			_setLoading(false);
		}
	}

	void _setLoading(bool v) {
		_isLoading = v;
		notifyListeners();
	}
}

