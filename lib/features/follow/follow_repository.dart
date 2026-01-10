import '../../core/errors/api_error.dart';
import '../../data/models/follow_model.dart';
import '../../data/models/user_model.dart';
import 'follow_api.dart';

class FollowRepository {
  /// 关注用户
  Future<Follow> followUser({
    required int followerId,
    required int followingId,
  }) async {
    try {
      return await FollowApi.followUser(
        followerId: followerId,
        followingId: followingId,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 取消关注用户
  Future<void> unfollowUser({
    required int followerId,
    required int followingId,
  }) async {
    try {
      await FollowApi.unfollowUser(
        followerId: followerId,
        followingId: followingId,
      );
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取用户的关注列表
  Future<List<User>> getFollowingList(int userId) async {
    try {
      return await FollowApi.getFollowingList(userId);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 获取用户的粉丝列表
  Future<List<User>> getFollowersList(int userId) async {
    try {
      return await FollowApi.getFollowersList(userId);
    } catch (e) {
      throw ApiError.fromException(e);
    }
  }

  /// 检查是否已关注某个用户
  Future<bool> isFollowing({required int userId}) async {
    try {
      return await FollowApi.isFollowing(userId: userId);
    } catch (e) {
      // 检查关注状态失败时返回false
      return false;
    }
  }

  /// 获取关注关系详情
  Future<Follow?> getFollowRelation({
    required int followerId,
    required int followingId,
  }) async {
    try {
      return await FollowApi.getFollowRelation(
        followerId: followerId,
        followingId: followingId,
      );
    } catch (e) {
      // 获取关注关系失败时返回null
      return null;
    }
  }

  /// 获取用户的关注统计信息
  Future<Map<String, int>> getFollowStats(int userId) async {
    try {
      return await FollowApi.getFollowStats(userId);
    } catch (e) {
      // 获取关注统计失败时返回默认值
      return {'following': 0, 'followers': 0};
    }
  }
}
