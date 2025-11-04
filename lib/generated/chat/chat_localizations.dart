import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'chat_localizations_en.dart';
import 'chat_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ChatLocalizations
/// returned by `ChatLocalizations.of(context)`.
///
/// Applications need to include `ChatLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'chat/chat_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChatLocalizations.localizationsDelegates,
///   supportedLocales: ChatLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ChatLocalizations.supportedLocales
/// property.
abstract class ChatLocalizations {
  ChatLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChatLocalizations? of(BuildContext context) {
    return Localizations.of<ChatLocalizations>(context, ChatLocalizations);
  }

  static const LocalizationsDelegate<ChatLocalizations> delegate =
      _ChatLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// Chat room title
  ///
  /// In en, this message translates to:
  /// **'Chat Room'**
  String get chatRoom;

  /// Chat room description
  ///
  /// In en, this message translates to:
  /// **'Chat with staff in real-time for more details'**
  String get chatWithStaff;

  /// Enter chat room button
  ///
  /// In en, this message translates to:
  /// **'Enter Chat Room'**
  String get enterChatRoom;

  /// Restaurant chat verification title
  ///
  /// In en, this message translates to:
  /// **'Restaurant Chat Verification'**
  String get restaurantChatVerification;

  /// Enter restaurant ID and verification code prompt
  ///
  /// In en, this message translates to:
  /// **'Please enter restaurant ID and verification code to join the chat room'**
  String get enterRestaurantIdAndCode;

  /// Verification code label
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// Please enter verification code prompt
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get pleaseEnterVerificationCode;

  /// Verification failed prompt
  ///
  /// In en, this message translates to:
  /// **'Verification failed, please check restaurant ID and verification code'**
  String get verificationFailed;

  /// Verification error prompt
  ///
  /// In en, this message translates to:
  /// **'Verification failed: {error}'**
  String verificationError(String error);

  /// Verify and start chat button
  ///
  /// In en, this message translates to:
  /// **'Verify and Start Chat'**
  String get verifyAndStartChat;

  /// Please verify first prompt
  ///
  /// In en, this message translates to:
  /// **'Please join the chat room through the verification interface first'**
  String get pleaseVerifyFirst;

  /// Staff chat feature moved prompt
  ///
  /// In en, this message translates to:
  /// **'Staff chat feature has been moved to restaurant chat room'**
  String get staffChatFeatureMoved;

  /// Restaurant chat room name
  ///
  /// In en, this message translates to:
  /// **'Restaurant Chat Room'**
  String get restaurantChatRoom;

  /// Failed to initialize chat room prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize chat room'**
  String get initializeChatRoomFailed;

  /// Failed to initialize chat room error prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize chat room: {error}'**
  String initializeChatRoomError(String error);

  /// No available chat room prompt
  ///
  /// In en, this message translates to:
  /// **'No available chat room currently'**
  String get noAvailableChatRoom;

  /// No messages prompt
  ///
  /// In en, this message translates to:
  /// **'No messages yet, start chatting!'**
  String get noMessagesStartChat;

  /// WebSocket not connected prompt
  ///
  /// In en, this message translates to:
  /// **'WebSocket not connected'**
  String get websocketNotConnected;

  /// Connected status
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// Disconnected status
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// Enter message prompt
  ///
  /// In en, this message translates to:
  /// **'Enter message...'**
  String get enterMessage;

  /// New messages prompt
  ///
  /// In en, this message translates to:
  /// **'New Messages'**
  String get newMessages;

  /// Chat title
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// Label for today in chat time separator
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Label for yesterday in chat time separator
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Date format when message is from this year
  ///
  /// In en, this message translates to:
  /// **'{month}/{day}'**
  String dateFormatThisYear(int month, int day);

  /// Date format when message is from another year
  ///
  /// In en, this message translates to:
  /// **'{year}/{month}/{day}'**
  String dateFormatOtherYear(int year, int month, int day);

  /// Time format used after today/yesterday labels
  ///
  /// In en, this message translates to:
  /// **'{hour}:{minute}'**
  String timeFormat(String hour, String minute);

  /// Error hint when STOMP connection fails
  ///
  /// In en, this message translates to:
  /// **'STOMP connection error：{error}'**
  String stompConnectionError(String error);

  /// Toast when initial connect throws
  ///
  /// In en, this message translates to:
  /// **'STOMP WebSocket connection failed：{error}'**
  String stompConnectFail(String error);

  /// Hint when waiting for connection timeout
  ///
  /// In en, this message translates to:
  /// **'WebSocket connection timeout，please check network'**
  String get websocketTimeout;

  /// Hint when back-end does not return roomId/tempToken
  ///
  /// In en, this message translates to:
  /// **'Verification failed：roomId or tempToken missing'**
  String get verifyFailNoRoomOrToken;

  /// Toast when verifyChatRoom API throws
  ///
  /// In en, this message translates to:
  /// **'Verify room failed：{error}'**
  String verifyRoomFail(String error);

  /// Toast when STOMP joinRoom throws
  ///
  /// In en, this message translates to:
  /// **'Join room failed：{error}'**
  String joinRoomFail(String error);

  /// Toast when fetchMessages API throws
  ///
  /// In en, this message translates to:
  /// **'Load messages failed：{error}'**
  String loadMessageFail(String error);

  /// Toast when sendMessage but socket disconnected
  ///
  /// In en, this message translates to:
  /// **'STOMP WebSocket not connected，can not send message'**
  String get notConnectedCantSend;

  /// Toast when sendMessage API throws
  ///
  /// In en, this message translates to:
  /// **'Send message failed：{error}'**
  String sendMessageFail(String error);

  /// Toast when leaveRoom API throws
  ///
  /// In en, this message translates to:
  /// **'Leave room failed：{error}'**
  String leaveRoomFail(String error);

  /// Toast when subscribeToNotifications throws
  ///
  /// In en, this message translates to:
  /// **'Subscribe notification failed：{error}'**
  String subscribeNotificationFail(String error);

  /// Thrown when send/join is called before connected
  ///
  /// In en, this message translates to:
  /// **'Not connected, please wait for WebSocket to complete'**
  String get stompNotConnected;

  /// Connection exception text pushed to connectionStateController
  ///
  /// In en, this message translates to:
  /// **'WebSocket connection failed: {error}'**
  String stompConnectFailed(String error);

  /// No description provided for @stompConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get stompConnected;

  /// No description provided for @stompDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get stompDisconnected;

  /// No description provided for @msgParseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse message'**
  String get msgParseFailed;

  /// No description provided for @notificationParseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse notification'**
  String get notificationParseFailed;
}

class _ChatLocalizationsDelegate
    extends LocalizationsDelegate<ChatLocalizations> {
  const _ChatLocalizationsDelegate();

  @override
  Future<ChatLocalizations> load(Locale locale) {
    return SynchronousFuture<ChatLocalizations>(
      lookupChatLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_ChatLocalizationsDelegate old) => false;
}

ChatLocalizations lookupChatLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return ChatLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ChatLocalizationsEn();
    case 'zh':
      return ChatLocalizationsZh();
  }

  throw FlutterError(
    'ChatLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
