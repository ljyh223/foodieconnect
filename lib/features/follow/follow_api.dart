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
    final body = {'followerId': followerId, 'followingId': followingId};

    final response = await DioClient.dio.post('/users/follow', data: body);
    return Follow.fromJson(response.data['data']);
  }

  /// 取消关注用户
  static Future<void> unfollowUser({
    required int followerId,
    required int followingId,
  }) async {
    await DioClient.dio.delete('/users/$followerId/follow/$followingId');
  }

  /// 获取用户的关注列表
  static Future<List<User>> getFollowingList(int userId) async {
    final response = await DioClient.dio.get('/users/$userId/following');
    final List<dynamic> data = response.data['data'] ?? [];

    return data.map((json) {
      if (json['following'] != null) {
        return User.fromJson(json['following']);
      }
      return User.fromJson(json);
    }).toList();
  }

  /// 获取用户的粉丝列表
  static Future<List<User>> getFollowersList(int userId) async {
    final response = await DioClient.dio.get('/users/$userId/followers');
    final List<dynamic> data = response.data['data'] ?? [];

    return data.map((json) {
      if (json['follower'] != null) {
        return User.fromJson(json['follower']);
      }
      return User.fromJson(json);
    }).toList();
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
    final response = await DioClient.dio.get(
      '/users/$followerId/follow-relation/$followingId',
    );
    final data = response.data['data'];

    if (data != null) {
      return Follow.fromJson(data);
    }
    return null;
  }

  /// 获取用户的关注统计信息
  static Future<Map<String, int>> getFollowStats(int userId) async {
    final response = await DioClient.dio.get('/users/$userId/follow-stats');
    final data = response.data['data'] ?? {};

    return {
      'following': (data['following'] ?? 0) as int,
      'followers': (data['followers'] ?? 0) as int,
    };
  }
}
