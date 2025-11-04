// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'setting_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SettingLocalizationsZh extends SettingLocalizations {
  SettingLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get selectLanguage => '选择语言';

  @override
  String get close => '关闭';

  @override
  String get settings => '设置';

  @override
  String get languageSettings => '语言设置';

  @override
  String get currentLanguage => '当前语言';

  @override
  String get accountSettings => '账户设置';

  @override
  String get profile => '个人资料';

  @override
  String get privacy => '隐私设置';

  @override
  String get notifications => '通知设置';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get logout => '退出登录';

  @override
  String get sureLogout => '确定要退出登录吗？';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class SettingLocalizationsZhTw extends SettingLocalizationsZh {
  SettingLocalizationsZhTw() : super('zh_TW');

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get close => '關閉';

  @override
  String get settings => '設定';

  @override
  String get languageSettings => '語言設定';

  @override
  String get currentLanguage => '當前語言';

  @override
  String get accountSettings => '帳戶設定';

  @override
  String get profile => '個人資料';

  @override
  String get privacy => '隱私設定';

  @override
  String get notifications => '通知設定';

  @override
  String get about => '關於';

  @override
  String get version => '版本';

  @override
  String get logout => '登出';

  @override
  String get sureLogout => '確定要退出登錄嗎？';
}
