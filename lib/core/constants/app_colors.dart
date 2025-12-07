import 'package:flutter/material.dart';

/// Foodie Connect 应用颜色常量
/// 简约黑白灰配色方案
class AppColors {
  // 主要颜色 - 黑白灰配色
  static const Color primary = Color(0xFF000000); // 黑色作为主色调
  static const Color onPrimary = Color(0xFFFFFFFF); // 主色调上的文字为白色
  static const Color primaryContainer = Color(0xFFF5F5F5); // 浅灰色容器
  static const Color onPrimaryContainer = Color(0xFF000000); // 容器上的文字为黑色

  static const Color secondary = Color(0xFF757575); // 中灰色作为次要色
  static const Color onSecondary = Color(0xFFFFFFFF); // 次要色上的文字为白色
  static const Color secondaryContainer = Color(0xFFEEEEEE); // 更浅的灰色容器
  static const Color onSecondaryContainer = Color(0xFF212121); // 容器上的文字为深灰色

  static const Color tertiary = Color(0xFF424242); // 深灰色作为第三色
  static const Color onTertiary = Color(0xFFFFFFFF); // 第三色上的文字为白色
  static const Color tertiaryContainer = Color(0xFFE0E0E0); // 浅灰色容器
  static const Color onTertiaryContainer = Color(0xFF000000); // 容器上的文字为黑色

  static const Color surface = Color(0xFFFFFFFF); // 白色表面
  static const Color onSurface = Color(0xFF000000); // 表面上的文字为黑色
  static const Color surfaceContainerHighest = Color(0xFFF5F5F5); // 表面容器为浅灰色
  static const Color onSurfaceVariant = Color(0xFF757575); // 表面变体上的文字为中灰色

  // For backward compatibility
  static const Color surfaceVariant = surfaceContainerHighest;

  static const Color outline = Color(0xFFBDBDBD); // 边框线为浅灰色
  static const Color outlineVariant = Color(0xFFE0E0E0); // 边框变体为更浅的灰色

  // 背景颜色
  static const Color background = Color(0xFFFFFFFF); // 白色背景
  static const Color onBackground = Color(0xFF000000); // 背景上的文字为黑色

  // 错误颜色
  static const Color error = Color(0xFFB00020); // 错误色保持红色
  static const Color onError = Color(0xFFFFFFFF); // 错误色上的文字为白色
  static const Color errorContainer = Color(0xFFFDADF2); // 错误容器色
  static const Color onErrorContainer = Color(0xFF410002); // 错误容器上的文字

  // 评分颜色 - 保持橙色以突出显示
  static const Color ratingStar = Color(0xFFFF9800);

  // 状态颜色 - 使用绿色和灰色
  static const Color online = Color(0xFF4CAF50); // 在线状态使用绿色
  static const Color offline = Color(0xFF9E9E9E); // 离线状态使用灰色
  static const Color busy = Color(0xFF757575); // 忙碌状态使用中灰色

  // 额外的灰色调
  static const Color grey50 = Color(0xFFFAFAFA); // 极浅灰色
  static const Color grey100 = Color(0xFFF5F5F5); // 非常浅灰色
  static const Color grey200 = Color(0xFFEEEEEE); // 浅灰色
  static const Color grey300 = Color(0xFFE0E0E0); // 中浅灰色
  static const Color grey400 = Color(0xFFBDBDBD); // 中灰色
  static const Color grey500 = Color(0xFF9E9E9E); // 标准灰色
  static const Color grey600 = Color(0xFF757575); // 中深灰色
  static const Color grey700 = Color(0xFF616161); // 深灰色
  static const Color grey800 = Color(0xFF424242); // 非常深灰色
  static const Color grey900 = Color(0xFF212121); // 极深灰色

  // 特殊用途颜色
  static const Color divider = Color(0xFFE0E0E0); // 分割线颜色
  static const Color disabled = Color(0xFFBDBDBD); // 禁用状态颜色
  static const Color placeholder = Color(0xFF9E9E9E); // 占位符颜色
  static const Color hint = Color(0xFF9E9E9E); // 提示文字颜色

  // 强调色 - 在关键交互点使用
  static const Color accent = Color(0xFF000000); // 黑色强调色
  static const Color accentLight = Color(0xFF424242); // 浅色强调色

  // Alias for backward compatibility
  static const Color onlineStatus = online;
  static const Color offlineStatus = offline;
}
