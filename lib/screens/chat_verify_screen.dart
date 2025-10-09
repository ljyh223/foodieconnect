import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';

class ChatVerifyScreen extends StatelessWidget {
  const ChatVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {


    void handleVerification(BuildContext context) {
      Navigator.pushNamed(
        context,
        '/chat',
        arguments: {'staffId': '1'},
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: '聊天验证',
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
                        Icons.security,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '为了保障您的聊天体验，请输入下方验证码进行验证。',
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: '请输入验证码',
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, letterSpacing: 8),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => handleVerification(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
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