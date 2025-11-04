// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'staff_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class StaffLocalizationsZh extends StaffLocalizations {
  StaffLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get staffReviews => '店员评价';

  @override
  String get noStaffInfo => '暂无店员信息';

  @override
  String get viewAllStaff => '查看所有店员';

  @override
  String get experience => '经验';

  @override
  String get staffList => '店员列表';

  @override
  String get getStaffListFailed => '获取店员列表失败';

  @override
  String get noStaff => '暂无店员信息';

  @override
  String get staffDetails => '店员详情';

  @override
  String get staffInfoNotExists => '店员信息不存在';

  @override
  String get getStaffDetailsFailed => '获取店员详情失败';

  @override
  String get loadStaffReviewsFailed => '加载店员评价失败';

  @override
  String loadStaffFail(String error) {
    return '获取店员失败：$error';
  }

  @override
  String loadStaffDetailFail(String error) {
    return '获取店员详情失败：$error';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class StaffLocalizationsZhTw extends StaffLocalizationsZh {
  StaffLocalizationsZhTw() : super('zh_TW');

  @override
  String get staffReviews => '店員評價';

  @override
  String get noStaffInfo => '暫無店員信息';

  @override
  String get viewAllStaff => '查看所有店員';

  @override
  String get experience => '經驗';

  @override
  String get staffList => '店員列表';

  @override
  String get getStaffListFailed => '獲取店員列表失敗';

  @override
  String get noStaff => '暫無店員信息';

  @override
  String get staffDetails => '店員詳情';

  @override
  String get staffInfoNotExists => '店員信息不存在';

  @override
  String get getStaffDetailsFailed => '獲取店員詳情失敗';

  @override
  String get loadStaffReviewsFailed => '載入店員評價失敗';

  @override
  String loadStaffFail(String error) {
    return '取得店員失敗：$error';
  }

  @override
  String loadStaffDetailFail(String error) {
    return '取得店員詳情失敗：$error';
  }
}
