import 'package:dio/dio.dart';
import '../../core/errors/api_error.dart';
import '../../data/models/chat_message_model.dart';
import 'chat_api.dart';

/// 聊天仓库层，封装业务逻辑
class ChatRepository {
  /// 验证聊天室验证码并获取临时令牌
  Future<Map<String, dynamic>> verifyChatRoom(
    String restaurantId,
    String verificationCode,
  ) async {
    try {
      final response = await ChatApi.verifyChatRoom(
        restaurantId,
        verificationCode,
      );
      // 安全地处理响应数据
      final dynamic payload;
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        payload = response['data'];
      } else {
        payload = response;
      }
      
      if (payload is Map<String, dynamic>) {
        return payload;
      } else if (payload == null) {
        return {};
      } else {
        throw Exception('Chat room verification failed: Invalid response format');
      }
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 以观察者模式加入聊天室（只读模式）
  Future<Map<String, dynamic>> joinAsObserver(String restaurantId) async {
    // 根据新的API设计，观察者模式直接通过WebSocket连接，不需要HTTP API
    // 这里我们只需要获取聊天室信息，然后通过WebSocket直接连接
    try {
      final roomInfo = await ChatApi.getRestaurantChatRoom(restaurantId);
      final dynamic payload = roomInfo['data'] ?? roomInfo;
      if (payload is Map<String, dynamic>) {
        return payload;
      }
      throw Exception('Failed to get chat room information');
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取餐厅聊天室信息
  Future<Map<String, dynamic>> getRestaurantChatRoom(
    String restaurantId,
  ) async {
    try {
      final response = await ChatApi.getRestaurantChatRoom(restaurantId);
      final dynamic payload = response['data'] ?? response;
      if (payload is Map<String, dynamic>) {
        return payload;
      }
      throw Exception('Failed to retrieve chat room information');
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取聊天室消息列表
  Future<List<ChatMessage>> getRoomMessages(
    String roomId, {
    int page = 0,
    int size = 50,
    String? currentUserId,
  }) async {
    try {
      return await ChatApi.getRoomMessages(
        roomId,
        page: page,
        size: size,
        currentUserId: currentUserId,
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 发送聊天室消息（HTTP方式，主要用于备份或WebSocket不可用时）
  Future<ChatMessage> sendRoomMessage(String roomId, String content) async {
    try {
      return await ChatApi.sendRoomMessage(roomId, content);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 离开聊天室
  Future<void> leaveRoom(String roomId) async {
    try {
      await ChatApi.leaveRoom(roomId);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取聊天室信息
  Future<Map<String, dynamic>> getChatRoomInfo(String roomId) async {
    try {
      final response = await ChatApi.getChatRoomInfo(roomId);
      final dynamic payload = response['data'] ?? response;
      if (payload is Map<String, dynamic>) {
        return payload;
      }
      throw Exception('Failed to retrieve chat room information');
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }

  /// 获取聊天室成员列表
  Future<List<Map<String, dynamic>>> getChatRoomMembers(String roomId) async {
    try {
      return await ChatApi.getChatRoomMembers(roomId);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    } catch (e) {
      throw ApiError.unknown(e.toString());
    }
  }
}
