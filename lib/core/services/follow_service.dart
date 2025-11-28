import 'dart:developer' as logger;
import 'api_service.dart';
import '../../data/models/follow_model.dart';
import '../../data/models/user_model.dart';

/// 用户关注服务类
class FollowService {
  static final ApiService _apiService = ApiService();

  /// 关注用户
  static Future<Follow> followUser({
    required int followerId,
    required int followingId,
  }) async {
    try {
      final body = {
        'followerId': followerId,
        'followingId': followingId,
      };

      final response = await _apiService.post(
        '/users/follow',
        body: body,
        requireAuth: true, // 关注用户需要认证
      );
      final data = response['data'];
      
      logger.log('关注用户成功: $followerId -> $followingId');
      
      return Follow.fromJson(data);
    } catch (e) {
      logger.log('关注用户失败: $e');
      throw Exception('关注用户失败: $e');
    }
  }

  /// 取消关注用户
  static Future<bool> unfollowUser({
    required int followerId,
    required int followingId,
  }) async {
    try {
      await _apiService.delete(
        '/users/$followerId/follow/$followingId',
        requireAuth: true, // 取消关注需要认证
      );
      
      logger.log('取消关注用户成功: $followerId -> $followingId');
      
      return true;
    } catch (e) {
      logger.log('取消关注用户失败: $e');
      throw Exception('取消关注用户失败: $e');
    }
  }

  /// 获取用户的关注列表
  static Future<List<User>> getFollowingList(int userId) async {
    try {
      final response = await _apiService.get(
        '/users/$userId/following',
        requireAuth: true, // 获取关注列表需要认证
      );
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('获取用户关注列表成功，数量: ${data.length}');
      
      return data.map((json) {
        // 从follow关系中提取用户信息
        if (json['following'] != null) {
          return User.fromJson(json['following']);
        }
        return User.fromJson(json);
      }).toList();
    } catch (e) {
      logger.log('获取用户关注列表失败: $e');
      throw Exception('获取用户关注列表失败: $e');
    }
  }

  /// 获取用户的粉丝列表
  static Future<List<User>> getFollowersList(int userId) async {
    try {
      final response = await _apiService.get(
        '/users/$userId/followers',
        requireAuth: true, // 获取粉丝列表需要认证
      );
      final List<dynamic> data = response['data'] ?? [];
      
      logger.log('获取用户粉丝列表成功，数量: ${data.length}');
      
      return data.map((json) {
        // 从follow关系中提取用户信息
        if (json['follower'] != null) {
          return User.fromJson(json['follower']);
        }
        return User.fromJson(json);
      }).toList();
    } catch (e) {
      logger.log('获取用户粉丝列表失败: $e');
      throw Exception('获取用户粉丝列表失败: $e');
    }
  }

  /// 检查是否已关注某个用户
  static Future<bool> isFollowing({
    required int userId
  }) async {
    try {
      final response = await _apiService.get(
        '/api/follows/check/$userId',
        requireAuth: true, // 检查关注状态需要认证
      );
      final isFollowing = response['data'] ?? false;
      
      return isFollowing;
    } catch (e) {
      logger.log('检查关注状态失败: $e');
      return false;
    }
  }

  /// 获取关注关系详情
  static Future<Follow?> getFollowRelation({
    required int followerId,
    required int followingId,
  }) async {
    try {
      final response = await _apiService.get(
        '/users/$followerId/follow-relation/$followingId',
        requireAuth: true, // 获取关注关系需要认证
      );
      final data = response['data'];
      
      if (data != null) {
        logger.log('获取关注关系成功: $followerId -> $followingId');
        return Follow.fromJson(data);
      }
      
      return null;
    } catch (e) {
      logger.log('获取关注关系失败: $e');
      return null;
    }
  }

  /// 获取用户的关注统计信息
  static Future<Map<String, int>> getFollowStats(int userId) async {
    try {
      final response = await _apiService.get(
        '/users/$userId/follow-stats',
        requireAuth: true, // 获取关注统计需要认证
      );
      final data = response['data'] ?? {};
      
      final stats = <String, int>{
        'following': (data['following'] ?? 0) as int,
        'followers': (data['followers'] ?? 0) as int,
      };
      
      logger.log('获取用户关注统计成功: $stats');
      
      return stats;
    } catch (e) {
      logger.log('获取用户关注统计失败: $e');
      // 如果API调用失败，返回默认值
      return <String, int>{
        'following': 0,
        'followers': 0,
      };
    }
  }

  /// 批量关注用户
  static Future<List<Follow>> followMultipleUsers({
    required int followerId,
    required List<int> followingIds,
  }) async {
    try {
      final List<Follow> follows = [];
      
      for (final followingId in followingIds) {
        final follow = await followUser(
          followerId: followerId,
          followingId: followingId,
        );
        follows.add(follow);
      }
      
      logger.log('批量关注用户成功，数量: ${follows.length}');
      
      return follows;
    } catch (e) {
      logger.log('批量关注用户失败: $e');
      throw Exception('批量关注用户失败: $e');
    }
  }
}