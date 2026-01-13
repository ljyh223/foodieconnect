import '../../network/dio_client.dart';
import '../../data/models/chat_message_model.dart';

/// 聊天API层，处理与服务器的直接通信
class ChatApi {
  /// 验证聊天室验证码并获取临时令牌
  static Future<Map<String, dynamic>> verifyChatRoom(
    String restaurantId,
    String verificationCode,
  ) async {
    final response = await DioClient.dio.get(
      '/chat-rooms/verify',
      queryParameters: {
        'restaurantId': restaurantId,
        'verificationCode': verificationCode,
      },
    );
    // 确保返回的数据是 Map<String, dynamic> 类型
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    } else if (response.data == null) {
      return {};
    } else {
      throw Exception('Invalid response format: ${response.data}');
    }
  }

  /// 获取餐厅聊天室信息
  static Future<Map<String, dynamic>> getRestaurantChatRoom(
    String restaurantId,
  ) async {
    final response = await DioClient.dio.get(
      '/chat-rooms/restaurant/$restaurantId',
    );
    return response.data;
  }

  /// 获取聊天室消息列表
  static Future<List<ChatMessage>> getRoomMessages(
    String roomId, {
    int page = 0,
    int size = 50,
    String? currentUserId,
  }) async {
    final response = await DioClient.dio.get(
      '/chat-rooms/$roomId/messages',
      queryParameters: {'page': page.toString(), 'size': size.toString()},
    );

    final dynamic payload = response.data['data'] ?? response.data;
    List<ChatMessage> messages = [];

    if (payload is Map<String, dynamic>) {
      final content = payload['records'] as List<dynamic>? ?? [];
      messages = content
          .map(
            (e) => ChatMessage.fromJson(
              e as Map<String, dynamic>,
              currentUserId: currentUserId,
            ),
          )
          .toList();
    }

    return messages;
  }

  /// 发送聊天室消息（HTTP方式，主要用于备份或WebSocket不可用时）
  static Future<ChatMessage> sendRoomMessage(
    String roomId,
    String content,
  ) async {
    final response = await DioClient.dio.post(
      '/chat-rooms/$roomId/messages',
      data: {'content': content},
    );
    final dynamic payload = response.data['data'] ?? response.data;
    if (payload is Map<String, dynamic>) {
      return ChatMessage.fromJson(payload);
    }
    throw Exception('Message sending failed');
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    await DioClient.dio.post('/chat-rooms/$roomId/leave');
  }

  /// 获取聊天室信息
  static Future<Map<String, dynamic>> getChatRoomInfo(String roomId) async {
    final response = await DioClient.dio.get('/chat-rooms/$roomId');
    return response.data;
  }

  /// 获取聊天室成员列表
  static Future<List<Map<String, dynamic>>> getChatRoomMembers(
    String roomId,
  ) async {
    final response = await DioClient.dio.get('/chat-rooms/$roomId/members');
    final dynamic payload = response.data['data'] ?? response.data;

    List<Map<String, dynamic>> members = [];
    if (payload is List) {
      members = payload.map((e) => e as Map<String, dynamic>).toList();
    }

    return members;
  }
}
