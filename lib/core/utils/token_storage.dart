import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as logger;

class TokenStorage {
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';
  static const _userIdKey = 'user_id';

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    final normalized = accessToken.startsWith('Bearer ') ? accessToken.substring(7) : accessToken;
    await _storage.write(key: _accessKey, value: normalized);
    if (refreshToken != null) {
      await _storage.write(key: _refreshKey, value: refreshToken);
    }
    try {
      logger.log('TokenStorage.saveTokens: access saved length=${normalized.length} refreshSaved=${refreshToken!=null}');
    } catch (_) {}
  }

  static Future<String?> readAccessToken() async {
    final t = await _storage.read(key: _accessKey);
    try {
      logger.log('TokenStorage.readAccessToken: gotLength=${t?.length ?? 0}');
    } catch (_) {}
    return t;
  }

  static Future<String?> readRefreshToken() async {
    final t = await _storage.read(key: _refreshKey);
    try {
      logger.log('TokenStorage.readRefreshToken: gotLength=${t?.length ?? 0}');
    } catch (_) {}
    return t;
  }

  static Future<void> saveUserId(int userId) async {
    await _storage.write(key: _userIdKey, value: userId.toString());
    try {
      logger.log('TokenStorage.saveUserId: userId=$userId saved');
    } catch (_) {}
  }

  static Future<int?> readUserId() async {
    final userIdStr = await _storage.read(key: _userIdKey);
    if (userIdStr != null) {
      try {
        final userId = int.parse(userIdStr);
        logger.log('TokenStorage.readUserId: userId=$userId retrieved');
        return userId;
      } catch (e) {
        logger.log('TokenStorage.readUserId: Failed to parse userId: $e');
      }
    }
    return null;
  }

  static Future<void> deleteAll() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    await _storage.delete(key: _userIdKey);
    try {
      logger.log('TokenStorage.deleteAll called');
    } catch (_) {}
  }
}
