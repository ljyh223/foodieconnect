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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie Connect', // 更新应用名称为 Foodie Connect
      theme: AppTheme.lightTheme, // 使用新的简约黑白主题
      darkTheme: AppTheme.darkTheme, // 可选的暗色主题
      themeMode: ThemeMode.system, // 跟随系统主题设置
      initialRoute: '/splash',
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false, // 隐藏调试横幅
    );
  }
}
