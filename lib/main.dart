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
      title: 'TableTalk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          primary: const Color(0xFF6750A4),
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFEADDFF),
          onPrimaryContainer: const Color(0xFF21005D),
          secondary: const Color(0xFF625B71),
          onSecondary: Colors.white,
          secondaryContainer: const Color(0xFFE8DEF8),
          onSecondaryContainer: const Color(0xFF1D192B),
          surface: const Color(0xFFFEF7FF),
          onSurface: const Color(0xFF1D1B20),
          surfaceContainerHighest: const Color(0xFFE7E0EC),
          onSurfaceVariant: const Color(0xFF49454F),
          outline: const Color(0xFF79747E),
          outlineVariant: const Color(0xFFCAB6CF),
        ),
        useMaterial3: false,
      ),
      initialRoute: '/splash',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
