import 'dart:developer' as logger;

import 'api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/user_model.dart';
import '../utils/token_storage.dart';

class AuthService {
  static final ApiService _apiService = ApiService();

  /// 登录，成功时会将 access token 注入到 ApiService 并返回 User
  static Future<User> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    final res = await _apiService.post(AppConstants.loginEndpoint, body: body);
    final dynamic payload = res['data'] ?? res;
    final token =
        (payload['token'] as String?) ?? (payload['accessToken'] as String?);
    final userMap = payload['user'] as Map<String, dynamic>?;

    if (token == null || userMap == null) {
      try {
        logger.log('AuthService.login payload keys: ${payload.keys.toList()}');
      } catch (_) {}
      throw Exception(
        'Login returned an error message indicating a missing token or user.',
      );
    }

    _apiService.setToken(token);
    // persist tokens
    await TokenStorage.saveTokens(
      accessToken: token,
      refreshToken: payload['refreshToken'] as String?,
    );

    // 持久化用户ID
    final user = User.fromJson(userMap);
    await TokenStorage.saveUserId(user.id);

    try {
      logger.log('AuthService.login: token and userId persisted and injected');
    } catch (_) {}
    return user;
  }

  /// 注册，返回 User
  static Future<User> register(
    String email,
    String password,
    String displayName,
  ) async {
    final payload = {
      'email': email,
      'password': password,
      'displayName': displayName,
    };
    final res = await _apiService.post(
      AppConstants.registerEndpoint,
      body: payload,
    );
    final dynamic regPayload = res['data'] ?? res;
    return User.fromJson(regPayload);
  }

  /// 刷新令牌
  static Future<void> refresh(String refreshToken) async {
    // 将 refresh token 临时放入 ApiService 的 Authorization（按后端约定）
    _apiService.setToken(refreshToken);
    final res = await _apiService.post(AppConstants.refreshEndpoint);
    final dynamic refPayload = res['data'] ?? res;
    final token =
        (refPayload['token'] as String?) ??
        (refPayload['accessToken'] as String?);
    final refresh = refPayload['refreshToken'] as String?;
    if (token == null) throw Exception('Refresh token failed');
    _apiService.setToken(token);
    await TokenStorage.saveTokens(accessToken: token, refreshToken: refresh);
  }

  /// 获取当前用户信息
  static Future<User> me() async {
    final res = await _apiService.get(AppConstants.meEndpoint);
    final dynamic mePayload = res['data'] ?? res;
    return User.fromJson(mePayload);
  }

  /// 登出：清除本地 token 并清理 ApiService
  static Future<void> logout() async {
    _apiService.clearToken();
    await TokenStorage.deleteAll();
  }

  /// 获取本地存储的用户ID
  static Future<int?> getCurrentUserId() async {
    return await TokenStorage.readUserId();
  }
}
