// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'restaurant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class RestaurantLocalizationsZh extends RestaurantLocalizations {
  RestaurantLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get noRestaurants => '暂无餐厅信息';

  @override
  String get basicInfo => '基础信息';

  @override
  String get address => '地址';

  @override
  String distanceFromYou(String distance) {
    return '距离您$distance';
  }

  @override
  String get businessHours => '营业时间';

  @override
  String get phone => '电话';

  @override
  String get rating => '评分';

  @override
  String totalReviews(int count) {
    return '共$count条评价';
  }

  @override
  String get restaurantImages => '餐厅图片';

  @override
  String get averagePrice => '人均消费';

  @override
  String get recommendedDishes => '推荐菜品';

  @override
  String get menu => '菜单';

  @override
  String get viewFullMenu => '查看完整菜单';

  @override
  String get viewMenu => '查看菜单';

  @override
  String get menuFeatureInDevelopment => '菜单功能开发中';

  @override
  String get getMenuFailed => '获取菜单失败';

  @override
  String get getShopInfoFailed => '获取店铺信息失败';

  @override
  String get restaurantInfoInvalid => '餐厅信息无效';

  @override
  String get shopFeatures => '店铺功能';

  @override
  String get viewComments => '查看评论';

  @override
  String get viewUserReviews => '查看用户评价';

  @override
  String get instantChat => '即时聊天';

  @override
  String get chatWithStaffRealtime => '与店员实时交流';

  @override
  String get viewStaff => '查看店员';

  @override
  String get onlineStaffList => '在线店员列表';

  @override
  String get viewMenuDishes => '查看菜单';

  @override
  String get browseAllDishes => '浏览所有菜品';

  @override
  String loadRestaurantFail(String error) {
    return '获取餐厅失败：$error';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class RestaurantLocalizationsZhTw extends RestaurantLocalizationsZh {
  RestaurantLocalizationsZhTw() : super('zh_TW');

  @override
  String get noRestaurants => '暫無餐廳信息';

  @override
  String get basicInfo => '基礎信息';

  @override
  String get address => '地址';

  @override
  String distanceFromYou(String distance) {
    return '距離您$distance';
  }

  @override
  String get businessHours => '營業時間';

  @override
  String get phone => '電話';

  @override
  String get rating => '評分';

  @override
  String totalReviews(int count) {
    return '共$count條評價';
  }

  @override
  String get restaurantImages => '餐廳圖片';

  @override
  String get averagePrice => '人均消費';

  @override
  String get recommendedDishes => '推薦菜品';

  @override
  String get menu => '菜單';

  @override
  String get viewFullMenu => '查看完整菜單';

  @override
  String get viewMenu => '查看菜單';

  @override
  String get menuFeatureInDevelopment => '菜單功能開發中';

  @override
  String get getMenuFailed => '獲取菜單失敗';

  @override
  String get getShopInfoFailed => '獲取店鋪信息失敗';

  @override
  String get restaurantInfoInvalid => '餐廳信息無效';

  @override
  String get shopFeatures => '店鋪功能';

  @override
  String get viewComments => '查看評論';

  @override
  String get viewUserReviews => '查看用戶評價';

  @override
  String get instantChat => '即時聊天';

  @override
  String get chatWithStaffRealtime => '與店員即時交流';

  @override
  String get viewStaff => '查看店員';

  @override
  String get onlineStaffList => '在線店員列表';

  @override
  String get viewMenuDishes => '查看菜單';

  @override
  String get browseAllDishes => '瀏覽所有菜品';

  @override
  String loadRestaurantFail(String error) {
    return '取得餐廳失敗：$error';
  }
}
