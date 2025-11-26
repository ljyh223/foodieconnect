import 'package:flutter/material.dart';
import 'package:tabletalk/generated/translations.g.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/api_service.dart';
import '../../data/models/chat_message_model.dart';
import '../../core/services/auth_service.dart';

/// 聊天消息组件
class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool showTimeSeparator;
  final String? timeSeparatorText;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.showTimeSeparator = false,
    this.timeSeparatorText,
  });

  /// 获取当前用户头像
  Future<String?> _getCurrentUserAvatar() async {
    try {
      final user = await AuthService.me();
      return user.avatarUrl;
    } catch (e) {
      debugPrint('获取用户头像失败: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取发送者信息，确保不为空
    final senderName = message.senderName.isNotEmpty ? message.senderName : '匿名用户';
    final senderAvatar = message.senderAvatar?.isNotEmpty == true ? message.senderAvatar : null;

    return Column(
      children: [
        if (showTimeSeparator && timeSeparatorText != null)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    timeSeparatorText!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: message.isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isSentByUser) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/other_user_profile',
                      arguments: {'userId': message.senderId},
                    );
                                    },
                  child: Column(
                    children: [
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
                            ApiService.getFullImageUrl(senderAvatar),
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.primaryContainer,
                                child: Center(
                                  child: Text(
                                    senderName.isNotEmpty
                                        ? senderName.substring(0, 1).toUpperCase()
                                        : '?',
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
                              senderName.isNotEmpty
                                  ? senderName.substring(0, 1).toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 60,
                        child: Text(
                          senderName,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
                  child: Text(
                    message.content,
                    style: TextStyle(
                      color: message.isSentByUser ? AppColors.onPrimary : AppColors.onSurface,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              if (message.isSentByUser) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user_profile');
                  },
                  child: FutureBuilder<String?>(
                    future: _getCurrentUserAvatar(),
                    builder: (context, snapshot) {
                      final userAvatar = snapshot.data;

                      return Column(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: userAvatar != null && userAvatar.isNotEmpty
                                  ? Image.network(
                                ApiService.getFullImageUrl(userAvatar),
                                width: 36,
                                height: 36,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.primary,
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: AppColors.primary,
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
                                  : const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 60,
                            child: Text(
                              t.chat.me,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}