// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'TableTalk';

  @override
  String get foodieConnect => 'Foodie Connect';

  @override
  String get tableTalk => 'TableTalk';

  @override
  String get discoverFoodShareExperience => '发现美食，分享体验';

  @override
  String get search => '搜索';

  @override
  String get loading => '加载中...';

  @override
  String get loadingFailed => '加载失败';

  @override
  String get retry => '重试';

  @override
  String get open => '营业中';

  @override
  String get closed => '已打烊';

  @override
  String get userProfile => '个人主页';

  @override
  String get otherUserProfile => '用户主页';

  @override
  String get followingList => '关注列表';

  @override
  String get myFollowing => '我的关注';

  @override
  String get connect => 'Connect';

  @override
  String get follow => '关注';

  @override
  String get following => '已关注';

  @override
  String get unfollow => '取消关注';

  @override
  String unfollowConfirm(Object username) {
    return '确定要取消关注 $username 吗？';
  }

  @override
  String get foodPreferences => '喜好食物';

  @override
  String get noFoodPreferences => '暂无喜好食物信息';

  @override
  String get personalBio => '个人简介';

  @override
  String get noBio => '这个人很懒，什么都没有留下...';

  @override
  String get recommendedRestaurants => '推荐餐厅';

  @override
  String get noRecommendedRestaurants => '暂无推荐餐厅';

  @override
  String get noFollowing => '暂无关注';

  @override
  String get discoverUsers => '去发现感兴趣的用户吧';

  @override
  String get save => '保存';

  @override
  String get edit => '编辑';

  @override
  String get saveSuccess => '保存成功';

  @override
  String get saveFailed => '保存失败';

  @override
  String get followSuccess => '关注成功';

  @override
  String get followFailed => '关注失败';

  @override
  String get unfollowSuccess => '已取消关注';

  @override
  String get unfollowFailed => '取消关注失败';

  @override
  String get userNotFound => '用户不存在';

  @override
  String get unknownUser => '未知用户';

  @override
  String get introduceYourself => '介绍一下自己...';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => 'TableTalk';

  @override
  String get foodieConnect => 'Foodie Connect';

  @override
  String get tableTalk => 'TableTalk';

  @override
  String get discoverFoodShareExperience => '發現美食，分享體驗';

  @override
  String get search => '搜尋';

  @override
  String get loading => '載入中...';

  @override
  String get loadingFailed => '載入失敗';

  @override
  String get retry => '重試';

  @override
  String get open => '營業中';

  @override
  String get closed => '已打烊';

  @override
  String get userProfile => '個人資料';

  @override
  String get otherUserProfile => '使用者資料';

  @override
  String get followingList => '追蹤列表';

  @override
  String get myFollowing => '我的追蹤';

  @override
  String get connect => '連接';

  @override
  String get follow => '追蹤';

  @override
  String get following => '已追蹤';

  @override
  String get unfollow => '取消追蹤';

  @override
  String unfollowConfirm(Object username) {
    return '確定要取消追蹤 $username 嗎？';
  }

  @override
  String get foodPreferences => '飲食偏好';

  @override
  String get noFoodPreferences => '無飲食偏好';

  @override
  String get personalBio => '個人簡介';

  @override
  String get noBio => '這個人太懶了，什麼都沒留下……';

  @override
  String get recommendedRestaurants => '推薦餐廳';

  @override
  String get noRecommendedRestaurants => '無推薦餐廳';

  @override
  String get noFollowing => '尚未追蹤任何人';

  @override
  String get discoverUsers => '快去探索有趣的使用者吧！';

  @override
  String get save => '儲存';

  @override
  String get edit => '編輯';

  @override
  String get saveSuccess => '儲存成功';

  @override
  String get saveFailed => '儲存失敗';

  @override
  String get followSuccess => '追蹤成功';

  @override
  String get followFailed => '追蹤失敗';

  @override
  String get unfollowSuccess => '已取消追蹤';

  @override
  String get unfollowFailed => '取消追蹤失敗';

  @override
  String get userNotFound => '找不到該使用者';

  @override
  String get unknownUser => '未知使用者';

  @override
  String get introduceYourself => '告訴我們關於你自己的事……';
}
