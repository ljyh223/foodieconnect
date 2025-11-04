// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'chat_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ChatLocalizationsEn extends ChatLocalizations {
  ChatLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get chatRoom => 'Chat Room';

  @override
  String get chatWithStaff => 'Chat with staff in real-time for more details';

  @override
  String get enterChatRoom => 'Enter Chat Room';

  @override
  String get restaurantChatVerification => 'Restaurant Chat Verification';

  @override
  String get enterRestaurantIdAndCode =>
      'Please enter restaurant ID and verification code to join the chat room';

  @override
  String get verificationCode => 'Verification Code';

  @override
  String get pleaseEnterVerificationCode => 'Please enter verification code';

  @override
  String get verificationFailed =>
      'Verification failed, please check restaurant ID and verification code';

  @override
  String verificationError(String error) {
    return 'Verification failed: $error';
  }

  @override
  String get verifyAndStartChat => 'Verify and Start Chat';

  @override
  String get pleaseVerifyFirst =>
      'Please join the chat room through the verification interface first';

  @override
  String get staffChatFeatureMoved =>
      'Staff chat feature has been moved to restaurant chat room';

  @override
  String get restaurantChatRoom => 'Restaurant Chat Room';

  @override
  String get initializeChatRoomFailed => 'Failed to initialize chat room';

  @override
  String initializeChatRoomError(String error) {
    return 'Failed to initialize chat room: $error';
  }

  @override
  String get noAvailableChatRoom => 'No available chat room currently';

  @override
  String get noMessagesStartChat => 'No messages yet, start chatting!';

  @override
  String get websocketNotConnected => 'WebSocket not connected';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get enterMessage => 'Enter message...';

  @override
  String get newMessages => 'New Messages';

  @override
  String get chat => 'Chat';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String dateFormatThisYear(int month, int day) {
    return '$month/$day';
  }

  @override
  String dateFormatOtherYear(int year, int month, int day) {
    return '$year/$month/$day';
  }

  @override
  String timeFormat(String hour, String minute) {
    return '$hour:$minute';
  }

  @override
  String stompConnectionError(String error) {
    return 'STOMP connection error：$error';
  }

  @override
  String stompConnectFail(String error) {
    return 'STOMP WebSocket connection failed：$error';
  }

  @override
  String get websocketTimeout =>
      'WebSocket connection timeout，please check network';

  @override
  String get verifyFailNoRoomOrToken =>
      'Verification failed：roomId or tempToken missing';

  @override
  String verifyRoomFail(String error) {
    return 'Verify room failed：$error';
  }

  @override
  String joinRoomFail(String error) {
    return 'Join room failed：$error';
  }

  @override
  String loadMessageFail(String error) {
    return 'Load messages failed：$error';
  }

  @override
  String get notConnectedCantSend =>
      'STOMP WebSocket not connected，can not send message';

  @override
  String sendMessageFail(String error) {
    return 'Send message failed：$error';
  }

  @override
  String leaveRoomFail(String error) {
    return 'Leave room failed：$error';
  }

  @override
  String subscribeNotificationFail(String error) {
    return 'Subscribe notification failed：$error';
  }

  @override
  String get stompNotConnected =>
      'Not connected, please wait for WebSocket to complete';

  @override
  String stompConnectFailed(String error) {
    return 'WebSocket connection failed: $error';
  }

  @override
  String get stompConnected => 'Connected';

  @override
  String get stompDisconnected => 'Disconnected';

  @override
  String get msgParseFailed => 'Failed to parse message';

  @override
  String get notificationParseFailed => 'Failed to parse notification';
}
