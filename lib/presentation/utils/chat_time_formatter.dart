import '../../core/services/localization_service.dart';

class ChatTimeFormatter {
  /// 格式化时间分隔线显示
  static String formatDateForSeparator(DateTime dateTime) {
    final loc = LocalizationService.I;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);


    if (messageDate == today) {
      // 今天
      return loc.timeFormat(dateTime.hour.toString().padLeft(2, '0'),dateTime.minute.toString().padLeft(2, '0'));
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // 昨天
      return '${loc.yesterday} ${loc.timeFormat(dateTime.hour.toString().padLeft(2, '0'),dateTime.minute.toString().padLeft(2, '0'))}';
    } else if (now.year == dateTime.year) {
      // 今年
      return loc.dateFormatThisYear(dateTime.month, dateTime.day);
    } else {
      // 其他年份
      return loc.dateFormatOtherYear(
          dateTime.year, dateTime.month, dateTime.day);
    }
  }
}
