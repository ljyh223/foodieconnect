import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/providers/chat_provider.dart';
import '../core/services/chat_service.dart';
import '../core/services/auth_service.dart';

class ChatScreen extends StatefulWidget {
  final String? staffId;
  final String? restaurantId;
  final String? roomId;

  const ChatScreen({super.key, this.staffId, this.restaurantId, this.roomId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _restaurantId;
  String? _roomName;

  @override
  void initState() {
    super.initState();
    
    // 设置餐厅ID
    _restaurantId = widget.restaurantId;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ChatProvider>(context, listen: false);

      // 优先使用直接传入的roomId
      String? roomIdToUse = widget.roomId;
      
      // 如果没有直接传入roomId，尝试使用provider中的currentRoomId
      if (roomIdToUse == null && provider.currentRoomId != null) {
        roomIdToUse = provider.currentRoomId!;
      }
      
      // 如果有餐厅ID，检查是否已经验证并加入了聊天室
      if (_restaurantId != null && roomIdToUse != null) {
        await _initializeChatWithRoom(provider, roomIdToUse);
      }
      // 如果有餐厅ID但没有房间ID，提示用户先去验证界面
      else if (_restaurantId != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('请先通过验证界面加入聊天室'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
      // 如果有店员ID，保持原有逻辑（兼容性）
      else if (widget.staffId != null) {
        // 店员聊天功能已移除，显示提示信息
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('店员聊天功能已迁移至餐厅聊天室')),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // 格式化消息时间显示
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      // 超过一周显示具体日期
      return '${dateTime.month}/${dateTime.day}';
    }
  }

  Future<void> _initializeChatWithRoom(ChatProvider provider, String roomId) async {
    try {
      // 获取用户信息
      final userId = await AuthService.getCurrentUserId();
      final userIdStr = userId?.toString();
      
      // 获取聊天室信息
      final roomInfo = await ChatService.getChatRoomInfo(roomId);
      final roomData = roomInfo['data'] ?? roomInfo;
      _roomName = roomData['name'] ?? '餐厅聊天室';
      
      // 如果WebSocket已经连接且消息已加载，不需要重复获取
      if (provider.isConnected && provider.messages.isNotEmpty) {
        // 只需要加入聊天室（如果还没有加入）
        if (provider.currentRoomId != roomId) {
          provider.joinRoom(roomId);
        }
        return;
      }
      
      // 获取历史消息
      await provider.fetchMessages(roomId, currentUserId: userIdStr);
      
      // 初始化STOMP WebSocket连接
      // 注意：这里需要临时token，通常在验证聊天室后获取
      // 如果已经通过验证界面连接，WebSocket应该已经连接
      // 如果没有连接，尝试使用空token初始化（这可能会失败，但不会影响已连接的情况）
      if (!provider.isConnected) {
        await provider.initialize('', userId: userIdStr);
      }
      
      // 加入聊天室
      provider.joinRoom(roomId);
    } catch (e) {
      debugPrint('初始化聊天室失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('初始化聊天室失败: $e')),
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    final String messageContent = _messageController.text.trim();
    if (messageContent.isEmpty) return;

    final provider = Provider.of<ChatProvider>(context, listen: false);
    
    // 使用Provider中的当前房间ID发送消息
    if (provider.currentRoomId != null) {
      await provider.sendMessage(provider.currentRoomId!, messageContent);
      _messageController.clear();
      
      // STOMP WebSocket会自动推送消息，不需要重新获取
      
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) _scrollToBottom();
      });
    } else {
      _messageController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('当前无可用聊天室')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: _roomName ?? '聊天',
        showBackButton: true,
        actions: [
          Consumer<ChatProvider>(
            builder: (context, provider, _) {
              return Row(
                children: [
                  if (provider.currentRoomId != null) ...[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: provider.isConnected ? AppColors.onlineStatus : AppColors.offlineStatus,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      provider.isConnected ? '已连接' : '未连接',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(width: 16),
                  ],
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) return const Center(child: CircularProgressIndicator());
                  if (provider.error != null) return Center(child: Text(provider.error!));

                  final messages = provider.messages;
                  if (messages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '暂无消息，开始聊天吧！',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          if (!provider.isConnected)
                            const Text(
                              'WebSocket未连接',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    );
                  }
                  
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      
                      // 获取发送者信息，确保不为空
                      final senderName = message.senderName.isNotEmpty ? message.senderName : '匿名用户';
                      final senderAvatar = message.senderAvatar?.isNotEmpty == true ? message.senderAvatar : null;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: message.isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            // 显示发送者昵称（非自己发送的消息）
                            if (!message.isSentByUser) ...[
                              Padding(
                                padding: const EdgeInsets.only(left: 44, bottom: 4),
                                child: Text(
                                  senderName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                            Row(
                              mainAxisAlignment: message.isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                if (!message.isSentByUser) ...[
                                  // 显示发送者头像
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryContainer,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: senderAvatar != null
                                          ? Image.network(
                                              senderAvatar,
                                              width: 36,
                                              height: 36,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Container(
                                                  color: AppColors.primaryContainer,
                                                  child: Center(
                                                    child: Text(
                                                      senderName.isNotEmpty ? senderName.substring(0, 1).toUpperCase() : '?',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              loadingBuilder: (context, child, loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Container(
                                                  color: AppColors.primaryContainer,
                                                  child: const Center(
                                                    child: SizedBox(
                                                      width: 16,
                                                      height: 16,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: Text(
                                                senderName.isNotEmpty ? senderName.substring(0, 1).toUpperCase() : '?',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: message.isSentByUser ? AppColors.primary : AppColors.surfaceVariant,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(12),
                                        topRight: const Radius.circular(12),
                                        bottomLeft: message.isSentByUser ? const Radius.circular(12) : const Radius.circular(0),
                                        bottomRight: message.isSentByUser ? const Radius.circular(0) : const Radius.circular(12),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          message.content,
                                          style: TextStyle(
                                            color: message.isSentByUser ? AppColors.onPrimary : AppColors.onSurface,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatTime(message.createdAt),
                                          style: TextStyle(
                                            color: message.isSentByUser
                                                ? AppColors.onPrimary.withOpacity(0.7)
                                                : AppColors.onSurface.withOpacity(0.6),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (message.isSentByUser) ...[
                                  const SizedBox(width: 8),
                                  // 自己的头像（显示用户头像）
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                border: Border(top: BorderSide(color: AppColors.outline)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image_outlined, color: AppColors.onSurfaceVariant),
                    onPressed: () {
                      // 选择图片的逻辑
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: '输入消息...',
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: AppColors.onPrimary),
                      onPressed: () => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}