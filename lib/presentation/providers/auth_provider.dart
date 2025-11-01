import 'dart:developer' as logger;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/api_service.dart';
import '../../core/utils/token_storage.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;

  /// 获取当前用户ID（从本地存储获取）
  Future<int?> getCurrentUserId() async {
    try {
      // 优先从本地存储获取用户ID
      final userId = await AuthService.getCurrentUserId();
      if (userId != null) {
        return userId;
      }
      
      // 如果本地没有，尝试从当前用户对象获取
      if (_user != null) {
        return _user!.id;
      }
      
      // 如果都没有，尝试从API获取并缓存
      debugPrint('本地无用户ID，尝试从API获取');
      final user = await AuthService.me();
      _user = user;
      return user.id;
    } catch (e) {
      debugPrint('获取当前用户ID失败: $e');
      return null;
    }
  }
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  // 使用真实 API 登录，失败时回退到本地模拟（保持开发友好）
  Future<void> login(String email, String password) async {
    _setLoading(true);
    _error = null;

    try {
      final user = await AuthService.login(email, password);
      _user = user;
      _error = null;
    } catch (e) {
      // 回退到模拟行为：保持原来的体验
      logger.log('登录失败：${e.toString()}');

      if (email == 'user@example.com' && password == 'password123') {
        _user = User(
          id: 1,
          email: email,
          displayName: '测试用户',
          phone: '13800138000',
          avatarUrl: null,
        );
        // 在模拟登录时也保存用户ID到本地存储
        await TokenStorage.saveUserId(_user!.id);
        _error = null;
      } else {
        _error = '邮箱或密码错误';
      }
    } finally {
      _setLoading(false);
    }
  }

  // 使用真实 API 注册，失败时返回错误信息
  Future<void> register(String email, String password, String displayName, String phone) async {
    _setLoading(true);
    _error = null;

    try {
      final user = await AuthService.register(email, password, displayName, phone);
      _user = user;
      // 注册成功后保存用户ID到本地存储
      await TokenStorage.saveUserId(user.id);
      _error = null;
    } catch (e) {
      _error = '注册失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  // 登出
  Future<void> logout() async {
    _setLoading(true);

    try {
      // 调用 AuthService.logout 清除 token
      await AuthService.logout();
      _user = null;
      _error = null;
    } catch (e) {
      _error = '登出失败';
    } finally {
      _setLoading(false);
    }
  }

  /// 尝试从安全存储恢复用户状态（在 app 启动时调用）
  Future<void> restoreFromStorage() async {
    _setLoading(true);
    try {
      final access = await TokenStorage.readAccessToken();
      if (access != null && access.isNotEmpty) {
        ApiService().setToken(access);
        // 尝试从后端恢复当前用户
        final user = await AuthService.me();
        _user = user;
        // 确保用户ID也被保存到本地存储
        await TokenStorage.saveUserId(user.id);
      }
    } catch (e) {
      // 不阻塞启动，仅记录错误
      logger.log('恢复登录状态失败：${e.toString()}');
      _error = '恢复登录状态失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  // 更新用户信息（本地模拟）
  Future<void> updateProfile(String displayName, String phone, String? avatarUrl) async {
    _setLoading(true);
    _error = null;

    try {
      await Future.delayed(const Duration(seconds: 1));
      if (_user != null) {
        _user = _user!.copyWith(
          displayName: displayName,
          phone: phone,
          avatarUrl: avatarUrl,
        );
        // 确保用户ID在本地存储中保持最新
        await TokenStorage.saveUserId(_user!.id);
      }
    } catch (e) {
      _error = '更新失败，请稍后重试';
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}