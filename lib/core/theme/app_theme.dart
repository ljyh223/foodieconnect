import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Foodie Connect 应用主题配置
/// 简约主义和扁平化设计风格
class AppTheme {
  // 获取简约黑白主题
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // 颜色方案 - 黑白灰配色
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF000000),        // 黑色作为主色调
        onPrimary: Color(0xFFFFFFFF),        // 主色调上的文字为白色
        primaryContainer: Color(0xFFF5F5F5), // 浅灰色容器
        onPrimaryContainer: Color(0xFF000000), // 容器上的文字为黑色
        
        secondary: Color(0xFF757575),        // 中灰色作为次要色
        onSecondary: Color(0xFFFFFFFF),       // 次要色上的文字为白色
        secondaryContainer: Color(0xFFEEEEEE), // 更浅的灰色容器
        onSecondaryContainer: Color(0xFF212121), // 容器上的文字为深灰色
        
        tertiary: Color(0xFF424242),         // 深灰色作为第三色
        onTertiary: Color(0xFFFFFFFF),       // 第三色上的文字为白色
        tertiaryContainer: Color(0xFFE0E0E0), // 浅灰色容器
        onTertiaryContainer: Color(0xFF000000), // 容器上的文字为黑色
        
        error: Color(0xFFB00020),            // 错误色保持红色
        onError: Color(0xFFFFFFFF),          // 错误色上的文字为白色
        errorContainer: Color(0xFFFDADF2),   // 错误容器色
        onErrorContainer: Color(0xFF410002), // 错误容器上的文字
        
        background: Color(0xFFFFFFFF),       // 白色背景
        onBackground: Color(0xFF000000),     // 背景上的文字为黑色
        
        surface: Color(0xFFFFFFFF),          // 白色表面
        onSurface: Color(0xFF000000),        // 表面上的文字为黑色
        surfaceVariant: Color(0xFFF5F5F5),   // 表面变体为浅灰色
        onSurfaceVariant: Color(0xFF757575), // 表面变体上的文字为中灰色
        
        outline: Color(0xFFBDBDBD),          // 边框线为浅灰色
        outlineVariant: Color(0xFFE0E0E0),   // 边框变体为更浅的灰色
        
        shadow: Color(0x00000000),           // 无阴影
        scrim: Color(0xFF000000),            // 遮罩为黑色
        inverseSurface: Color(0xFF121212),   // 反转表面为深灰色
        onInverseSurface: Color(0xFFFFFFFF), // 反转表面上的文字为白色
        inversePrimary: Color(0xFFB3B3B3),   // 反转主色为浅灰色
        surfaceTint: Color(0xFF000000),      // 表面色调为黑色
      ),
      
      // 文本主题
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFF757575),
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF757575),
        ),
      ),
      
      // AppBar 主题
      appBarTheme: const AppBarTheme(
        elevation: 0,                          // 无阴影，扁平化设计
        centerTitle: false,                   // 标题左对齐
        backgroundColor: Color(0xFFFFFFFF),   // 白色背景
        foregroundColor: Color(0xFF000000),   // 黑色文字和图标
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF000000),           // 黑色图标
          size: 24,
        ),
      ),
      
      // 卡片主题
      cardTheme: CardThemeData(
        elevation: 0,                         // 无阴影，扁平化设计
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFFE0E0E0),         // 浅灰色边框
            width: 1,
          ),
        ),
        color: const Color(0xFFFFFFFF),       // 白色背景
        margin: EdgeInsets.zero,
      ),
      
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,                        // 无阴影，扁平化设计
          backgroundColor: const Color(0xFF000000), // 黑色背景
          foregroundColor: const Color(0xFFFFFFFF), // 白色文字
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF000000), // 黑色文字
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF000000), // 黑色文字
          side: const BorderSide(
            color: Color(0xFF000000),           // 黑色边框
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),   // 浅灰色填充
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),         // 浅灰色边框
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),         // 浅灰色边框
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF000000),         // 黑色聚焦边框
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFB00020),         // 红色错误边框
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFB00020),         // 红色聚焦错误边框
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFF757575),           // 中灰色标签
          fontSize: 14,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF9E9E9E),           // 浅灰色提示
          fontSize: 14,
        ),
      ),
      
      // 分割线主题
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE0E0E0),             // 浅灰色分割线
        thickness: 1,
        space: 1,
      ),
      
      // 图标主题
      iconTheme: const IconThemeData(
        color: Color(0xFF000000),             // 黑色图标
        size: 24,
      ),
      
      // 浮动操作按钮主题
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF000000),   // 黑色背景
        foregroundColor: Color(0xFFFFFFFF),   // 白色图标
        elevation: 0,                         // 无阴影
        shape: CircleBorder(),
      ),
      
      // 底部导航栏主题
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),   // 白色背景
        selectedItemColor: Color(0xFF000000),  // 黑色选中项
        unselectedItemColor: Color(0xFF757575), // 中灰色未选中项
        type: BottomNavigationBarType.fixed,
        elevation: 0,                         // 无阴影
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      
      // 列表瓦片主题
      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFF000000),         // 黑色图标
        textColor: Color(0xFF000000),         // 黑色文字
        tileColor: Color(0xFFFFFFFF),         // 白色背景
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      
      // 对话框主题
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFFFFFFFF), // 白色背景
        elevation: 0,                         // 无阴影
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),           // 黑色标题
        ),
        contentTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF000000),           // 黑色内容
        ),
      ),
      
      // 开关主题
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF000000);   // 黑色拇指（选中）
          }
          return const Color(0xFFBDBDBD);     // 浅灰色拇指（未选中）
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF757575);   // 中灰色轨道（选中）
          }
          return const Color(0xFFE0E0E0);     // 浅灰色轨道（未选中）
        }),
      ),
      
      // 复选框主题
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF000000);   // 黑色填充（选中）
          }
          return Colors.transparent;          // 透明填充（未选中）
        }),
        checkColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)), // 白色勾选标记
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(
          color: Color(0xFF757575),           // 中灰色边框
          width: 2,
        ),
      ),
      
      // 单选按钮主题
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF000000);   // 黑色填充（选中）
          }
          return const Color(0xFF757575);     // 中灰色填充（未选中）
        }),
      ),
      
      // 滑块主题
      sliderTheme: SliderThemeData(
        activeTrackColor: const Color(0xFF000000), // 黑色活动轨道
        inactiveTrackColor: const Color(0xFFE0E0E0), // 浅灰色非活动轨道
        thumbColor: const Color(0xFF000000),   // 黑色拇指
        overlayColor: const Color(0x1A000000), // 黑色叠加
        valueIndicatorColor: const Color(0xFF000000), // 黑色值指示器
        valueIndicatorTextStyle: const TextStyle(
          color: Color(0xFFFFFFFF),           // 白色值指示器文字
        ),
      ),
      
      // 进度指示器主题
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF000000),             // 黑色进度指示器
        linearTrackColor: Color(0xFFE0E0E0),  // 浅灰色轨道
        circularTrackColor: Color(0xFFE0E0E0), // 浅灰色轨道
      ),
      
      // 芯片主题
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF5F5F5), // 浅灰色背景
        selectedColor: const Color(0xFF000000),  // 黑色选中背景
        disabledColor: const Color(0xFFE0E0E0),  // 浅灰色禁用背景
        labelStyle: const TextStyle(
          color: Color(0xFF000000),           // 黑色文字
        ),
        secondaryLabelStyle: const TextStyle(
          color: Color(0xFFFFFFFF),           // 白色次要文字
        ),
        brightness: Brightness.light,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      
      // 页面过渡
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
  
  // 获取暗色主题（可选）
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // 颜色方案 - 反转黑白配色
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFFFFF),        // 白色作为主色调
        onPrimary: Color(0xFF000000),        // 主色调上的文字为黑色
        primaryContainer: Color(0xFF2C2C2C), // 深灰色容器
        onPrimaryContainer: Color(0xFFFFFFFF), // 容器上的文字为白色
        
        secondary: Color(0xFFB3B3B3),        // 浅灰色作为次要色
        onSecondary: Color(0xFF000000),       // 次要色上的文字为黑色
        secondaryContainer: Color(0xFF424242), // 深灰色容器
        onSecondaryContainer: Color(0xFFE0E0E0), // 容器上的文字为浅灰色
        
        tertiary: Color(0xFFE0E0E0),         // 浅灰色作为第三色
        onTertiary: Color(0xFF000000),       // 第三色上的文字为黑色
        tertiaryContainer: Color(0xFF424242), // 深灰色容器
        onTertiaryContainer: Color(0xFFFFFFFF), // 容器上的文字为白色
        
        error: Color(0xFFCF6679),            // 错误色保持粉红色
        onError: Color(0xFF000000),          // 错误色上的文字为黑色
        errorContainer: Color(0xFFB00020),   // 错误容器色
        onErrorContainer: Color(0xFFFFFFFF), // 错误容器上的文字
        
        background: Color(0xFF121212),       // 深灰色背景
        onBackground: Color(0xFFFFFFFF),     // 背景上的文字为白色
        
        surface: Color(0xFF1E1E1E),          // 深灰色表面
        onSurface: Color(0xFFFFFFFF),        // 表面上的文字为白色
        surfaceVariant: Color(0xFF2C2C2C),   // 表面变体为深灰色
        onSurfaceVariant: Color(0xFFB3B3B3), // 表面变体上的文字为浅灰色
        
        outline: Color(0xFF757575),          // 边框线为中灰色
        outlineVariant: Color(0xFF424242),   // 边框变体为深灰色
        
        shadow: Color(0x00000000),           // 无阴影
        scrim: Color(0xFF000000),            // 遮罩为黑色
        inverseSurface: Color(0xFFE0E0E0),   // 反转表面为浅灰色
        onInverseSurface: Color(0xFF000000), // 反转表面上的文字为黑色
        inversePrimary: Color(0xFF757575),   // 反转主色为中灰色
        surfaceTint: Color(0xFFFFFFFF),      // 表面色调为白色
      ),
      
      // 其他主题配置与浅色主题类似，但颜色反转
      // 这里省略了详细配置，实际使用时可以根据需要添加
    );
  }
}