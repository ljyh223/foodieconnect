import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/models/staff_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/providers/chat_provider.dart';
import '../core/services/chat_service.dart';

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
  late Staff _staff;
  String? _restaurantId;
  String? _roomId;
  String? _roomName;

  @override
  void initState() {
    super.initState();
    
    // 设置餐厅ID和房间ID
    _restaurantId = widget.restaurantId;
    _roomId = widget.roomId;

    _staff = Staff(
      id: '1',
      name: '小张',
      position: '服务员',
      status: '在线',
      experience: '3年',
      rating: 4.9,
      skills: ['菜品推荐', '过敏咨询'],
      languages: ['中文'],
      reviews: [],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ChatProvider>(context, listen: false);

      // 初始化WebSocket连接
      await provider.initialize();

      // 如果有房间ID，直接获取消息
      if (_roomId != null) {
        await provider.fetchMessages(_roomId!);
      }
      // 如果有餐厅ID，获取餐厅聊天室
      else if (_restaurantId != null) {
        try {
          final roomInfo = await ChatService.getRestaurantChatRoom(_restaurantId!);
          final roomData = roomInfo['data'] ?? roomInfo;
          _roomId = roomData['id']?.toString();
          _roomName = roomData['name'] ?? '餐厅聊天室';
          if (_roomId != null) {
            await provider.fetchMessages(_roomId!);
          }
        } catch (e) {
          debugPrint('获取餐厅聊天室失败: $e');
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

      if (mounted) _scrollToBottom();
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

  Future<void> _sendMessage() async {
    final String messageContent = _messageController.text.trim();
    if (messageContent.isEmpty) return;

    final provider = Provider.of<ChatProvider>(context, listen: false);
    
    // 使用房间ID发送消息
    if (_roomId != null) {
      await provider.sendMessage(_roomId!, messageContent);
      _messageController.clear();
      
      // WebSocket会自动推送消息，不需要重新获取
      
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
                  if (_roomId != null) ...[
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: message.isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!message.isSentByUser)
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            const SizedBox(width: 8),
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
                                child: Text(
                                  message.content,
                                  style: TextStyle(
                                    color: message.isSentByUser ? AppColors.onPrimary : AppColors.onSurface,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
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