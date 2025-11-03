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
    debugPrint('WebSocket已断开连接');
  }

  /// 处理接收到的消息
  static void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message);
      
      if (data is Map<String, dynamic>) {
        // 处理聊天室消息 - 根据API文档，消息可能直接包含在body中
        if (data.containsKey('destination') && data['destination'].toString().contains('/topic/chat-room/')) {
          final messageBody = data['body'];
          if (messageBody is String) {
            final messageData = jsonDecode(messageBody);
            final chatMessage = ChatMessage.fromJson(messageData);
            _messageStreamController.add(chatMessage);
          } else if (messageBody is Map<String, dynamic>) {
            final chatMessage = ChatMessage.fromJson(messageBody);
            _messageStreamController.add(chatMessage);
          }
        }
        // 处理个人通知
        else if (data.containsKey('destination') && data['destination'].toString().contains('/queue/notifications')) {
          final notificationBody = data['body'];
          if (notificationBody is String) {
            final notificationData = jsonDecode(notificationBody);
            _notificationStreamController.add(notificationData);
          } else if (notificationBody is Map<String, dynamic>) {
            _notificationStreamController.add(notificationBody);
          }
        }
        // 处理系统消息
        else if (data.containsKey('type') && data['type'] == 'system') {
          debugPrint('系统消息: ${data['message']}');
        }
        // 处理连接确认消息
        else if (data.containsKey('command') && data['command'] == 'connect') {
          debugPrint('WebSocket连接确认');
        }
      }
    } catch (e) {
      debugPrint('解析WebSocket消息失败: $e');
    }
  }

  /// 发送消息到聊天室
  static Future<void> sendChatMessage(String roomId, String content) async {
    if (_channel == null) {
      throw Exception('WebSocket not connected');
    }

    // 根据API文档，使用正确的消息格式
    final message = {
      'destination': '/app/chat-room.sendMessage',
      'body': jsonEncode({
        'roomId': int.tryParse(roomId) ?? 0,
        'content': content,
      }),
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 加入聊天室
  static Future<void> joinRoom(String roomId) async {
    if (_channel == null) {
      throw Exception('WebSocket not connected');
    }

    _currentRoomId = roomId;

    // 根据API文档，使用正确的消息格式
    final message = {
      'destination': '/app/chat-room.join',
      'body': jsonEncode({
        'roomId': int.tryParse(roomId) ?? 0,
      }),
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    if (_channel == null) {
      throw Exception('WebSocket未连接');
    }

    // 根据API文档，使用正确的消息格式
    final message = {
      'destination': '/app/chat-room.leave',
      'body': jsonEncode({
        'roomId': int.tryParse(roomId) ?? 0,
      }),
    };

    _channel!.sink.add(jsonEncode(message));
    
    if (_currentRoomId == roomId) {
      _currentRoomId = null;
    }
  }

  /// 订阅聊天室消息
  static void subscribeToRoom(String roomId) {
    if (_channel == null) return;

    // 根据API文档，使用正确的订阅格式
    final message = {
      'destination': '/topic/chat-room/$roomId',
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 取消订阅聊天室消息
  static void unsubscribeFromRoom(String roomId) {
    if (_channel == null) return;

    final message = {
      'destination': '/unsubscribe',
      'body': jsonEncode({
        'destination': '/topic/chat-room/$roomId',
      }),
    };

    _channel!.sink.add(jsonEncode(message));
  }

  /// 订阅个人通知
  static Future<void> subscribeToNotifications(String userId) async {
    if (_channel == null) {
      throw Exception('WebSocket未连接');
    }

    _currentUserId = userId;

    // 根据API文档，使用正确的订阅格式
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
      'body': jsonEncode({
        'destination': '/user/$_currentUserId/queue/notifications',
      }),
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