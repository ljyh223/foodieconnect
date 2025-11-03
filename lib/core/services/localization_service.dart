import 'package:flutter/widgets.dart';
import '../../generated/app_localizations.dart';


class LocalizationService {
  static AppLocalizations? _instance;
  
  /// 在MaterialApp.builder中调用，绑定当前Localizations实例
  static void update(BuildContext context) {
    _instance = AppLocalizations.of(context);
  }
  
  /// 获取当前本地化实例
  static AppLocalizations get I {
    if (_instance == null) {
      throw Exception('LocalizationService未初始化，请在MaterialApp.builder中调用update(context)');
    }
    return _instance!;
  }
}