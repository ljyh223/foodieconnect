import 'dart:async';

import 'package:flutter/foundation.dart';
import '../../data/models/chat_message_model.dart';
import '../../core/services/chat_service.dart';
import '../../core/services/websocket_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;
  String? _currentRoomId; // 当前聊天室ID
  bool _isConnected = false;
  StreamSubscription<ChatMessage>? _messageSubscription;
  StreamSubscription<Map<String, dynamic>>? _notificationSubscription;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentRoomId => _currentRoomId;
  bool get isConnected => _isConnected;

  /// 初始化WebSocket连接
  Future<void> initialize() async {
    try {
      await WebSocketService.connect();
      _isConnected = true;
      notifyListeners();
      
      // 监听消息流
      _messageSubscription = WebSocketService.messageStream.listen((message) {
        _messages.add(message);
        notifyListeners();
        // if (message.roomId == _currentRoomId) {
        //
        // }
      });
      
      // 监听通知流
      _notificationSubscription = WebSocketService.notificationStream.listen((notification) {
        // 处理通知，可以在这里添加通知处理逻辑
        debugPrint('收到通知: $notification');
      });
    } catch (e) {
      _error = 'WebSocket连接失败：${e.toString()}';
      notifyListeners();
    }
  }

  /// 断开WebSocket连接
  Future<void> disconnect() async {
    await _messageSubscription?.cancel();
    await _notificationSubscription?.cancel();
    WebSocketService.disconnect();
    _isConnected = false;
    notifyListeners();
  }

  /// 加入餐厅聊天室
  Future<void> joinRestaurantChat(String restaurantId, String verificationCode) async {
    _setLoading(true);
    _error = null;
    
    try {
      // 首先通过HTTP API加入聊天室
      final result = await ChatService.joinRestaurantChat(restaurantId, verificationCode);
      _currentRoomId = result['roomId']?.toString();
      
      // 然后通过WebSocket加入聊天室
      if (_currentRoomId != null) {
        await WebSocketService.joinRoom(_currentRoomId!);
      }
      
      notifyListeners();
    } catch (e) {
      _error = '加入聊天室失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  /// 获取聊天室消息
  Future<void> fetchMessages(String roomId) async {
    _setLoading(true);
    _error = null;

    try {
      _messages = await ChatService.getRoomMessages(roomId);
      _currentRoomId = roomId;
      notifyListeners();
    } catch (e) {
      _error = '获取消息失败：${e.toString()}';
      _messages = [];
    } finally {
      _setLoading(false);
    }
  }

  /// 发送聊天室消息（使用WebSocket）
  Future<void> sendMessage(String roomId, String content) async {
    if (!_isConnected) {
      _error = 'WebSocket未连接，无法发送消息';
      notifyListeners();
      return;
    }
    
    _setLoading(true);
    _error = null;
    
    try {
      // 使用WebSocket发送消息
      await WebSocketService.sendChatMessage(roomId, content);
      // 不需要手动添加消息，因为WebSocket会推送回来
    } catch (e) {
      _error = '发送消息失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  /// 离开聊天室
  Future<void> leaveRoom(String roomId) async {
    _setLoading(true);
    _error = null;
    
    try {
      // 使用WebSocket离开聊天室
      await WebSocketService.leaveRoom(roomId);
      _currentRoomId = null;
      _messages.clear();
      notifyListeners();
    } catch (e) {
      _error = '离开聊天室失败：${e.toString()}';
    } finally {
      _setLoading(false);
    }
  }

  /// 订阅用户通知
  Future<void> subscribeToNotifications(String userId) async {
    try {
      await WebSocketService.subscribeToNotifications(userId);
    } catch (e) {
      _error = '订阅通知失败：${e.toString()}';
      notifyListeners();
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _notificationSubscription?.cancel();
    WebSocketService.disconnect();
    super.dispose();
  }
}
