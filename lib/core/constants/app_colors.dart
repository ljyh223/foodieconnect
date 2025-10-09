import 'package:flutter/material.dart';

class AppColors {
  // Material 3 Color Scheme
  static const Color primary = Color(0xFF6750A4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color onPrimaryContainer = Color(0xFF21005D);
  
  static const Color secondary = Color(0xFF625B71);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color onSecondaryContainer = Color(0xFF1D192B);
  
  static const Color tertiary = Color(0xFF7D5260);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFFFD8E4);
  static const Color onTertiaryContainer = Color(0xFF31111D);
  
  static const Color surface = Color(0xFFFEF7FF);
  static const Color onSurface = Color(0xFF1D1B20);
  static const Color surfaceContainerHighest = Color(0xFFE7E0EC);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  
  // For backward compatibility
  static const Color surfaceVariant = surfaceContainerHighest;
  
  static const Color outline = Color(0xFF79747E);
  static const Color outlineVariant = Color(0xFFCAB6CF);
  
  // Additional colors
  static const Color error = Color(0xFFB3261E);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFF9DEDC);
  static const Color onErrorContainer = Color(0xFF410E0B);
  
  static const Color background = Color(0xFFFEF7FF);
  static const Color onBackground = Color(0xFF1D1B20);
  
  // Rating colors
  static const Color ratingStar = Color(0xFFFF9800);
  
  // Status colors
  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  static const Color busy = Color(0xFFFF9800);
  
  // Alias for backward compatibility
  static const Color onlineStatus = online;
  static const Color offlineStatus = offline;
}