import 'package:flutter/foundation.dart';
import '../../data/models/chat_message_model.dart';
import '../../core/services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatSession> _sessions = [];
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<ChatSession> get sessions => _sessions;
  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSessionsForUser(String userId) async {
    _setLoading(true);
    _error = null;
    try {
      _sessions = await ChatService.sessionsForUser(userId);
    } catch (e) {
      _error = '获取会话失败：${e.toString()}';
      _sessions = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchMessages(String sessionId) async {
    _setLoading(true);
    _error = null;
    try {
      _messages = await ChatService.messages(sessionId);
    } catch (e) {
      _error = '获取消息失败：${e.toString()}';
      _messages = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendMessage(String sessionId, String content) async {
    _setLoading(true);
    _error = null;
    try {
      final msg = await ChatService.sendMessage(sessionId, content);
      _messages.add(msg);
    } catch (e) {
      _error = '发送消息失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
