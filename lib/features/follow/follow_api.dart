import 'package:flutter/foundation.dart';
import '../../network/dio_client.dart';
import '../../data/models/follow_model.dart';
import '../../data/models/user_model.dart';

/// 关注相关API
class FollowApi {
  /// 关注用户
  static Future<Follow> followUser({
    required int followerId,
    required int followingId,
  }) async {
    final response = await DioClient.dio.post('/api/follows/$followingId');

    // 处理响应 - API可能返回空body或只返回success
    final dynamic payload = response.data['data'] ?? response.data;

    if (payload != null && payload is Map<String, dynamic>) {
      // 如果返回的数据包含必要的字段，则解析Follow对象
      if (payload.containsKey('followerId') || payload.containsKey('followingId')) {
        return Follow.fromJson(payload as Map<String, dynamic>);
      }
      // 如果API只返回success但没有Follow数据，构造一个基本的Follow对象
      return Follow(
        id: 0,
        followerId: followerId,
        followingId: followingId,
        createdAt: DateTime.now(),
      );
    }

    // 如果没有data字段，但请求成功（204或其他），返回基本Follow对象
    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
      return Follow(
        id: 0,
        followerId: followerId,
        followingId: followingId,
        createdAt: DateTime.now(),
      );
    }

    throw Exception('关注失败：服务器返回数据格式不正确');
  }

  /// 取消关注用户
  static Future<void> unfollowUser({
    required int followerId,
    required int followingId,
  }) async {
    await DioClient.dio.delete('/api/follows/$followingId');
  }

  /// 获取用户的关注列表
  static Future<List<User>> getFollowingList(int userId) async {
    final response = await DioClient.dio.get('/api/follows/users/$userId/following');

    // 处理分页响应
    final dynamic data = response.data['data'];
    List<dynamic> records = [];

    if (data is Map<String, dynamic>) {
      if (data.containsKey('records')) {
        records = data['records'] as List<dynamic>? ?? [];
      } else if (data.containsKey('content')) {
        records = data['content'] as List<dynamic>? ?? [];
      }
    } else if (data is List) {
      records = data;
    }

    // 提取 followingId 并获取用户信息
    final List<User> users = [];
    for (final record in records) {
      if (record is Map<String, dynamic>) {
        final followingId = record['followingId'] as int?;
        if (followingId != null) {
          try {
            final userResponse = await DioClient.dio.get('/api/users/$followingId');
            final userData = userResponse.data['data'];
            if (userData != null) {
              users.add(User.fromJson(userData as Map<String, dynamic>));
            }
          } catch (e) {
            debugPrint('Failed to fetch user $followingId: $e');
          }
        }
      }
    }

    return users;
  }

  /// 获取用户的粉丝列表
  static Future<List<User>> getFollowersList(int userId) async {
    final response = await DioClient.dio.get('/api/follows/users/$userId/followers');

    // 处理分页响应
    final dynamic data = response.data['data'];
    List<dynamic> records = [];

    if (data is Map<String, dynamic>) {
      if (data.containsKey('records')) {
        records = data['records'] as List<dynamic>? ?? [];
      } else if (data.containsKey('content')) {
        records = data['content'] as List<dynamic>? ?? [];
      }
    } else if (data is List) {
      records = data;
    }

    // 提取 followerId 并获取用户信息
    final List<User> users = [];
    for (final record in records) {
      if (record is Map<String, dynamic>) {
        final followerId = record['followerId'] as int?;
        if (followerId != null) {
          try {
            final userResponse = await DioClient.dio.get('/api/users/$followerId');
            final userData = userResponse.data['data'];
            if (userData != null) {
              users.add(User.fromJson(userData as Map<String, dynamic>));
            }
          } catch (e) {
            debugPrint('Failed to fetch user $followerId: $e');
          }
        }
      }
    }

    return users;
  }

  /// 检查是否已关注某个用户
  static Future<bool> isFollowing({required int userId}) async {
    final response = await DioClient.dio.get('/api/follows/check/$userId');
    return response.data['data'] ?? false;
  }

  /// 获取关注关系详情
  static Future<Follow?> getFollowRelation({
    required int followerId,
    required int followingId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        '/api/follows/users/$followerId/following/$followingId',
      );
      final data = response.data['data'];

      if (data != null) {
        return Follow.fromJson(data);
      }
    } catch (e) {
      // 如果出错返回null
      return null;
    }
    return null;
  }

  /// 获取用户的关注统计信息
  static Future<Map<String, int>> getFollowStats(int userId) async {
    final response = await DioClient.dio.get('/api/follows/users/$userId/following/stats');
    final data = response.data['data'] ?? {};

    return {
      'following': (data['following'] ?? 0) as int,
      'followers': (data['followers'] ?? 0) as int,
    };
  }
}
