import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/providers/chat_provider.dart';

class ChatVerifyScreen extends StatefulWidget {
  const ChatVerifyScreen({super.key});

  @override
  State<ChatVerifyScreen> createState() => _ChatVerifyScreenState();
}

class _ChatVerifyScreenState extends State<ChatVerifyScreen> {
  final TextEditingController _restaurantController = TextEditingController();
  final TextEditingController _verificationController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _restaurantController.dispose();
    _verificationController.dispose();
    super.dispose();
  }

  Future<void> handleVerification(BuildContext context) async {
    if (_restaurantController.text.isEmpty || _verificationController.text.isEmpty) {
      if (mounted) {
        setState(() {
          _error = '请填写完整信息';
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      
      // 确保WebSocket已连接
      if (!chatProvider.isConnected) {
        await chatProvider.initialize();
      }
      
      await chatProvider.joinRestaurantChat(
        _restaurantController.text.trim(),
        _verificationController.text.trim(),
      );

      if (chatProvider.currentRoomId != null && mounted) {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: {'roomId': chatProvider.currentRoomId},
        );
      } else if (mounted) {
        setState(() {
          _error = '验证失败，请检查餐厅ID和验证码';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = '验证失败：${e.toString()}';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: '餐厅聊天验证',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Icon(
                        Icons.restaurant,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '请输入餐厅ID和验证码以加入聊天室',
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),
                    TextFieldWidget(
                      controller: _restaurantController,
                      label: '餐厅ID',
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: _verificationController,
                      label: '验证码',
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, letterSpacing: 4),
                    ),
                    
                    if (_error != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : () => handleVerification(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              '验证并开始聊天',
                              style: AppTextStyles.titleSmall,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // 重新获取验证码的逻辑
                },
                child: Text(
                  '重新获取验证码',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool isPassword;
  final TextInputType keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final TextStyle? style;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.label,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.style,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
        // 禁用浮动标签动画
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      obscureText: isPassword,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textAlign: textAlign,
      style: style,
      validator: validator,
    );
  }
}