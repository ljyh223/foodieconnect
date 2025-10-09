import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as logger;

class TokenStorage {
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

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

  static Future<void> deleteAll() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    try {
      logger.log('TokenStorage.deleteAll called');
    } catch (_) {}
  }
}
