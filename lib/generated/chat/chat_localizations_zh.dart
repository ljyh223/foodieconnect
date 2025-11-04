// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ChatLocalizationsZh extends ChatLocalizations {
  ChatLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get chatRoom => '聊天室';

  @override
  String get chatWithStaff => '与店员实时沟通，了解更多详情';

  @override
  String get enterChatRoom => '进入聊天室';

  @override
  String get restaurantChatVerification => '餐厅聊天验证';

  @override
  String get enterRestaurantIdAndCode => '请输入餐厅ID和验证码以加入聊天室';

  @override
  String get verificationCode => '验证码';

  @override
  String get pleaseEnterVerificationCode => '请填写验证码';

  @override
  String get verificationFailed => '验证失败，请检查餐厅ID和验证码';

  @override
  String verificationError(String error) {
    return '验证失败：$error';
  }

  @override
  String get verifyAndStartChat => '验证并开始聊天';

  @override
  String get pleaseVerifyFirst => '请先通过验证界面加入聊天室';

  @override
  String get staffChatFeatureMoved => '店员聊天功能已迁移至餐厅聊天室';

  @override
  String get restaurantChatRoom => '餐厅聊天室';

  @override
  String get initializeChatRoomFailed => '初始化聊天室失败';

  @override
  String initializeChatRoomError(String error) {
    return '初始化聊天室失败: $error';
  }

  @override
  String get noAvailableChatRoom => '当前无可用聊天室';

  @override
  String get noMessagesStartChat => '暂无消息，开始聊天吧！';

  @override
  String get websocketNotConnected => 'WebSocket未连接';

  @override
  String get connected => '已连接';

  @override
  String get disconnected => '未连接';

  @override
  String get enterMessage => '输入消息...';

  @override
  String get newMessages => '新消息';

  @override
  String get chat => '聊天';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String dateFormatThisYear(int month, int day) {
    return '$month月$day日';
  }

  @override
  String dateFormatOtherYear(int year, int month, int day) {
    return '$year年$month月$day日';
  }

  @override
  String timeFormat(String hour, String minute) {
    return '$hour:$minute';
  }

  @override
  String stompConnectionError(String error) {
    return 'STOMP连接错误：$error';
  }

  @override
  String stompConnectFail(String error) {
    return 'STOMP WebSocket连接失败：$error';
  }

  @override
  String get websocketTimeout => 'WebSocket连接超时，请检查网络连接';

  @override
  String get verifyFailNoRoomOrToken => '验证失败：未获取到聊天室ID或临时令牌';

  @override
  String verifyRoomFail(String error) {
    return '验证聊天室失败：$error';
  }

  @override
  String joinRoomFail(String error) {
    return '加入聊天室失败：$error';
  }

  @override
  String loadMessageFail(String error) {
    return '获取消息失败：$error';
  }

  @override
  String get notConnectedCantSend => 'STOMP WebSocket未连接，无法发送消息';

  @override
  String sendMessageFail(String error) {
    return '发送消息失败：$error';
  }

  @override
  String leaveRoomFail(String error) {
    return '离开聊天室失败：$error';
  }

  @override
  String subscribeNotificationFail(String error) {
    return '订阅通知失败：$error';
  }

  @override
  String get stompNotConnected => '未连接，请等待 WebSocket 完成连接';

  @override
  String stompConnectFailed(String error) {
    return 'WebSocket 连接失败：$error';
  }

  @override
  String get stompConnected => '已连接';

  @override
  String get stompDisconnected => '连接已断开';

  @override
  String get msgParseFailed => '解析消息失败';

  @override
  String get notificationParseFailed => '解析通知失败';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class ChatLocalizationsZhTw extends ChatLocalizationsZh {
  ChatLocalizationsZhTw() : super('zh_TW');

  @override
  String get chatRoom => '聊天室';

  @override
  String get chatWithStaff => '與店員即時溝通，了解更多詳情';

  @override
  String get enterChatRoom => '進入聊天室';

  @override
  String get restaurantChatVerification => '餐廳聊天驗證';

  @override
  String get enterRestaurantIdAndCode => '請輸入餐廳ID和驗證碼以加入聊天室';

  @override
  String get verificationCode => '驗證碼';

  @override
  String get pleaseEnterVerificationCode => '請填寫驗證碼';

  @override
  String get verificationFailed => '驗證失敗，請檢查餐廳ID和驗證碼';

  @override
  String verificationError(String error) {
    return '驗證失敗：$error';
  }

  @override
  String get verifyAndStartChat => '驗證並開始聊天';

  @override
  String get pleaseVerifyFirst => '請先通過驗證界面加入聊天室';

  @override
  String get staffChatFeatureMoved => '店員聊天功能已遷移至餐廳聊天室';

  @override
  String get restaurantChatRoom => '餐廳聊天室';

  @override
  String get initializeChatRoomFailed => '初始化聊天室失敗';

  @override
  String initializeChatRoomError(String error) {
    return '初始化聊天室失敗: $error';
  }

  @override
  String get noAvailableChatRoom => '當前無可用聊天室';

  @override
  String get noMessagesStartChat => '暫無消息，開始聊天吧！';

  @override
  String get websocketNotConnected => 'WebSocket未連接';

  @override
  String get connected => '已連接';

  @override
  String get disconnected => '未連接';

  @override
  String get enterMessage => '輸入消息...';

  @override
  String get newMessages => '新消息';

  @override
  String get chat => '聊天';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String dateFormatThisYear(int month, int day) {
    return '$month月$day日';
  }

  @override
  String dateFormatOtherYear(int year, int month, int day) {
    return '$year年$month月$day日';
  }

  @override
  String timeFormat(String hour, String minute) {
    return '$hour:$minute';
  }

  @override
  String stompConnectionError(String error) {
    return 'STOMP連線錯誤：$error';
  }

  @override
  String stompConnectFail(String error) {
    return 'STOMP WebSocket連線失敗：$error';
  }

  @override
  String get websocketTimeout => 'WebSocket連線逾時，請檢查網路連線';

  @override
  String get verifyFailNoRoomOrToken => '驗證失敗：未取得聊天室ID或臨時令牌';

  @override
  String verifyRoomFail(String error) {
    return '驗證聊天室失敗：$error';
  }

  @override
  String joinRoomFail(String error) {
    return '加入聊天室失敗：$error';
  }

  @override
  String loadMessageFail(String error) {
    return '取得訊息失敗：$error';
  }

  @override
  String get notConnectedCantSend => 'STOMP WebSocket未連線，無法發送訊息';

  @override
  String sendMessageFail(String error) {
    return '發送訊息失敗：$error';
  }

  @override
  String leaveRoomFail(String error) {
    return '離開聊天室失敗：$error';
  }

  @override
  String subscribeNotificationFail(String error) {
    return '訂閱通知失敗：$error';
  }

  @override
  String get stompNotConnected => '未連線，請等待 WebSocket 完成連線';

  @override
  String stompConnectFailed(String error) {
    return 'WebSocket 連線失敗：$error';
  }

  @override
  String get stompConnected => '已連線';

  @override
  String get stompDisconnected => '連線已斷開';

  @override
  String get msgParseFailed => '解析訊息失敗';

  @override
  String get notificationParseFailed => '解析通知失敗';
}
