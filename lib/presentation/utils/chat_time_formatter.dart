/// 聊天时间格式化工具类
class ChatTimeFormatter {
  /// 格式化时间分隔线显示
  static String formatDateForSeparator(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      // 今天显示时间
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      // 昨天
      return '昨天 ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (now.year == dateTime.year) {
      // 今年显示月日
      return '${dateTime.month}月${dateTime.day}日';
    } else {
      // 其他年份显示年月日
      return '${dateTime.year}年${dateTime.month}月${dateTime.day}日';
    }
  }
}