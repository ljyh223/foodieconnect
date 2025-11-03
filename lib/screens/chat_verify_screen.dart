import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../presentation/providers/chat_provider.dart';
import '../core/services/auth_service.dart';
import '../../generated/app_localizations.dart';

class ChatVerifyScreen extends StatefulWidget {
  final String? restaurantId;
  
  const ChatVerifyScreen({super.key, this.restaurantId});

  @override
  State<ChatVerifyScreen> createState() => _ChatVerifyScreenState();
}

class _ChatVerifyScreenState extends State<ChatVerifyScreen> {
  final TextEditingController _verificationController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  String? _restaurantId;

  @override
  void initState() {
    super.initState();
    // 优先使用构造函数参数，如果没有则从路由参数获取
    _restaurantId = widget.restaurantId ?? ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  void dispose() {
    _verificationController.dispose();
    super.dispose();
  }

  Future<void> handleVerification(BuildContext context) async {
    if ( _verificationController.text.isEmpty) {
      if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context).pleaseEnterVerificationCode;
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
        // 获取用户ID
        final userId = await AuthService.getCurrentUserId();
        final userIdStr = userId?.toString();
        
        // 注意：现在initialize方法需要tempToken参数，这里先传空字符串
        // 实际使用时需要从认证服务获取token
        await chatProvider.initialize('', userId: userIdStr);
      }
      
      await chatProvider.verifyAndJoinChatRoom(
        _restaurantId!, // 使用从路由参数获取的餐厅ID
        _verificationController.text.trim(),
      );

      if (chatProvider.currentRoomId != null && mounted) {
        Navigator.pushNamed(
          context,
          '/chat',
          arguments: {
            'restaurantId': _restaurantId!,
            'roomId': chatProvider.currentRoomId!,
          },
        );
      } else if (mounted) {
        setState(() {
          _error = AppLocalizations.of(context).verificationFailed;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = '${AppLocalizations.of(context).verificationError}${e.toString()}';
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
        title: AppLocalizations.of(context).restaurantChatVerification,
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
                      AppLocalizations.of(context).enterRestaurantIdAndCode,
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: _verificationController,
                      label: AppLocalizations.of(context).verificationCode,
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
                              AppLocalizations.of(context).verifyAndStartChat,
                            ),
                    ),
                  ],
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