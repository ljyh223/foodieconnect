import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/shops_screen.dart';
import '../screens/shop_detail_screen.dart';
import '../screens/shop_features_screen.dart';
import '../screens/reviews_screen.dart';
import '../screens/staff_screen.dart';
import '../screens/chat_verify_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/staff_detail_screen.dart';
import '../screens/register_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/':
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/shops':
        return MaterialPageRoute(builder: (_) => const ShopsScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/shop_detail':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ShopDetailScreen(restaurantId: args?['restaurantId']),
        );
      case '/shop_features':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ShopFeaturesScreen(restaurantId: args?['restaurantId'].toString()),
        );
      case '/reviews':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ReviewsScreen(restaurantId: args?['restaurantId']),
        );
      case '/staff':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => StaffScreen(restaurantId: args?['restaurantId']),
        );
      case '/chat_verify':
        return MaterialPageRoute(builder: (_) => const ChatVerifyScreen());
      case '/chat':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(staffId: args?['staffId']),
        );
      case '/staff_detail':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => StaffDetailScreen(staffId: args?['staffId']),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}