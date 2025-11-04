// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ProfileLocalizationsZh extends ProfileLocalizations {
  ProfileLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get profileTitle => '个人主页';

  @override
  String get otherProfileTitle => '用户主页';

  @override
  String get edit => '编辑';

  @override
  String get save => '保存';

  @override
  String get loading => '加载中...';

  @override
  String get loadingFailed => '加载失败';

  @override
  String get retry => '重试';

  @override
  String get userNotFound => '用户不存在';

  @override
  String get unknownUser => '未知用户';

  @override
  String get foodPreferences => '喜好食物';

  @override
  String get noFoodPreferences => '暂无喜好食物信息';

  @override
  String get personalBio => '个人简介';

  @override
  String get introduceYourself => '介绍一下自己...';

  @override
  String get connect => 'Connect';

  @override
  String get following => '已关注';

  @override
  String get saveSuccess => '保存成功';

  @override
  String saveFailed(String error) {
    return '保存失败: $error';
  }

  @override
  String get followFailed => '关注失败';

  @override
  String get unfollowFailed => '取消关注失败';

  @override
  String get recommendedRestaurants => '推荐餐厅';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class ProfileLocalizationsZhTw extends ProfileLocalizationsZh {
  ProfileLocalizationsZhTw() : super('zh_TW');

  @override
  String get profileTitle => '個人主頁';

  @override
  String get otherProfileTitle => '用戶主頁';

  @override
  String get edit => '編輯';

  @override
  String get save => '保存';

  @override
  String get loading => '載入中...';

  @override
  String get loadingFailed => '載入失敗';

  @override
  String get retry => '重試';

  @override
  String get userNotFound => '用戶不存在';

  @override
  String get unknownUser => '未知用戶';

  @override
  String get foodPreferences => '喜好食物';

  @override
  String get noFoodPreferences => '暫無喜好食物資訊';

  @override
  String get personalBio => '個人簡介';

  @override
  String get introduceYourself => '介紹一下自己...';

  @override
  String get connect => 'Connect';

  @override
  String get following => '已關注';

  @override
  String get saveSuccess => '保存成功';

  @override
  String saveFailed(String error) {
    return '保存失敗: $error';
  }

  @override
  String get followFailed => '關注失敗';

  @override
  String get unfollowFailed => '取消關注失敗';

  @override
  String get recommendedRestaurants => '推薦餐廳';
}
