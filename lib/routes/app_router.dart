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
import '../screens/restaurant_info_screen.dart';
import '../screens/create_review_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/profile_view_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/other_user_profile_screen.dart';
import '../screens/following_list_screen.dart';
import '../screens/recommendations_screen.dart';
import '../screens/main_tab_screen.dart';
import '../screens/dish_reviews_screen.dart';
import '../screens/create_dish_review_screen.dart';
import '../screens/dish_detail_screen.dart';
import '../screens/dish_list_screen.dart';
import '../data/models/recommended_dish_model.dart';

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
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ChatVerifyScreen(restaurantId: args?['restaurantId']),
        );
      case '/chat':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            restaurantId: args?['restaurantId'],
            roomId: args?['roomId'],
            isReadOnly: args?['isReadOnly'] ?? false,
          ),
        );
      case '/staff_detail':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => StaffDetailScreen(staffId: args?['staffId']),
        );
      case '/restaurant_info':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => RestaurantInfoScreen(restaurantId: args?['restaurantId']),
        );
      case '/create_review':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CreateReviewScreen(restaurantId: args?['restaurantId']),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case '/user_profile':
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case '/profile_view':
        return MaterialPageRoute(builder: (_) => const ProfileViewScreen());
      case '/edit_profile':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case '/other_user_profile':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtherUserProfileScreen(
            userId: args?['userId'],
          ),
        );
      case '/following_list':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => FollowingListScreen(
            userId: args?['userId'],
          ),
        );
      case '/recommendations':
        return MaterialPageRoute(builder: (_) => const RecommendationsScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainTabScreen());
      case '/dish_reviews':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DishReviewsScreen(
            restaurantId: args?['restaurantId'],
            menuItemId: args?['menuItemId'],
            itemName: args?['itemName'],
          ),
        );
      case '/create_dish_review':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CreateDishReviewScreen(
            restaurantId: args?['restaurantId'],
            menuItemId: args?['menuItemId'],
            itemName: args?['itemName'],
            reviewId: args?['reviewId'],
          ),
        );
      case '/dish_detail':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DishDetailScreen(
            restaurantId: args?['restaurantId']?.toString() ?? '',
            menuItemId: args?['dishId']?.toString() ?? args?['menuItemId']?.toString(),
          ),
        );
      case '/dish_list':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DishListScreen(
            restaurantId: args?['restaurantId'],
            restaurantName: args?['restaurantName'],
          ),
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