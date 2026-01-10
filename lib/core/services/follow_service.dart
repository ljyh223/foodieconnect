import 'dart:developer' as logger;
import '../../data/models/follow_model.dart';
import '../../data/models/user_model.dart';
import '../../features/follow/follow_repository.dart';

/// 用户关注服务类
class FollowService {
  static final FollowRepository _followRepository = FollowRepository();

  /// 关注用户
  static Future<Follow> followUser({
    required int followerId,
    required int followingId,
  }) async {
    try {
      final result = await _followRepository.followUser(
        followerId: followerId,
        followingId: followingId,
      );
      
      logger.log('关注用户成功: $followerId -> $followingId');
      
      return result;
    } catch (e) {
      logger.log('关注用户失败: $e');
      rethrow;
    }
  }

  /// 取消关注用户
  static Future<bool> unfollowUser({
    required int followerId,
    required int followingId,
  }) async {
    try {
      await _followRepository.unfollowUser(
        followerId: followerId,
        followingId: followingId,
      );
      
      logger.log('取消关注用户成功: $followerId -> $followingId');
      
      return true;
    } catch (e) {
      logger.log('取消关注用户失败: $e');
      rethrow;
    }
  }

  /// 获取用户的关注列表
  static Future<List<User>> getFollowingList(int userId) async {
    try {
      final result = await _followRepository.getFollowingList(userId);
      
      logger.log('获取用户关注列表成功，数量: ${result.length}');
      
      return result;
    } catch (e) {
      logger.log('获取用户关注列表失败: $e');
      rethrow;
    }
  }

  /// 获取用户的粉丝列表
  static Future<List<User>> getFollowersList(int userId) async {
    try {
      final result = await _followRepository.getFollowersList(userId);
      
      logger.log('获取用户粉丝列表成功，数量: ${result.length}');
      
      return result;
    } catch (e) {
      logger.log('获取用户粉丝列表失败: $e');
      rethrow;
    }
  }

  /// 检查是否已关注某个用户
  static Future<bool> isFollowing({
    required int userId
  }) async {
    try {
      return await _followRepository.isFollowing(userId: userId);
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
      final result = await _followRepository.getFollowRelation(
        followerId: followerId,
        followingId: followingId,
      );
      
      if (result != null) {
        logger.log('获取关注关系成功: $followerId -> $followingId');
      }
      
      return result;
    } catch (e) {
      logger.log('获取关注关系失败: $e');
      return null;
    }
  }

  /// 获取用户的关注统计信息
  static Future<Map<String, int>> getFollowStats(int userId) async {
    try {
      final result = await _followRepository.getFollowStats(userId);
      
      logger.log('获取用户关注统计成功: $result');
      
      return result;
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
      rethrow;
    }
  }
}