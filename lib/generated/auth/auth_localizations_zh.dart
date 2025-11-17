// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AuthLocalizationsZh extends AuthLocalizations {
  AuthLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get login => '登录';

  @override
  String get register => '注册';

  @override
  String get email => '邮箱地址';

  @override
  String get password => '密码';

  @override
  String get displayName => '显示名称';

  @override
  String get phoneNumber => '手机号码';

  @override
  String get pleaseEnterEmail => '请输入邮箱地址';

  @override
  String get pleaseEnterValidEmail => '请输入有效的邮箱地址';

  @override
  String get pleaseEnterPassword => '请输入密码';

  @override
  String get passwordMinLength => '密码至少需要6位字符';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get noAccountYet => '还没有账号？';

  @override
  String get registerNow => '立即注册';

  @override
  String get alreadyHaveAccount => '已有账号？';

  @override
  String get loginNow => '立即登录';

  @override
  String get createAccount => '创建账号';

  @override
  String get joinTableTalk => '加入TableTalk，发现更多美食';

  @override
  String get loginFailed => '登录失败，请稍后重试';

  @override
  String get checkingLoginStatus => '正在检查登录状态...';

  @override
  String get authCheckFailed => '认证检查失败';

  @override
  String get authCheckTimeout => '认证检查超时';

  @override
  String get invalidEmailOrPassword => '邮箱或密码错误';

  @override
  String get registrationFailed => '注册失败';

  @override
  String get logoutFailed => '登出失败';

  @override
  String get restoreLoginFailed => '恢复登录状态失败';

  @override
  String get loginSuccessful => '登录成功';

  @override
  String get registrationSuccessful => '注册成功';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AuthLocalizationsZhTw extends AuthLocalizationsZh {
  AuthLocalizationsZhTw() : super('zh_TW');

  @override
  String get login => '登入';

  @override
  String get register => '註冊';

  @override
  String get email => '郵箱地址';

  @override
  String get password => '密碼';

  @override
  String get displayName => '顯示名稱';

  @override
  String get phoneNumber => '手機號碼';

  @override
  String get pleaseEnterEmail => '請輸入郵箱地址';

  @override
  String get pleaseEnterValidEmail => '請輸入有效的郵箱地址';

  @override
  String get pleaseEnterPassword => '請輸入密碼';

  @override
  String get passwordMinLength => '密碼至少需要6位字符';

  @override
  String get forgotPassword => '忘記密碼？';

  @override
  String get noAccountYet => '還沒有帳號？';

  @override
  String get registerNow => '立即註冊';

  @override
  String get alreadyHaveAccount => '已有帳號？';

  @override
  String get loginNow => '立即登入';

  @override
  String get createAccount => '創建帳號';

  @override
  String get joinTableTalk => '加入TableTalk，發現更多美食';

  @override
  String get loginFailed => '登入失敗，請稍後重試';

  @override
  String get checkingLoginStatus => '正在檢查登入狀態...';

  @override
  String get authCheckFailed => '認證檢查失敗';

  @override
  String get authCheckTimeout => '認證檢查超時';

  @override
  String get invalidEmailOrPassword => '信箱或密碼錯誤';

  @override
  String get registrationFailed => '註冊失敗';

  @override
  String get logoutFailed => '登出失敗';

  @override
  String get restoreLoginFailed => '恢復登入狀態失敗';
}
