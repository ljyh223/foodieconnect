import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/chat_message_model.dart';

class ChatService {
  static final ApiService _api = ApiService();

  /// 通过验证码加入餐厅聊天室
  static Future<Map<String, dynamic>> joinRestaurantChat(String restaurantId, String verificationCode) async {
    final res = await _api.post('${AppConstants.chatEndpoint}/rooms/join', body: {
      'restaurantId': restaurantId,
      'verificationCode': verificationCode,
    });
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      return payload;
    }
    throw Exception('加入聊天室失败');
  }

  /// 获取餐厅聊天室信息
  static Future<Map<String, dynamic>> getRestaurantChatRoom(String restaurantId) async {
    final res = await _api.get('${AppConstants.chatEndpoint}/rooms/restaurant/$restaurantId');
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      return payload;
    }
    throw Exception('获取聊天室信息失败');
  }

  /// 获取聊天室消息列表
  static Future<List<ChatMessage>> getRoomMessages(String roomId, {int page = 0, int size = 50}) async {
    final res = await _api.get('${AppConstants.chatEndpoint}/rooms/$roomId/messages', queryParams: {
      'page': page.toString(),
      'size': size.toString(),
    });
    final dynamic payload = res['data'] ?? res;
    
    if (payload is Map<String, dynamic>) {
      final content = payload['content'] as List<dynamic>? ?? [];
      return content.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) {
      return payload.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    return <ChatMessage>[];
  }

  /// 发送聊天室消息
  static Future<ChatMessage> sendRoomMessage(String roomId, String content) async {
    final res = await _api.post('${AppConstants.chatEndpoint}/rooms/$roomId/messages', body: {'content': content});
    final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return ChatMessage.fromJson(payload);
    throw Exception('发送消息失败');
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    await _api.post('${AppConstants.chatEndpoint}/rooms/$roomId/leave');
  }
}
