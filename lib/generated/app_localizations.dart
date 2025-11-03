import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'TableTalk'**
  String get appTitle;

  /// Application English name
  ///
  /// In en, this message translates to:
  /// **'Foodie Connect'**
  String get foodieConnect;

  /// Application Chinese name
  ///
  /// In en, this message translates to:
  /// **'TableTalk'**
  String get tableTalk;

  /// Application subtitle
  ///
  /// In en, this message translates to:
  /// **'Discover food, share experiences'**
  String get discoverFoodShareExperience;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Email input field label
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// Password input field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Display name input field label
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// Phone number input field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Email validation error message
  ///
  /// In en, this message translates to:
  /// **'Please enter email address'**
  String get pleaseEnterEmail;

  /// Email format validation error message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmail;

  /// Password validation error message
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get pleaseEnterPassword;

  /// Password length validation error message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No account prompt text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get noAccountYet;

  /// Register now link text
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// Already have account prompt text
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Login now link text
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// Create account title
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Registration page subtitle
  ///
  /// In en, this message translates to:
  /// **'Join TableTalk, discover more food'**
  String get joinTableTalk;

  /// Login failed prompt
  ///
  /// In en, this message translates to:
  /// **'Login failed, please try again later'**
  String get loginFailed;

  /// Checking login status prompt
  ///
  /// In en, this message translates to:
  /// **'Checking login status...'**
  String get checkingLoginStatus;

  /// Authentication check failed prompt
  ///
  /// In en, this message translates to:
  /// **'Authentication check failed'**
  String get authCheckFailed;

  /// Authentication check timeout prompt
  ///
  /// In en, this message translates to:
  /// **'Authentication check timeout'**
  String get authCheckTimeout;

  /// Search box prompt text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No restaurant information prompt
  ///
  /// In en, this message translates to:
  /// **'No restaurant information available'**
  String get noRestaurants;

  /// Loading failed prompt
  ///
  /// In en, this message translates to:
  /// **'Loading failed'**
  String get loadingFailed;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Business status
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Closed status
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// Basic information title
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfo;

  /// Address label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Distance prompt
  ///
  /// In en, this message translates to:
  /// **'{distance} from you'**
  String distanceFromYou(String distance);

  /// Business hours label
  ///
  /// In en, this message translates to:
  /// **'Business Hours'**
  String get businessHours;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Rating label
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Review count prompt
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String totalReviews(int count);

  /// Dish reviews title
  ///
  /// In en, this message translates to:
  /// **'Dish Reviews'**
  String get dishReviews;

  /// No reviews prompt
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviews;

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

  /// Staff reviews title
  ///
  /// In en, this message translates to:
  /// **'Staff Reviews'**
  String get staffReviews;

  /// No staff information prompt
  ///
  /// In en, this message translates to:
  /// **'No staff information available'**
  String get noStaffInfo;

  /// View all staff button
  ///
  /// In en, this message translates to:
  /// **'View All Staff'**
  String get viewAllStaff;

  /// Experience label
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// Restaurant images title
  ///
  /// In en, this message translates to:
  /// **'Restaurant Images'**
  String get restaurantImages;

  /// Average price title
  ///
  /// In en, this message translates to:
  /// **'Average Price'**
  String get averagePrice;

  /// Recommended dishes title
  ///
  /// In en, this message translates to:
  /// **'Recommended Dishes'**
  String get recommendedDishes;

  /// Loading prompt
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Menu title
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// View full menu text
  ///
  /// In en, this message translates to:
  /// **'View Full Menu'**
  String get viewFullMenu;

  /// View menu button
  ///
  /// In en, this message translates to:
  /// **'View Menu'**
  String get viewMenu;

  /// Menu feature in development prompt
  ///
  /// In en, this message translates to:
  /// **'Menu feature in development'**
  String get menuFeatureInDevelopment;

  /// Failed to get menu prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to get menu'**
  String get getMenuFailed;

  /// Failed to get shop information prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to get shop information'**
  String get getShopInfoFailed;

  /// User comments title
  ///
  /// In en, this message translates to:
  /// **'User Comments'**
  String get userComments;

  /// Publish review button
  ///
  /// In en, this message translates to:
  /// **'Publish Review'**
  String get publishReview;

  /// Rating label
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingScore;

  /// Review content label
  ///
  /// In en, this message translates to:
  /// **'Review Content'**
  String get reviewContent;

  /// Review content input box prompt
  ///
  /// In en, this message translates to:
  /// **'Share your dining experience...'**
  String get shareDiningExperience;

  /// Add images title
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get addImages;

  /// Take photo button
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// Gallery button
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get selectFromGallery;

  /// Select from album text
  ///
  /// In en, this message translates to:
  /// **'Select from Album'**
  String get selectFromAlbum;

  /// Add image prompt
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get addImage;

  /// Publish button
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// Restaurant information invalid prompt
  ///
  /// In en, this message translates to:
  /// **'Restaurant information is invalid'**
  String get restaurantInfoInvalid;

  /// Please enter review content prompt
  ///
  /// In en, this message translates to:
  /// **'Please enter review content'**
  String get pleaseEnterReviewContent;

  /// Review published prompt
  ///
  /// In en, this message translates to:
  /// **'Review published'**
  String get reviewPublished;

  /// Publish failed prompt
  ///
  /// In en, this message translates to:
  /// **'Publish failed'**
  String get publishFailed;

  /// Failed to take photo prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to take photo'**
  String get takePhotoFailed;

  /// Failed to select image prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to select image'**
  String get selectImageFailed;

  /// Staff list title
  ///
  /// In en, this message translates to:
  /// **'Staff List'**
  String get staffList;

  /// Failed to get staff list prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to get staff list'**
  String get getStaffListFailed;

  /// No staff information prompt
  ///
  /// In en, this message translates to:
  /// **'No staff information available'**
  String get noStaff;

  /// Staff details title
  ///
  /// In en, this message translates to:
  /// **'Staff Details'**
  String get staffDetails;

  /// Staff information does not exist prompt
  ///
  /// In en, this message translates to:
  /// **'Staff information does not exist'**
  String get staffInfoNotExists;

  /// Failed to get staff details prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to get staff details'**
  String get getStaffDetailsFailed;

  /// Failed to load staff reviews prompt
  ///
  /// In en, this message translates to:
  /// **'Failed to load staff reviews'**
  String get loadStaffReviewsFailed;

  /// User reviews title
  ///
  /// In en, this message translates to:
  /// **'User Reviews'**
  String get userReviews;

  /// Review count
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String reviewCount(int count);

  /// Shop features title
  ///
  /// In en, this message translates to:
  /// **'Shop Features'**
  String get shopFeatures;

  /// View comments feature title
  ///
  /// In en, this message translates to:
  /// **'View Comments'**
  String get viewComments;

  /// View user reviews description
  ///
  /// In en, this message translates to:
  /// **'View User Reviews'**
  String get viewUserReviews;

  /// Instant chat feature title
  ///
  /// In en, this message translates to:
  /// **'Instant Chat'**
  String get instantChat;

  /// Chat with staff in real-time description
  ///
  /// In en, this message translates to:
  /// **'Chat with staff in real-time'**
  String get chatWithStaffRealtime;

  /// View staff feature title
  ///
  /// In en, this message translates to:
  /// **'View Staff'**
  String get viewStaff;

  /// Online staff list description
  ///
  /// In en, this message translates to:
  /// **'Online Staff List'**
  String get onlineStaffList;

  /// View menu feature title
  ///
  /// In en, this message translates to:
  /// **'View Menu'**
  String get viewMenuDishes;

  /// Browse all dishes description
  ///
  /// In en, this message translates to:
  /// **'Browse all dishes'**
  String get browseAllDishes;

  /// Chat title
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

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

  /// Select language title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language settings title
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Current language label
  ///
  /// In en, this message translates to:
  /// **'Current Language'**
  String get currentLanguage;

  /// Account settings title
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Privacy settings
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacy;

  /// Notification settings
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notifications;

  /// About
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Are you sure you want to log out prompt
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get sureLogout;

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

  /// Error message shown to user
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get invalidEmailOrPassword;

  /// Prefix when registration throws
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// Error message shown to user
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;

  /// Error message shown to user
  ///
  /// In en, this message translates to:
  /// **'Failed to restore login status'**
  String get restoreLoginFailed;

  /// Error message shown to user
  ///
  /// In en, this message translates to:
  /// **'Update failed, please try again later'**
  String get updateFailed;

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

  /// Hint when RestaurantService.list throws
  ///
  /// In en, this message translates to:
  /// **'Failed to load restaurants: {error}'**
  String loadRestaurantFail(String error);

  /// Error hint when listByRestaurant throws
  ///
  /// In en, this message translates to:
  /// **'Failed to load reviews: {error}'**
  String loadReviewFail(String error);

  /// Error hint when postReview/postWithImages/postWithImageFiles throws
  ///
  /// In en, this message translates to:
  /// **'Failed to post review: {error}'**
  String postReviewFail(String error);

  /// Error when listByRestaurant throws
  ///
  /// In en, this message translates to:
  /// **'Failed to load staff list: {error}'**
  String loadStaffFail(String error);

  /// Error when getById throws
  ///
  /// In en, this message translates to:
  /// **'Failed to load staff details: {error}'**
  String loadStaffDetailFail(String error);

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

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
