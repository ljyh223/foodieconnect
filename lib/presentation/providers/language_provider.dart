import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 语言设置提供者
class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'language_code';
  
  Locale _locale = const Locale('en'); // 默认英语
  
  Locale get locale => _locale;
  
  /// 支持的语言列表
  static const List<Locale> supportedLocales = [
    Locale('en'), // 英语
    Locale('zh'), // 简体中文
    Locale('zh', 'TW'), // 繁体中文
  ];
  
  /// 语言显示名称映射
  static const Map<String, String> languageNames = {
    'zh': '简体中文',
    'zh_TW': '繁體中文',
    'en': 'English',
  };
  
  /// 初始化语言设置
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey);
    
    if (languageCode != null) {
      // 处理带地区的语言代码（如 zh_TW）
      if (languageCode.contains('_')) {
        final parts = languageCode.split('_');
        _locale = Locale(parts[0], parts[1]);
      } else {
        _locale = Locale(languageCode);
      }
    }
    
    notifyListeners();
  }
  
  /// 切换语言
  Future<void> changeLanguage(Locale locale) async {
    if (_locale == locale) return;
    
    _locale = locale;
    notifyListeners();
    
    // 保存到本地存储
    final prefs = await SharedPreferences.getInstance();
    if (locale.countryCode != null) {
      await prefs.setString(_languageKey, '${locale.languageCode}_${locale.countryCode}');
    } else {
      await prefs.setString(_languageKey, locale.languageCode);
    }
  }
  
  /// 获取当前语言的显示名称
  String get currentLanguageName {
    if (_locale.countryCode != null) {
      return languageNames['${_locale.languageCode}_${_locale.countryCode}'] ?? 
             languageNames[_locale.languageCode] ?? 'Unknown';
    }
    return languageNames[_locale.languageCode] ?? 'Unknown';
  }
  
  /// 根据语言代码获取Locale
  static Locale? getLocaleFromCode(String languageCode) {
    try {
      if (languageCode.contains('_')) {
        final parts = languageCode.split('_');
        return Locale(parts[0], parts[1]);
      } else {
        return Locale(languageCode);
      }
    } catch (e) {
      return null;
    }
  }
}