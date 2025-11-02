import 'dart:async';

import 'package:flutter/foundation.dart';
import '../../data/models/chat_message_model.dart';
import '../../core/services/chat_service.dart';
import '../../core/services/stomp_websocket_service.dart';
import '../../core/services/auth_service.dart';

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

  /// 初始化STOMP WebSocket连接
  Future<void> initialize(String tempToken, {String? userId}) async {
    try {
      // 连接STOMP WebSocket
      StompWebSocketService.connect(tempToken, userId: userId);
      
      // 监听连接状态
      StompWebSocketService.connectionStateStream.listen((state) {
        _isConnected = state['connected'] ?? false;
        if (state['error'] != null) {
          _error = 'STOMP连接错误：${state['error']}';
        }
        notifyListeners();
      });
      
      // 监听消息流
      _messageSubscription = StompWebSocketService.messageStream.listen((message) {
        // 只添加当前聊天室的消息，且避免重复添加
        if (message.roomId == _currentRoomId &&
            !_messages.any((existing) => existing.id == message.id)) {
          _messages.add(message);
          notifyListeners();
        }
      });
      
      // 监听通知流
      _notificationSubscription = StompWebSocketService.notificationStream.listen((notification) {
        // 处理通知，可以在这里添加通知处理逻辑
        debugPrint('收到通知: $notification');
      });
    } catch (e) {
      _error = 'STOMP WebSocket连接失败：${e.toString()}';
      notifyListeners();
    }
  }

  /// 断开STOMP WebSocket连接
  Future<void> disconnect() async {
    await _messageSubscription?.cancel();
    await _notificationSubscription?.cancel();
    StompWebSocketService.disconnect();
    _isConnected = false;
    notifyListeners();
  }

  /// 验证并加入餐厅聊天室
  Future<void> verifyAndJoinChatRoom(String restaurantId, String verificationCode) async {
    _setLoading(true);
    _error = null;
    
    try {
      // 首先通过HTTP API验证聊天室并获取临时token
      final result = await ChatService.verifyChatRoom(restaurantId, verificationCode);
      
      // 从响应中获取聊天室信息和临时token
      final chatRoomData = result['chatRoom'] as Map<String, dynamic>?;
      if (chatRoomData != null) {
        _currentRoomId = chatRoomData['id']?.toString();
      }
      
      final tempToken = result['tempToken']?.toString() ?? '';
      if (tempToken.isNotEmpty && _currentRoomId != null) {
        // 获取用户ID
        final userId = await AuthService.getCurrentUserId();
        final userIdStr = userId?.toString();
        
        // 使用临时token初始化WebSocket连接
        await initialize(tempToken, userId: userIdStr);
        
        // 获取历史消息
        await fetchMessages(_currentRoomId!, currentUserId: userIdStr);
        
        // 然后通过STOMP WebSocket加入聊天室
        StompWebSocketService.joinRoom(_currentRoomId!);
        // 订阅聊天室消息以接收实时更新
        StompWebSocketService.subscribeToRoom(_currentRoomId!);
      } else {
        _error = '验证失败：未获取到聊天室ID或临时令牌';
      }
      
      notifyListeners();
    } catch (e) {
      _error = '验证聊天室失败：${e.toString()}';
      debugPrint('验证聊天室失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// 加入餐厅聊天室（已弃用，使用verifyAndJoinChatRoom代替）
  @Deprecated('使用verifyAndJoinChatRoom代替')
  Future<void> joinRestaurantChat(String restaurantId, String verificationCode) async {
    await verifyAndJoinChatRoom(restaurantId, verificationCode);
  }

  /// 加入聊天室（仅WebSocket操作）
  Future<void> joinRoom(String roomId) async {
    try {
      StompWebSocketService.joinRoom(roomId);
      StompWebSocketService.subscribeToRoom(roomId);
    } catch (e) {
      _error = '加入聊天室失败：${e.toString()}';
      notifyListeners();
    }
  }

  /// 获取聊天室消息
  Future<void> fetchMessages(String roomId, {String? currentUserId}) async {
    _setLoading(true);
    _error = null;

    try {
      // 获取用户ID用于判断消息发送者
      if (currentUserId == null) {
        try {
          final userId = await AuthService.getCurrentUserId();
          currentUserId = userId?.toString();
        } catch (e) {
          debugPrint('获取用户信息失败: $e');
        }
      }
      
      // 获取消息列表并解析
      final messagesData = await ChatService.getRoomMessages(roomId, currentUserId: currentUserId);
      
      // 确保消息按时间排序（最新的在最后）
      _messages = messagesData..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      
      _currentRoomId = roomId;
      debugPrint('成功加载 ${_messages.length} 条消息');
      notifyListeners();
    } catch (e) {
      _error = '获取消息失败：${e.toString()}';
      _messages = [];
      debugPrint('获取消息失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// 发送聊天室消息（使用STOMP WebSocket）
  Future<void> sendMessage(String roomId, String content) async {
    if (!_isConnected) {
      _error = 'STOMP WebSocket未连接，无法发送消息';
      notifyListeners();
      return;
    }
    
    _setLoading(true);
    _error = null;
    
    try {
      // 使用STOMP WebSocket发送消息
      StompWebSocketService.sendMessage(roomId, content);
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
      // 取消订阅聊天室消息
      StompWebSocketService.unsubscribeFromRoom(roomId);
      // 使用STOMP WebSocket离开聊天室
      StompWebSocketService.leaveRoom(roomId);
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
      StompWebSocketService.subscribeToNotifications(userId);
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
    StompWebSocketService.disconnect();
    super.dispose();
  }
}
