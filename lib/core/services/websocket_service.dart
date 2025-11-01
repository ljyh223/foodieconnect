import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/app_constants.dart';
import '../../data/models/chat_message_model.dart';

/// WebSocket服务类，处理实时聊天功能
class WebSocketService {
  static WebSocketChannel? _channel;
  static final StreamController<ChatMessage> _messageStreamController = StreamController<ChatMessage>.broadcast();
  static final StreamController<Map<String, dynamic>> _notificationStreamController = StreamController<Map<String, dynamic>>.broadcast();
  static String? _currentRoomId;
  static String? _currentUserId;

  /// 获取消息流
  static Stream<ChatMessage> get messageStream => _messageStreamController.stream;

  /// 获取通知流
  static Stream<Map<String, dynamic>> get notificationStream => _notificationStreamController.stream;

  /// 连接WebSocket
  static Future<void> connect() async {
    try {
      // 使用AppConstants中的WebSocket URL
      final wsUrl = Uri.parse(AppConstants.wsBaseUrl);
      debugPrint('尝试连接WebSocket: $wsUrl');
      _channel = WebSocketChannel.connect(wsUrl);
      
      _channel!.stream.listen(
        _handleMessage,
        onError: (error) {
          debugPrint('WebSocket错误: $error');
        },
        onDone: () {
          debugPrint('WebSocket连接已关闭');
          _channel = null;
        },
      );
      
      debugPrint('WebSocket已连接');
    } catch (e) {
      debugPrint('WebSocket连接失败: $e');
      // 不重新抛出异常，避免应用崩溃
    }
  }

  /// 断开WebSocket连接
  static void disconnect() {
    if (_currentRoomId != null) {
      leaveRoom(_currentRoomId!);
    }
    
    _channel?.sink.close();
    _channel = null;
    _currentRoomId = null;
    _currentUserId = null;
    print('WebSocket已断开连接');
  }

  /// 处理接收到的消息
  static void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      
      if (data is Map<String, dynamic>) {
        // 处理聊天室消息
        if (data.containsKey('type') && data['type'] == 'chat_message') {
          final chatMessage = ChatMessage.fromJson(data['data']);
          _messageStreamController.add(chatMessage);
        }
        // 处理通知
        else if (data.containsKey('type') && data['type'] == 'notification') {
          _notificationStreamController.add(data['data']);
        }
        // 处理系统消息
        else if (data.containsKey('type') && data['type'] == 'system') {
          print('系统消息: ${data['message']}');
        }
      }
    } catch (e) {
      print('解析WebSocket消息失败: $e');
    }
  }

  /// 发送消息到聊天室
  static Future<void> sendChatMessage(String roomId, String content) async {
    if (_channel == null) {
      throw Exception('WebSocket未连接');
    }

    final message = {
      'destination': '/app/chat-room.sendMessage',
      'data': {
        'roomId': int.tryParse(roomId) ?? 0,
        'content': content,
      },
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 加入聊天室
  static Future<void> joinRoom(String roomId) async {
    if (_channel == null) {
      throw Exception('WebSocket未连接');
    }

    _currentRoomId = roomId;

    final message = {
      'destination': '/app/chat-room.join',
      'data': {
        'roomId': int.tryParse(roomId) ?? 0,
      },
    };

    _channel!.sink.add(jsonEncode(message));
    
    // 订阅聊天室消息
    _subscribeToRoom(roomId);
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    if (_channel == null) {
      throw Exception('WebSocket未连接');
    }

    final message = {
      'destination': '/app/chat-room.leave',
      'data': {
        'roomId': int.tryParse(roomId) ?? 0,
      },
    };

    _channel!.sink.add(jsonEncode(message));
    
    // 取消订阅聊天室消息
    _unsubscribeFromRoom(roomId);
    
    if (_currentRoomId == roomId) {
      _currentRoomId = null;
    }
  }

  /// 订阅聊天室消息
  static void _subscribeToRoom(String roomId) {
    if (_channel == null) return;

    final message = {
      'destination': '/topic/chat-room/$roomId',
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 取消订阅聊天室消息
  static void _unsubscribeFromRoom(String roomId) {
    if (_channel == null) return;

    final message = {
      'destination': '/unsubscribe',
      'data': {
        'topic': '/topic/chat-room/$roomId',
      },
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 订阅个人通知
  static Future<void> subscribeToNotifications(String userId) async {
    if (_channel == null) {
      throw Exception('WebSocket未连接');
    }

    _currentUserId = userId;

    final message = {
      'destination': '/user/$userId/queue/notifications',
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 取消订阅个人通知
  static void unsubscribeFromNotifications() {
    if (_channel == null || _currentUserId == null) return;

    final message = {
      'destination': '/unsubscribe',
      'data': {
        'topic': '/user/$_currentUserId/queue/notifications',
      },
    };

    _channel!.sink.add(jsonEncode(message));
    _currentUserId = null;
  }

  /// 检查连接状态
  static bool get isConnected => _channel != null;

  /// 获取当前聊天室ID
  static String? get currentRoomId => _currentRoomId;

  /// 获取当前用户ID
  static String? get currentUserId => _currentUserId;
}