import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tabletalk/generated/translations.g.dart';
import '../constants/app_constants.dart';
import '../../data/models/chat_message_model.dart';

/// STOMP WebSocket服务类，处理实时聊天功能
class StompWebSocketService {
  static StompClient? _stompClient;
  static String? _currentRoomId;
  static String? _currentUserId;
  
  // 消流控制器
  static final StreamController<ChatMessage> _messageStreamController = 
      StreamController<ChatMessage>.broadcast();
  static final StreamController<Map<String, dynamic>> _notificationStreamController = 
      StreamController<Map<String, dynamic>>.broadcast();
  static final StreamController<Map<String, dynamic>> _connectionStateController = 
      StreamController<Map<String, dynamic>>.broadcast();

  /// 获取消息流
  static Stream<ChatMessage> get messageStream => _messageStreamController.stream;

  /// 获取通知流
  static Stream<Map<String, dynamic>> get notificationStream => _notificationStreamController.stream;

  /// 获取连接状态流
  static Stream<Map<String, dynamic>> get connectionStateStream => _connectionStateController.stream;

  /// 连接STOMP WebSocket
  static Future<void> connect(String tempToken, {String? userId}) async {
    try {
      _currentUserId = userId;
      
      debugPrint('尝试连接STOMP WebSocket: ${AppConstants.wsBaseUrl}/api/v1/ws/chat');
      
      _stompClient = StompClient(
        config: StompConfig(
          url: '${AppConstants.wsBaseUrl}/api/v1/ws/chat',
          onConnect: _onConnect,
          onDisconnect: _onDisconnect,
          onWebSocketError: _onWebSocketError,
          stompConnectHeaders: {
            'Authorization': 'Bearer $tempToken',
            'accept-version': '1.1,1.0',
            'heart-beat': '10000,10000'
          },
          webSocketConnectHeaders: {
            'Authorization': 'Bearer $tempToken',
          },
        ),
      );
      
      _stompClient!.activate();
      
      debugPrint('STOMP WebSocket连接已启动');
    } catch (e) {
      debugPrint('STOMP WebSocket连接失败: $e');

      _connectionStateController.add({
        'connected': false,
        'error': t.chat.stompConnectFailed( error: ''),
      });
      rethrow;
    }
  }

  /// 连接成功回调
  static void _onConnect(StompFrame frame) {
    debugPrint('STOMP WebSocket连接成功');
    _connectionStateController.add({
      'connected': true,
      'message': t.chat.stompConnected,
    });
    
    // 如果已加入聊天室，重新订阅
    if (_currentRoomId != null) {
      subscribeToRoom(_currentRoomId!);
    }
    
    // 订阅个人通知
    if (_currentUserId != null) {
      // 延迟订阅，确保连接完全建立
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_stompClient?.connected == true) {
          subscribeToNotifications(_currentUserId!);
        }
      });
    }
  }

  /// 连接断开回调
  static void _onDisconnect(StompFrame frame) {
    debugPrint('STOMP WebSocket连接已断开');
    _connectionStateController.add({
      'connected': false,
      'message': t.chat.stompDisconnected,
    });
  }


  /// WebSocket错误回调
  static void _onWebSocketError(dynamic error) {
    debugPrint('WebSocket错误: $error');
    _connectionStateController.add({
      'connected': false,
      'error': t.chat.stompConnectFailed(error: error.toString()),
    });

  }

  /// 断开STOMP连接
  static void disconnect() {
    if (_currentRoomId != null) {
      leaveRoom(_currentRoomId!);
    }
    
    _stompClient?.deactivate();
    _stompClient = null;
    _currentRoomId = null;
    _currentUserId = null;
    
    debugPrint('STOMP WebSocket已断开连接');
  }

  /// 发送消息到聊天室
  static void sendMessage(String roomId, String content) {
    if (_stompClient?.connected == true) {
      final message = {
        'roomId': int.tryParse(roomId) ?? 0,
        'content': content,
      };
      
      _stompClient!.send(
        destination: '/app/chat-room.sendMessage',
        body: json.encode(message),
      );
      
      debugPrint('发送消息到聊天室 $roomId: $content');
    } else {
      debugPrint('STOMP未连接，无法发送消息');
      throw Exception(t.chat.stompNotConnected);
    }
  }

  /// 加入聊天室
  static void joinRoom(String roomId) {
    if (_stompClient?.connected == true) {
      _currentRoomId = roomId;
      
      final message = {
        'roomId': int.tryParse(roomId) ?? 0,
      };
      
      _stompClient!.send(
        destination: '/app/chat-room.join',
        body: json.encode(message),
      );
      
      debugPrint('加入聊天室: $roomId');
    } else {
      debugPrint('STOMP未连接，无法加入聊天室');
      throw Exception(t.chat.stompNotConnected);
    }
  }

  /// 离开聊天室
  static void leaveRoom(String roomId) {
    if (_stompClient?.connected == true) {
      final message = {
        'roomId': int.tryParse(roomId) ?? 0,
      };
      
      _stompClient!.send(
        destination: '/app/chat-room.leave',
        body: json.encode(message),
      );
      
      debugPrint('离开聊天室: $roomId');
    }
    
    if (_currentRoomId == roomId) {
      _currentRoomId = null;
    }
  }

  /// 订阅聊天室消息
  static void subscribeToRoom(String roomId) {
    if (_stompClient?.connected == true) {
      _currentRoomId = roomId;
      
      _stompClient!.subscribe(
        destination: '/topic/chat-room/$roomId',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            try {
              final data = json.decode(frame.body!);
              debugPrint('收到聊天室消息: $data');
              
              // 根据API文档，消息可能包装在data字段中
              Map<String, dynamic> messageData;
              if (data is Map<String, dynamic> && data.containsKey('data')) {
                messageData = data['data'];
              } else {
                messageData = data;
              }
              
              final chatMessage = ChatMessage.fromJson(messageData, currentUserId: _currentUserId);
              _messageStreamController.add(chatMessage);
            } catch (e) {
              debugPrint('解析聊天室消息失败: $e');
            }
          }
        },
      );
      
      debugPrint('已订阅聊天室 $roomId 的消息');
    } else {
      debugPrint('STOMP未连接，无法订阅聊天室消息');
    }
  }

  /// 取消订阅聊天室消息
  static void unsubscribeFromRoom(String roomId) {
    if (_stompClient?.connected == true) {
      // 注意：stomp_dart_client可能不支持直接取消订阅
      // 这里我们只清除本地状态，实际取消订阅会在断开连接时自动处理
      debugPrint('取消订阅聊天室 $roomId 的消息');
    }
    
    if (_currentRoomId == roomId) {
      _currentRoomId = null;
    }
  }

  /// 订阅个人通知
  static void subscribeToNotifications(String userId) {
    if (_stompClient?.connected == true) {
      _currentUserId = userId;
      
      _stompClient!.subscribe(
        destination: '/user/queue/notifications',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            try {
              final data = json.decode(frame.body!);
              debugPrint('收到个人通知: $data');
              
              // 根据API文档，通知可能包装在data字段中
              Map<String, dynamic> notificationData;
              if (data is Map<String, dynamic> && data.containsKey('data')) {
                notificationData = data['data'];
              } else {
                notificationData = data;
              }
              
              _notificationStreamController.add(notificationData);
            } catch (e) {
              debugPrint('解析个人通知失败: $e');
              _connectionStateController.add({
                'connected': false,
                'error': t.chat.msgParseFailed,
              });
            }
          }
        },
      );
      
      debugPrint('已订阅个人通知');
    } else {
      debugPrint('STOMP未连接，无法订阅个人通知');
      // 尝试重新连接并订阅
      debugPrint('尝试重新连接并订阅个人通知');
      _retrySubscribeToNotifications(userId);
    }
  }
  
  /// 重试订阅个人通知
  static void _retrySubscribeToNotifications(String userId) {
    int retryCount = 0;
    const maxRetries = 3;
    
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (retryCount >= maxRetries || _stompClient?.connected == true) {
        timer.cancel();
        
        if (_stompClient?.connected == true) {
          subscribeToNotifications(userId);
        } else {
          debugPrint('重试订阅个人通知失败，已达到最大重试次数');
        }
        return;
      }
      
      retryCount++;
      debugPrint('重试订阅个人通知 ($retryCount/$maxRetries)');
    });
  }

  /// 取消订阅个人通知
  static void unsubscribeFromNotifications() {
    if (_stompClient?.connected == true) {
      // 注意：stomp_dart_client可能不支持直接取消订阅
      // 这里我们只清除本地状态，实际取消订阅会在断开连接时自动处理
      debugPrint('取消订阅个人通知');
    }
    
    _currentUserId = null;
  }

  /// 检查连接状态
  static bool get isConnected => _stompClient?.connected == true;

  /// 获取当前聊天室ID
  static String? get currentRoomId => _currentRoomId;

  /// 获取当前用户ID
  static String? get currentUserId => _currentUserId;

  /// 释放资源
  static void dispose() {
    disconnect();
    _messageStreamController.close();
    _notificationStreamController.close();
    _connectionStateController.close();
  }
}