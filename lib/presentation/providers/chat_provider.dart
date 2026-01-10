import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../data/models/chat_message_model.dart';
import '../../core/services/chat_service.dart';
import '../../core/services/websocket_service.dart';
import '../../core/services/auth_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;
  String? _currentRoomId; // 当前聊天室ID
  StreamSubscription<ChatMessage>? _messageSubscription;
  StreamSubscription<Map<String, dynamic>>? _notificationSubscription;

  // 新消息回调函数
  Function()? _newMessageCallback;
  String? _currentUserId; // 当前用户ID

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get currentRoomId => _currentRoomId;
  bool get isConnected => WebSocketService.isConnected;

  /// 初始化WebSocket连接
  Future<void> initialize(String tempToken, {String? userId}) async {
    try {
      // 保存当前用户ID
      _currentUserId = userId;

      // 使用原生WebSocket二进制端点，并传递用户ID
      final connected = await WebSocketService.connect(
        tempToken: tempToken,
        userId: userId,
      );

      if (connected) {
        // 监听消息流
        _messageSubscription = WebSocketService.messageStream.listen((message) {
          _handleIncomingMessage(message);
        });

        // 监听通知流
        _notificationSubscription = WebSocketService.notificationStream.listen((
          notification,
        ) {
          // 处理通知，可以在这里添加通知处理逻辑
          debugPrint('收到通知: $notification');
        });

        notifyListeners();
      } else {
        _error = t.chat.stompConnectFail(error: '连接失败，请检查网络或重新验证');
        notifyListeners();
      }
    } catch (e) {
      _error = t.chat.stompConnectFail(error: e.toString());
      notifyListeners();
    }
  }

  /// 处理接收到的消息
  void _handleIncomingMessage(ChatMessage message) {
    // 只添加当前聊天室的消息，且避免重复添加
    if (message.roomId == _currentRoomId &&
        !_messages.any((existing) => existing.id == message.id)) {
      _messages.add(message);

      // 检查是否为新消息（不是自己发送的消息）
      final isNotOwnMessage = message.senderId != _currentUserId;

      notifyListeners();

      // 如果不是自己发送的消息，触发新消息提示
      if (isNotOwnMessage) {
        // 调用新消息回调函数
        _newMessageCallback?.call();
      }
    }
  }

  /// 断开WebSocket连接
  Future<void> disconnect() async {
    debugPrint('ChatProvider: 断开WebSocket连接');

    // 先离开当前聊天室
    if (_currentRoomId != null) {
      try {
        WebSocketService.leaveRoom(_currentRoomId!);
      } catch (e) {
        debugPrint('离开聊天室失败: $e');
      }
    }

    // 取消订阅
    await _messageSubscription?.cancel();
    await _notificationSubscription?.cancel();

    // 断开WebSocket连接
    WebSocketService.disconnect();

    // 清理所有状态
    _currentUserId = null;
    _currentRoomId = null;
    _messages.clear();
    _error = null;

    debugPrint('ChatProvider: WebSocket连接已断开，状态已清理');
    notifyListeners();
  }

  /// 验证并加入餐厅聊天室
  Future<void> verifyAndJoinChatRoom(
    String restaurantId,
    String verificationCode,
  ) async {
    _setLoading(true);
    _error = null;

    try {
      // 首先通过HTTP API验证聊天室并获取临时token
      final result = await ChatService.verifyChatRoom(
        restaurantId,
        verificationCode,
      );

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

        // 等待WebSocket连接完成
        await _waitForConnection();

        if (!isConnected) {
          _error = t.chat.websocketTimeout;
          notifyListeners();
          return;
        }

        // 额外等待一段时间，确保连接完全建立
        await Future.delayed(const Duration(milliseconds: 300));

        // 再次检查连接状态
        if (!isConnected) {
          _error = t.chat.stompNotConnected;
          notifyListeners();
          return;
        }

        // 获取历史消息
        await fetchMessages(_currentRoomId!, currentUserId: userIdStr);

        // 然后通过WebSocket加入聊天室
        await joinRoom(_currentRoomId!);
      } else {
        _error = t.chat.verifyFailNoRoomOrToken;
      }

      notifyListeners();
    } catch (e) {
      _error = t.chat.verifyRoomFail(error: e.toString());
      debugPrint('验证聊天室失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// 以观察者模式加入餐厅聊天室（只读模式）
  Future<void> joinAsObserver(String restaurantId) async {
    _setLoading(true);
    _error = null;

    try {
      // 通过HTTP API以观察者模式加入聊天室并获取临时token
      final result = await ChatService.joinAsObserver(restaurantId);

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

        // 等待WebSocket连接完成
        await _waitForConnection();

        if (!isConnected) {
          _error = t.chat.websocketTimeout;
          notifyListeners();
          return;
        }

        // 额外等待一段时间，确保连接完全建立
        await Future.delayed(const Duration(milliseconds: 300));

        // 再次检查连接状态
        if (!isConnected) {
          _error = t.chat.stompNotConnected;
          notifyListeners();
          return;
        }

        // 获取历史消息
        await fetchMessages(_currentRoomId!, currentUserId: userIdStr);

        // 然后通过WebSocket加入聊天室
        await joinRoom(_currentRoomId!);
      } else {
        _error = t.chat.verifyFailNoRoomOrToken;
      }

      notifyListeners();
    } catch (e) {
      _error = t.chat.verifyRoomFail(error: e.toString());
      debugPrint('以观察者模式加入聊天室失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// 加入聊天室（仅WebSocket操作）
  Future<void> joinRoom(String roomId) async {
    try {
      WebSocketService.joinRoom(roomId);
    } catch (e) {
      _error = t.chat.joinRoomFail(error: e.toString());
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
      final messagesData = await ChatService.getRoomMessages(
        roomId,
        currentUserId: currentUserId,
      );

      // 确保消息按时间排序（最新的在最后）
      _messages = messagesData
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      _currentRoomId = roomId;
      debugPrint('成功加载 ${_messages.length} 条消息');
      notifyListeners();
    } catch (e) {
      _error = t.chat.loadMessageFail(error: e.toString());
      _messages = [];
      debugPrint('获取消息失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// 发送聊天室消息（使用WebSocket）
  Future<void> sendMessage(String roomId, String content) async {
    if (!isConnected) {
      _error = t.chat.stompConnectionError(error: "connect is null");
      notifyListeners();
      return;
    }

    _setLoading(true);
    _error = null;

    try {
      // 使用原生WebSocket发送消息
      WebSocketService.sendMessage(roomId, content);
      // 不需要手动添加消息，因为WebSocket会推送回来
    } catch (e) {
      _error = t.chat.sendMessageFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// 离开聊天室
  Future<void> leaveRoom(String roomId) async {
    _setLoading(true);
    _error = null;

    try {
      // 使用原生WebSocket离开聊天室
      WebSocketService.leaveRoom(roomId);
      _currentRoomId = null;
      _messages.clear();
      notifyListeners();
    } catch (e) {
      _error = t.chat.leaveRoomFail(error: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// 订阅用户通知
  Future<void> subscribeToNotifications(String userId) async {
    try {
      WebSocketService.subscribeToNotifications(userId);
    } catch (e) {
      _error = t.chat.subscribeNotificationFail(error: e.toString());
      notifyListeners();
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  /// 设置新消息回调函数
  void setNewMessageCallback(Function() callback) {
    _newMessageCallback = callback;
  }

  /// 等待WebSocket连接完成
  Future<void> _waitForConnection() async {
    int retryCount = 0;
    while (!isConnected && retryCount < 20) {
      await Future.delayed(const Duration(milliseconds: 200));
      retryCount++;
      debugPrint('等待WebSocket连接... ($retryCount/20)');
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _notificationSubscription?.cancel();
    WebSocketService.disconnect();
    _newMessageCallback = null;
    _currentUserId = null;
    super.dispose();
  }
}
