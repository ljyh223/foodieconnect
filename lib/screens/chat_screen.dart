import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletalk/generated/app_localizations.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/providers/chat_provider.dart';
import '../presentation/widgets/chat_message_widget.dart';
import '../presentation/widgets/new_message_indicator.dart';
import '../presentation/utils/chat_time_formatter.dart';
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
  
  // 新消息提示相关状态
  bool _showNewMessageIndicator = false;
  int _unreadMessageCount = 0;
  bool _isAtBottom = true;

  @override
  void initState() {
    super.initState();
    
    // 设置餐厅ID
    _restaurantId = widget.restaurantId;
    
    // 监听滚动位置变化
    _scrollController.addListener(_scrollListener);

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
            SnackBar(
              content: Text(AppLocalizations.of(context).pleaseVerifyFirst),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
      // 如果有店员ID，保持原有逻辑（兼容性）
      else if (widget.staffId != null) {
        // 店员聊天功能已移除，显示提示信息
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context).staffChatFeatureMoved)),
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
  
  // 监听滚动位置变化
  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = 50.0; // 距离底部50px内视为在底部
      
      final wasAtBottom = _isAtBottom;
      _isAtBottom = (maxScroll - currentScroll) <= delta;
      
      // 如果用户滚动到底部，隐藏新消息提示
      if (_isAtBottom && !wasAtBottom) {
        setState(() {
          _showNewMessageIndicator = false;
          _unreadMessageCount = 0;
        });
      }
    }
  }

  void _scrollToBottom() {
    // 使用延迟确保UI完全更新后再滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        // 强制重新计算布局
        _scrollController.position.notifyListeners();
        
        // 直接跳转到底部，不使用动画
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        
        // 多次延迟确保滚动到真正的底部
        for (int i = 0; i < 3; i++) {
          Future.delayed(Duration(milliseconds: 100 * (i + 1)), () {
            if (mounted && _scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });
        }
      }
    });
  }

  Future<void> _initializeChatWithRoom(ChatProvider provider, String roomId) async {
    try {
      // 获取用户信息
      final userId = await AuthService.getCurrentUserId();
      final userIdStr = userId?.toString();
      
      // 获取聊天室信息
      final roomInfo = await ChatService.getChatRoomInfo(roomId);
      final roomData = roomInfo['data'] ?? roomInfo;
      _roomName = roomData['name'] ?? AppLocalizations.of(context).restaurantChatRoom;
      
      // 设置新消息回调
      provider.setNewMessageCallback(_handleNewMessages);
      
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
          SnackBar(content: Text('${AppLocalizations.of(context).initializeChatRoomError}$e')),
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
      
      // 发送消息后滚动到底部
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _scrollToBottom();
      });
    } else {
      _messageController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).noAvailableChatRoom)),
        );
      }
    }
  }
  
  // 处理新消息提示
  void _handleNewMessages() {
    if (!_isAtBottom && mounted) {
      setState(() {
        _showNewMessageIndicator = true;
        _unreadMessageCount++;
      });
    } else {
      // 如果在底部，直接滚动到最新消息
      // 使用更长的延迟确保消息列表完全更新
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _scrollToBottom();
      });
    }
  }
  
  // 点击新消息提示，滚动到底部
  void _scrollToBottomAndClearIndicator() {
    setState(() {
      _showNewMessageIndicator = false;
      _unreadMessageCount = 0;
    });
    
    // 使用延迟确保状态更新后再滚动
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _scrollController.hasClients) {
        // 强制重新计算布局
        _scrollController.position.notifyListeners();
        
        // 直接跳转到底部，不使用动画
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        
        // 多次延迟确保滚动到真正的底部
        for (int i = 0; i < 3; i++) {
          Future.delayed(Duration(milliseconds: 100 * (i + 1)), () {
            if (mounted && _scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: _roomName ?? AppLocalizations.of(context).chat,
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
                        color: provider.isConnected ? AppColors.online : AppColors.offline,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      provider.isConnected ? AppLocalizations.of(context).connected : AppLocalizations.of(context).disconnected,
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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Consumer<ChatProvider>(
                    builder: (context, provider, _) {
                      // 监听消息变化，触发新消息提示
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (provider.messages.isNotEmpty && _isAtBottom) {
                          // 如果在底部，自动滚动到最新消息
                          Future.delayed(const Duration(milliseconds: 300), () {
                            if (mounted) _scrollToBottom();
                          });
                        }
                      });
                      
                      if (provider.isLoading) return const Center(child: CircularProgressIndicator());
                      if (provider.error != null) return Center(child: Text(provider.error!));

                      final messages = provider.messages;
                      if (messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context).noMessagesStartChat,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              if (!provider.isConnected)
                                Text(
                                  AppLocalizations.of(context).websocketNotConnected,
                                  style: const TextStyle(color: Colors.red),
                                ),
                            ],
                          ),
                        );
                      }
                      
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          // 当有新消息且不在底部时，显示新消息提示
                          if (scrollNotification is ScrollUpdateNotification) {
                            // 这里可以添加额外的滚动处理逻辑
                          }
                          return false;
                        },
                        child: ListView.builder(
                          key: ValueKey(messages.length),
                          controller: _scrollController,
                          itemCount: messages.length,
                          reverse: false,
                          shrinkWrap: false,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            
                            // 检查是否需要显示时间分隔（当前消息与上一条消息时间差超过10分钟）
                            bool showTimeSeparator = false;
                            String? timeSeparatorText;
                            
                            if (index > 0) {
                              final prevMessage = messages[index - 1];
                              final timeDiff = message.createdAt.difference(prevMessage.createdAt);
                              showTimeSeparator = timeDiff.inMinutes > 10;
                            } else {
                              // 第一条消息总是显示时间
                              showTimeSeparator = true;
                            }
                            
                            if (showTimeSeparator) {
                              timeSeparatorText = ChatTimeFormatter.formatDateForSeparator( message.createdAt);
                            }
                            
                            return ChatMessageWidget(
                              message: message,
                              showTimeSeparator: showTimeSeparator,
                              timeSeparatorText: timeSeparatorText,
                            );
                          },
                        ),
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
                            hintText: AppLocalizations.of(context).enterMessage,
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
            // 新消息提示浮动按钮
            if (_showNewMessageIndicator)
              NewMessageIndicator(
                unreadCount: _unreadMessageCount,
                onTap: _scrollToBottomAndClearIndicator,
              ),
          ],
        ),
      ),
    );
  }
}