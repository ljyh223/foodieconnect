import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
// chat_message_model is not used directly in this screen
import '../data/models/staff_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  final String? staffId;

  const ChatScreen({super.key, this.staffId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late Staff _staff;

  @override
  void initState() {
    super.initState();

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

      if (widget.staffId != null) {
        await provider.fetchSessionsForUser(widget.staffId!);
        if (provider.sessions.isNotEmpty) {
          final sessionId = provider.sessions.first.id;
          await provider.fetchMessages(sessionId);
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
    final sessionId = provider.sessions.isNotEmpty ? provider.sessions.first.id : null;
    if (sessionId == null) {
      _messageController.clear();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('当前无可用会话')));
      return;
    }

    await provider.sendMessage(sessionId, messageContent);
    _messageController.clear();
    await provider.fetchMessages(sessionId);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: _staff.name,
        showBackButton: true,
        actions: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _staff.status == '在线' ? AppColors.onlineStatus : AppColors.offlineStatus,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                _staff.status,
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(width: 16),
            ],
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
                                child: Center(
                                  child: Text(
                                    message.staffName?.substring(0, 1) ?? '',
                                    style: TextStyle(
                                      color: AppColors.onPrimaryContainer,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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