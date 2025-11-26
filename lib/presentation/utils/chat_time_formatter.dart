import 'package:tabletalk/generated/translations.g.dart';



class ChatTimeFormatter {
  /// 格式化时间分隔线显示
  static String formatDateForSeparator(DateTime dateTime) {
    final loc = t.chat;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);


    if (messageDate == today) {
      // 今天
      return loc.timeFormat(hour: dateTime.hour.toString().padLeft(2, '0'),minute: dateTime.minute.toString().padLeft(2, '0'),);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // 昨天
      return '${loc.yesterday} ${loc.timeFormat(hour: dateTime.hour.toString().padLeft(2, '0'),minute: dateTime.minute.toString().padLeft(2, '0'))}';
    } else if (now.year == dateTime.year) {
      // 今年
      return loc.dateFormatThisYear(month: dateTime.month, day: dateTime.day);
    } else {
      // 其他年份
      return loc.dateFormatOtherYear(
          year: dateTime.year, month: dateTime.month, day: dateTime.day);
    }
  }
}
