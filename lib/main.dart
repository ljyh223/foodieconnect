import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'core/utils/token_storage.dart';
import 'core/services/api_service.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/restaurant_provider.dart';
import 'presentation/providers/review_provider.dart';
import 'presentation/providers/staff_provider.dart';
import 'presentation/providers/chat_provider.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 尝试从安全存储恢复 access token 并注入 ApiService
  final access = await TokenStorage.readAccessToken();
  if (access != null && access.isNotEmpty) {
    ApiService().setToken(access);
    // 可选：在这里可以调用 AuthService.me() 来验证并预热用户数据
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..restoreFromStorage()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => StaffProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

/// 应用初始化组件，用于延迟初始化WebSocket连接
class AppInitializer extends StatefulWidget {
  final Widget child;
  
  const AppInitializer({super.key, required this.child});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // 延迟初始化，避免应用启动时立即连接WebSocket
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        _initializeApp();
      });
    });
  }

  Future<void> _initializeApp() async {
    if (_initialized) return;
    
    try {
      // 获取ChatProvider并初始化WebSocket连接
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      // 注意：现在initialize方法需要tempToken参数，这里先传空字符串
      // 实际使用时需要从认证服务获取token
      await chatProvider.initialize('');
      
      // 获取当前用户ID并订阅通知
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = await authProvider.getCurrentUserId();
      if (userId != null) {
        await chatProvider.subscribeToNotifications(userId.toString());
      }
      
      _initialized = true;
    } catch (e) {
      debugPrint('应用初始化失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      child: MaterialApp(
        title: 'Foodie Connect', // 更新应用名称为 Foodie Connect
        theme: AppTheme.lightTheme, // 使用新的简约黑白主题
        darkTheme: AppTheme.darkTheme, // 可选的暗色主题
        themeMode: ThemeMode.system, // 跟随系统主题设置
        initialRoute: '/splash',
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false, // 隐藏调试横幅
      ),
    );
  }
}
