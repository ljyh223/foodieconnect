import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/providers/auth_provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/services/localization_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // 等待一小段时间让UI显示加载状态
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (!mounted) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.setContext(context);
    
    try {
      // 设置超时机制，最多等待5秒
      await _checkAuthWithTimeout(authProvider);
    } catch (e) {
      // 如果发生错误，显示错误信息并跳转到登录页
      if (!mounted) return;
      _showErrorAndNavigate(e.toString());
    }
  }

  void _showErrorAndNavigate(String error) {
    // 可以在这里显示错误提示，然后跳转到登录页
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${LocalizationService.I.isInitialized ? LocalizationService.I.authCheckFailed : 'Authentication check failed'}: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
      
      // 延迟跳转，让用户看到错误信息
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _navigateToLogin();
        }
      });
    } else {
      _navigateToLogin();
    }
  }

  Future<void> _checkAuthWithTimeout(AuthProvider authProvider) async {
    const timeoutDuration = Duration(seconds: 5);
    
    // 如果AuthProvider还在加载中，等待它完成
    if (authProvider.isLoading) {
      final completer = Completer<void>();
      final timer = Timer(timeoutDuration, () {
        if (!completer.isCompleted) {
          completer.completeError(TimeoutException(LocalizationService.I.isInitialized ? LocalizationService.I.authCheckTimeout : 'Authentication check timeout'));
        }
      });
      
      // 监听AuthProvider的状态变化
      VoidCallback? listener;
      listener = () {
        if (!authProvider.isLoading) {
          timer.cancel();
          authProvider.removeListener(listener!);
          if (!completer.isCompleted) {
            completer.complete();
          }
        }
      };
      
      authProvider.addListener(listener);
      await completer.future;
    }
    
    // 检查认证状态并导航
    _navigateBasedOnAuthStatus(authProvider);
  }

  void _navigateBasedOnAuthStatus(AuthProvider authProvider) {
    if (authProvider.isAuthenticated) {
      // 有有效token，跳转到首页
      _navigateToHome();
    } else {
      // 无token或token无效，跳转到登录页
      _navigateToLogin();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/shops');
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 应用图标或Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.onPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'TT',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 应用名称
            Text(
              LocalizationService.I.isInitialized ? LocalizationService.I.tableTalk : 'TableTalk',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.onPrimary,
              ),
            ),
            const SizedBox(height: 32),
            // 加载指示器
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
              ),
            ),
            const SizedBox(height: 16),
            // 加载文本
            Text(
              LocalizationService.I.isInitialized ? LocalizationService.I.checkingLoginStatus : 'Checking login status...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onPrimary.withAlpha(204), // 80% opacity
              ),
            ),
          ],
        ),
      ),
    );
  }
}