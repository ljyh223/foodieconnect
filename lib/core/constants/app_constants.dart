class AppConstants {
  // App Info
  static const String appName = 'FoodieConnect';
  static const String appVersion = '1.0.0';

  // API Endpoints
  // 请根据实际部署替换 BASE_API_URL（默认使用示例域名）
  static const String baseUrl = 'http://192.168.124.36:8080/api/v1';
  static const String wsBaseUrl = 'ws://192.168.124.36:8080';

  // Auth
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshEndpoint = '/auth/refresh';
  static const String meEndpoint = '/auth/me';

  // Restaurants
  static const String restaurantsEndpoint = '/restaurants';
  static const String restaurantsReviewsEndpoint =
      '/restaurants/{restaurantId}/reviews';

  // Staff
  static const String staffEndpoint = '/staff';

  // Chat
  static const String chatEndpoint = '/chat';

  // Validation Rules
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int verificationCodeLength = 6;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultElevation = 1.0;
  static const double defaultSpacing = 16.0;

  // Animation Duration
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);

  // Chat Constants
  static const int maxMessageLength = 500;
  static const Duration typingIndicatorDuration = Duration(seconds: 3);
}
