import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:fixnum/fixnum.dart';
import '../constants/app_constants.dart';
import '../../data/models/chat_message_model.dart';
import '../../protos/chat_proto.dart';

/// WebSocket服务类，使用Protobuf进行通信
class WebSocketService {
  static WebSocketChannel? _channel;
  static bool _isConnected = false;
  static final StreamController<ChatMessage> _messageStreamController =
      StreamController<ChatMessage>.broadcast();
  static final StreamController<Map<String, dynamic>>
  _notificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  static String? _currentRoomId;
  static String? _currentUserId;
  static String? _lastTempToken;
  static int _retryCount = 0;
  static const int _maxRetries = 3;
  static Timer? _retryTimer;

  /// 获取消息流
  static Stream<ChatMessage> get messageStream =>
      _messageStreamController.stream;

  /// 获取通知流
  static Stream<Map<String, dynamic>> get notificationStream =>
      _notificationStreamController.stream;

  /// 连接WebSocket
  static Future<bool> connect({
    String? tempToken,
    String? userId,
    String? roomId,
  }) async {
    _lastTempToken = tempToken;
    _retryCount = 0;
    // 保存房间ID，用于观察者模式连接
    if (roomId != null) {
      _currentRoomId = roomId;
      debugPrint('保存房间ID: $_currentRoomId');
    }
    return _connectWithRetry(tempToken, userId, roomId);
  }

  /// 带有重试机制的连接方法
  static Future<bool> _connectWithRetry(
    String? tempToken,
    String? userId,
    String? roomId,
  ) async {
    try {
      // 保存用户ID
      _currentUserId = userId;
      debugPrint('设置当前用户ID: $_currentUserId');

      // 确保房间ID正确保存
      if (roomId != null) {
        _currentRoomId = roomId;
        debugPrint('在_retryConnect中保存房间ID: $_currentRoomId');
      }


      // 确保有房间ID
      String? effectiveRoomId = roomId ?? _currentRoomId;
      if (effectiveRoomId == null) {
        debugPrint('错误：没有提供房间ID，无法构建正确的WebSocket URL');
        return false;
      }

      // 构建WebSocket URL，roomId放在路径中
      String wsUrl =
          '${AppConstants.wsBaseUrl}/api/v1/ws/chat-bin/$effectiveRoomId';
      debugPrint('构建WebSocket URL路径: $wsUrl');

      // 构建查询参数
      final queryParams = <String, String>{};

      // 添加token参数（如果有）
      if (tempToken != null && tempToken.isNotEmpty) {
        queryParams['token'] = tempToken;
        debugPrint('添加token到查询参数');
      } else {
        // 空token表示以观察者模式连接
        debugPrint('使用空token连接，将以观察者模式进入聊天室');
      }

      // 添加查询参数到URL
      if (queryParams.isNotEmpty) {
        final params = queryParams.entries
            .map((e) => '${e.key}=${e.value}')
            .join('&');
        wsUrl += '?$params';
        debugPrint('添加查询参数到URL: $params');
      }


      // 先断开现有连接（如果有）
      if (_channel != null) {
        _channel?.sink.close();
        _channel = null;
        _isConnected = false;
      }

      // 创建连接
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      // 等待连接建立
      await Future.delayed(Duration(milliseconds: 100));

      // 立即将连接状态设为true，因为WebSocketChannel.connect会立即返回
      _isConnected = true;

      _channel!.stream.listen(
        _handleProtobufMessage,
        onError: (error) {
          debugPrint('WebSocket错误: $error');
          _handleConnectionError(tempToken, userId);
        },
        onDone: () {
          debugPrint('WebSocket连接已关闭');
          _handleConnectionClosed(tempToken, userId);
        },
      );

      debugPrint('WebSocket已连接 (使用原生二进制端点)');
      return true;
    } catch (e) {
      debugPrint('WebSocket连接失败: $e');
      return _handleConnectionError(tempToken, userId);
    }
  }

  /// 处理连接错误
  static bool _handleConnectionError(String? tempToken, String? userId) {
    _isConnected = false;
    _channel = null;

    // 重试连接，传递当前房间ID
    return _retryConnection(tempToken, userId);
  }

  /// 处理连接关闭
  static void _handleConnectionClosed(String? tempToken, String? userId) {
    _isConnected = false;
    _channel = null;
    // 不要清除currentUserId和currentRoomId，以便重试时使用

    // 重试连接，传递当前房间ID
    _retryConnection(tempToken, userId);
  }

  /// 重试连接
  static bool _retryConnection(String? tempToken, String? userId) {
    _retryCount++;
    if (_retryCount <= _maxRetries) {
      debugPrint('WebSocket连接失败，尝试重试 $_retryCount/$_maxRetries');
      debugPrint('重试连接时的房间ID: $_currentRoomId');

      // 延迟后重试连接，传递当前房间ID
      _retryTimer = Timer(Duration(seconds: _retryCount), () {
        _connectWithRetry(tempToken, userId, _currentRoomId);
      });

      return true; // 表示会重试连接
    } else {
      debugPrint('WebSocket连接失败，已达到最大重试次数');
      return false; // 表示重试失败
    }
  }

  /// 断开WebSocket连接
  static void disconnect() {
    if (_currentRoomId != null) {
      leaveRoom(_currentRoomId!);
    }

    // 取消重试定时器
    _retryTimer?.cancel();
    _retryTimer = null;
    _retryCount = 0;

    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _currentRoomId = null;
    _currentUserId = null;
    _lastTempToken = null;
    debugPrint('WebSocket已断开连接');
  }

  /// 处理接收到的protobuf消息
  static void _handleProtobufMessage(dynamic message) {
    debugPrint('收到WebSocket消息，类型: ${message.runtimeType}');

    if (message is Uint8List) {
      // 处理二进制protobuf消息
      try {
        final chatResponse = ChatResponseProto.fromBuffer(message);
        if (chatResponse.success) {
          if (chatResponse.payload is ChatMessageProto) {
            final messageProto = chatResponse.payload as ChatMessageProto;
            final chatMessage = _convertProtoToModel(messageProto);
            _messageStreamController.add(chatMessage);
          } else if (chatResponse.payload is JoinRoomResponseProto) {
            final joinResponse = chatResponse.payload as JoinRoomResponseProto;
            debugPrint('加入房间响应: ${joinResponse.message}');
          } else if (chatResponse.payload is LeaveRoomResponseProto) {
            final leaveResponse =
                chatResponse.payload as LeaveRoomResponseProto;
            debugPrint('离开房间响应: ${leaveResponse.message}');
          }
        } else {
          debugPrint('protobuf操作失败: ${chatResponse.errorMessage}');
        }
      } catch (e) {
        debugPrint('解析protobuf消息失败: $e');
      }
    } else if (message is String) {
      debugPrint('收到文本消息: $message');
      // 如果是文本消息，尝试解析为JSON
      try {
        final jsonData = json.decode(message);
        debugPrint('JSON消息内容: $jsonData');
      } catch (e) {
        debugPrint('解析文本消息失败: $e');
      }
    } else {
      debugPrint('收到未知类型消息: $message');
    }
  }

  /// 发送消息到聊天室
  static Future<void> sendChatMessage(String roomId, String content) async {
    if (_channel == null) {
      throw Exception('WebSocket not connected');
    }

    // 使用protobuf格式
    final request = SendMessageRequestProto(
      roomId: Int64.parseInt(roomId),
      content: content,
    );

    // 包装为WebSocket消息
    final webSocketMessage = WebSocketMessageProto(
      type: 'SEND_MESSAGE',
      payload: request.toBuffer(),
    );

    // 发送二进制数据
    _channel!.sink.add(webSocketMessage.toBuffer());
    debugPrint('发送protobuf消息到聊天室 $roomId: $content');
  }

  /// 发送消息到聊天室（sendMessage的别名）
  static Future<void> sendMessage(String roomId, String content) async {
    return sendChatMessage(roomId, content);
  }

  /// 加入聊天室
  static Future<void> joinRoom(String roomId) async {
    if (_channel == null) {
      debugPrint('WebSocket未连接，无法加入聊天室: $roomId');
      return;
    }

    _currentRoomId = roomId;

    // 使用protobuf格式
    final request = JoinRoomRequestProto(roomId: Int64.parseInt(roomId));

    final webSocketMessage = WebSocketMessageProto(
      type: 'JOIN_ROOM',
      payload: request.toBuffer(),
    );

    _channel!.sink.add(webSocketMessage.toBuffer());
    debugPrint('加入聊天室: $roomId');
  }

  /// 离开聊天室
  static Future<void> leaveRoom(String roomId) async {
    if (_channel == null) {
      debugPrint('WebSocket未连接，无法离开聊天室: $roomId');
      return;
    }

    // 使用protobuf格式
    final request = LeaveRoomRequestProto(roomId: Int64.parseInt(roomId));

    final webSocketMessage = WebSocketMessageProto(
      type: 'LEAVE_ROOM',
      payload: request.toBuffer(),
    );

    _channel!.sink.add(webSocketMessage.toBuffer());

    if (_currentRoomId == roomId) {
      _currentRoomId = null;
    }
    debugPrint('离开聊天室: $roomId');
  }

  /// 订阅聊天室消息
  static void subscribeToRoom(String roomId) {
    if (_channel == null) return;

    // 使用protobuf格式
    final webSocketMessage = WebSocketMessageProto(
      type: 'SUBSCRIBE',
      payload: Uint8List.fromList(utf8.encode('/topic/chat-room/$roomId')),
    );

    _channel!.sink.add(webSocketMessage.toBuffer());
    debugPrint('订阅聊天室消息: $roomId');
  }

  /// 取消订阅聊天室消息
  static void unsubscribeFromRoom(String roomId) {
    if (_channel == null) return;

    final webSocketMessage = WebSocketMessageProto(
      type: 'UNSUBSCRIBE',
      payload: Uint8List.fromList(utf8.encode('/topic/chat-room/$roomId')),
    );

    _channel!.sink.add(webSocketMessage.toBuffer());
    debugPrint('取消订阅聊天室消息: $roomId');
  }

  /// 订阅个人通知
  static Future<void> subscribeToNotifications(String userId) async {
    if (_channel == null) {
      debugPrint('WebSocket未连接，无法订阅个人通知');
      return;
    }

    _currentUserId = userId;

    final webSocketMessage = WebSocketMessageProto(
      type: 'SUBSCRIBE',
      payload: Uint8List.fromList(
        utf8.encode('/user/$userId/queue/notifications'),
      ),
    );

    _channel!.sink.add(webSocketMessage.toBuffer());
    debugPrint('订阅个人通知: $userId');
  }

  /// 取消订阅个人通知
  static void unsubscribeFromNotifications() {
    if (_channel == null || _currentUserId == null) return;

    final webSocketMessage = WebSocketMessageProto(
      type: 'UNSUBSCRIBE',
      payload: Uint8List.fromList(
        utf8.encode('/user/$_currentUserId/queue/notifications'),
      ),
    );

    _channel!.sink.add(webSocketMessage.toBuffer());
    _currentUserId = null;
    debugPrint('取消订阅个人通知');
  }

  /// 将protobuf消息转换为模型
  static ChatMessage _convertProtoToModel(ChatMessageProto proto) {
    // 获取当前用户ID进行比较
    final currentUserId = _currentUserId;
    final senderId = proto.senderId.toString();
    final isSentByUser = currentUserId != null && senderId == currentUserId;

    debugPrint(
      '消息转换: senderId=$senderId, currentUserId=$currentUserId, isSentByUser=$isSentByUser',
    );

    return ChatMessage(
      id: proto.id.toString(),
      roomId: proto.roomId.toString(),
      senderId: senderId,
      content: proto.content,
      messageType: _messageTypeToString(proto.messageType),
      senderName: proto.senderName,
      senderAvatar: proto.senderAvatar,
      createdAt: DateTime.parse(proto.timestamp),
      updatedAt: DateTime.parse(proto.timestamp),
      isSentByUser: isSentByUser,
    );
  }

  /// 将MessageType枚举转换为字符串
  static String _messageTypeToString(MessageType type) {
    switch (type) {
      case MessageType.TEXT:
        return 'TEXT';
      case MessageType.IMAGE:
        return 'IMAGE';
      case MessageType.SYSTEM:
        return 'SYSTEM';
      default:
        return 'TEXT';
    }
  }

  /// 检查连接状态
  /// 注意：对于观察者模式，我们允许连接状态显示为已连接，即使连接可能已经关闭
  /// 因为服务器可能会自动处理观察者模式的连接，即使WebSocket连接显示关闭，仍然可以收到消息
  static bool get isConnected {
    // 对于观察者模式（空token），我们假设连接是活跃的，除非明确知道它已关闭
    // 这是因为服务器可能会自动处理观察者模式的连接
    return _channel != null;
  }

  /// 获取当前聊天室ID
  static String? get currentRoomId => _currentRoomId;

  /// 获取当前用户ID
  static String? get currentUserId => _currentUserId;
}
