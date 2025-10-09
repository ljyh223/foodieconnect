import '../services/api_service.dart';
import '../constants/app_constants.dart';
import '../../data/models/chat_message_model.dart';

class ChatService {
  static final ApiService _api = ApiService();

  static Future<List<ChatSession>> sessionsForUser(String userId) async {
    final res = await _api.get('${AppConstants.chatEndpoint}/sessions/user/$userId');
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list.map((e) => ChatSession.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => ChatSession.fromJson(e as Map<String, dynamic>)).toList();
    return <ChatSession>[];
  }

  static Future<List<ChatSession>> sessionsForStaff(String staffId) async {
    final res = await _api.get('${AppConstants.chatEndpoint}/sessions/staff/$staffId');
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final list = payload['content'] as List<dynamic>? ?? [];
      return list.map((e) => ChatSession.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => ChatSession.fromJson(e as Map<String, dynamic>)).toList();
    return <ChatSession>[];
  }

  static Future<List<ChatMessage>> messages(String sessionId, {int page = 0, int size = 50}) async {
    final res = await _api.get('${AppConstants.chatEndpoint}/sessions/$sessionId/messages', queryParams: {'page': page.toString(), 'size': size.toString()});
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) {
      final content = payload['content'] as List<dynamic>? ?? [];
      return content.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (payload is List) return payload.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)).toList();
    return <ChatMessage>[];
  }

  static Future<ChatMessage> sendMessage(String sessionId, String content) async {
    final res = await _api.post('${AppConstants.chatEndpoint}/sessions/$sessionId/messages', body: {'content': content});
  final dynamic payload = res['data'] ?? res;
    if (payload is Map<String, dynamic>) return ChatMessage.fromJson(payload);
    throw Exception('发送消息失败');
  }
}
