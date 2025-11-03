import '../services/api_service.dart';
import '../../data/models/chat_message_model.dart';

class ChatService {
  static final ApiService _api = ApiService();

  /// 验证聊天室验证码并获取临时令牌
  /// 返回包含聊天室信息和临时token的数据
  static Future<Map<String, dynamic>> verifyChatRoom(String restaurantId, String verificationCode) async {
    final res = await _api.get('/chat-rooms/verify', queryParams: {
      'restaurantId': restaurantId,
      'verificationCode': verificationCode,
    });
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      return payload;
    }
    throw Exception('Chat room verification failed');
  }


  /// 获取餐厅聊天室信息
  static Future<Map<String, dynamic>> getRestaurantChatRoom(String restaurantId) async {
    final res = await _api.get('/chat-rooms/restaurant/$restaurantId');
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      return payload;
    }
    throw Exception('Failed to retrieve chat room information');
  }

  /// 获取聊天室消息列表
  static Future<List<ChatMessage>> getRoomMessages(String roomId, {int page = 0, int size = 50, String? currentUserId}) async {
    final res = await _api.get('/chat-rooms/$roomId/messages', queryParams: {
      'page': page.toString(),
      'size': size.toString(),
    });
    final dynamic payload = res['data'] ?? res;
    
    if (payload is Map<String, dynamic>) {
      final content = payload['records'] as List<dynamic>? ?? [];
      return content.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>, currentUserId: currentUserId)).toList();
    }
    
    return <ChatMessage>[];
  }

  /// 发送聊天室消息（HTTP方式，主要用于备份或WebSocket不可用时）
  static Future<ChatMessage> sendRoomMessage(String roomId, String content) async {
    final res = await _api.post('/chat-rooms/$roomId/messages', body: {
      'content': content,
    });
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return ChatMessage.fromJson(payload);
    throw Exception('Message sending failed');
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    await _api.post('/chat-rooms/$roomId/leave');
  }

  /// 获取聊天室信息
  static Future<Map<String, dynamic>> getChatRoomInfo(String roomId) async {
    final res = await _api.get('/chat-rooms/$roomId');
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      return payload;
    }
    throw Exception('Failed to retrieve chat room information');
  }

  /// 获取聊天室成员列表
  static Future<List<Map<String, dynamic>>> getChatRoomMembers(String roomId) async {
    final res = await _api.get('/chat-rooms/$roomId/members');
    final dynamic payload = res['data'] ?? res;
    
    if (payload is List) {
      return payload.map((e) => e as Map<String, dynamic>).toList();
    }
    
    return <Map<String, dynamic>>[];
  }
}
