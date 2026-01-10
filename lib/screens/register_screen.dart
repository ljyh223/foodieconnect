import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presentation/providers/auth_provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../presentation/widgets/text_field_widget.dart';
import 'package:foodieconnect/generated/translations.g.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return t.auth.pleaseEnterEmail;
    }
    // 修复：原来的正则在结尾处多了一个转义符号，导致校验异常
    final emailRegex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return t.auth.pleaseEnterValidEmail;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return t.auth.pleaseEnterPassword;
    }
    if (value.length < 6) return t.auth.passwordMinLength;
    return null;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setContext(context);
    await auth.register(
      _emailController.text.trim(),
      _passwordController.text,
      _displayNameController.text.trim(),
    );

    if (!mounted) return;

    if (auth.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error!), backgroundColor: Colors.red),
      );
    } else {
      // 显示注册成功提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.auth.registrationSuccessful),
          backgroundColor: Colors.green,
        ),
      );
      // 注册成功，直接回到登录页或跳转到商店页
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('注册'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.onSurface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Header
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.person_add,
                      color: AppColors.onPrimary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.auth.createAccount,
                    style: AppTextStyles.headlineSmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t.auth.joinFoodieConnect,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Registration Form
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        controller: _displayNameController,
                        label: t.auth.displayName,
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),

                      TextFieldWidget(
                        controller: _emailController,
                        label: t.auth.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 16),

                      TextFieldWidget(
                        controller: _passwordController,
                        label: t.auth.password,
                        obscureText: true,
                        validator: _validatePassword,
                        prefixIcon: Icons.lock_outline,
                      ),
                      const SizedBox(height: 24),

                      Consumer<AuthProvider>(
                        builder: (context, auth, _) {
                          return ElevatedButton(
                            onPressed: auth.isLoading ? null : _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: auth.isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.onPrimary,
                                      ),
                                    ),
                                  )
                                : Text(
                                    t.auth.register,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.auth.alreadyHaveAccount,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      t.auth.loginNow,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
