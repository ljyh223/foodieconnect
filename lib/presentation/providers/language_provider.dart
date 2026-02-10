import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodieconnect/generated/translations.g.dart'; // 引入 slangs 生成的翻译

/// 语言设置提供者
class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'app_locale';

  /// 当前应用语言枚举
  AppLocale _currentLocale = AppLocale.en;

  AppLocale get currentLocale => _currentLocale;

  /// 获取当前语言的Locale对象，直接使用slang提供的flutterLocale
  Locale get locale => _currentLocale.flutterLocale;

  /// 支持的语言列表，直接从AppLocale枚举转换
  static List<Locale> get supportedLocales =>
      AppLocale.values.map((locale) => locale.flutterLocale).toList();

  /// 语言显示名称映射
  static const Map<AppLocale, String> languageNames = {
    AppLocale.zh: '简体中文',
    AppLocale.zhTw: '繁體中文',
    AppLocale.en: 'English',
  };

  /// 初始化语言设置
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString(_languageKey);

    if (savedLocale != null) {
      // 直接从字符串解析AppLocale
      _currentLocale = AppLocale.values.firstWhere(
        (locale) => locale.name == savedLocale,
        orElse: () => AppLocale.en,
      );
    }
    // 如果没有保存的语言，默认使用英语（已在第10行设置为 AppLocale.en）

    // 初始化slangs的翻译设置
    await LocaleSettings.setLocale(_currentLocale);

    notifyListeners();
  }

  /// 切换语言
  Future<void> changeLanguage(AppLocale locale) async {
    if (_currentLocale == locale) return;

    _currentLocale = locale;

    // 更新slangs的翻译设置
    await LocaleSettings.setLocale(locale);

    // 保存到本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.name);

    notifyListeners();
  }

  /// 获取当前语言的显示名称
  String get currentLanguageName {
    return languageNames[_currentLocale] ?? 'Unknown';
  }

  /// 获取所有支持的语言选项（AppLocale和显示名称）
  static List<MapEntry<AppLocale, String>> get supportedLanguageOptions {
    return languageNames.entries.toList();
  }
}
