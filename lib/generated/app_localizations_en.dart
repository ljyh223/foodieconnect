// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TableTalk';

  @override
  String get foodieConnect => 'Foodie Connect';

  @override
  String get tableTalk => 'TableTalk';

  @override
  String get discoverFoodShareExperience => 'Discover food, share experiences';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get displayName => 'Display Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get pleaseEnterEmail => 'Please enter email address';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email address';

  @override
  String get pleaseEnterPassword => 'Please enter password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get noAccountYet => 'Don\'t have an account yet?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Login Now';

  @override
  String get createAccount => 'Create Account';

  @override
  String get joinTableTalk => 'Join TableTalk, discover more food';

  @override
  String get loginFailed => 'Login failed, please try again later';

  @override
  String get checkingLoginStatus => 'Checking login status...';

  @override
  String get authCheckFailed => 'Authentication check failed';

  @override
  String get authCheckTimeout => 'Authentication check timeout';

  @override
  String get search => 'Search';

  @override
  String get noRestaurants => 'No restaurant information available';

  @override
  String get loadingFailed => 'Loading failed';

  @override
  String get retry => 'Retry';

  @override
  String get open => 'Open';

  @override
  String get closed => 'Closed';

  @override
  String get basicInfo => 'Basic Information';

  @override
  String get address => 'Address';

  @override
  String distanceFromYou(String distance) {
    return '$distance from you';
  }

  @override
  String get businessHours => 'Business Hours';

  @override
  String get phone => 'Phone';

  @override
  String get rating => 'Rating';

  @override
  String totalReviews(int count) {
    return '$count reviews';
  }

  @override
  String get dishReviews => 'Dish Reviews';

  @override
  String get noReviews => 'No reviews yet';

  @override
  String get chatRoom => 'Chat Room';

  @override
  String get chatWithStaff => 'Chat with staff in real-time for more details';

  @override
  String get enterChatRoom => 'Enter Chat Room';

  @override
  String get staffReviews => 'Staff Reviews';

  @override
  String get noStaffInfo => 'No staff information available';

  @override
  String get viewAllStaff => 'View All Staff';

  @override
  String get experience => 'Experience';

  @override
  String get restaurantImages => 'Restaurant Images';

  @override
  String get averagePrice => 'Average Price';

  @override
  String get recommendedDishes => 'Recommended Dishes';

  @override
  String get loading => 'Loading...';

  @override
  String get menu => 'Menu';

  @override
  String get viewFullMenu => 'View Full Menu';

  @override
  String get viewMenu => 'View Menu';

  @override
  String get menuFeatureInDevelopment => 'Menu feature in development';

  @override
  String get getMenuFailed => 'Failed to get menu';

  @override
  String get getShopInfoFailed => 'Failed to get shop information';

  @override
  String get userComments => 'User Comments';

  @override
  String get publishReview => 'Publish Review';

  @override
  String get ratingScore => 'Rating';

  @override
  String get reviewContent => 'Review Content';

  @override
  String get shareDiningExperience => 'Share your dining experience...';

  @override
  String get addImages => 'Add Images';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get selectFromGallery => 'Gallery';

  @override
  String get selectFromAlbum => 'Select from Album';

  @override
  String get addImage => 'Add Image';

  @override
  String get publish => 'Publish';

  @override
  String get restaurantInfoInvalid => 'Restaurant information is invalid';

  @override
  String get pleaseEnterReviewContent => 'Please enter review content';

  @override
  String get reviewPublished => 'Review published';

  @override
  String get publishFailed => 'Publish failed';

  @override
  String get takePhotoFailed => 'Failed to take photo';

  @override
  String get selectImageFailed => 'Failed to select image';

  @override
  String get staffList => 'Staff List';

  @override
  String get getStaffListFailed => 'Failed to get staff list';

  @override
  String get noStaff => 'No staff information available';

  @override
  String get staffDetails => 'Staff Details';

  @override
  String get staffInfoNotExists => 'Staff information does not exist';

  @override
  String get getStaffDetailsFailed => 'Failed to get staff details';

  @override
  String get loadStaffReviewsFailed => 'Failed to load staff reviews';

  @override
  String get userReviews => 'User Reviews';

  @override
  String reviewCount(int count) {
    return '$count reviews';
  }

  @override
  String get shopFeatures => 'Shop Features';

  @override
  String get viewComments => 'View Comments';

  @override
  String get viewUserReviews => 'View User Reviews';

  @override
  String get instantChat => 'Instant Chat';

  @override
  String get chatWithStaffRealtime => 'Chat with staff in real-time';

  @override
  String get viewStaff => 'View Staff';

  @override
  String get onlineStaffList => 'Online Staff List';

  @override
  String get viewMenuDishes => 'View Menu';

  @override
  String get browseAllDishes => 'Browse all dishes';

  @override
  String get chat => 'Chat';

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
  String get selectLanguage => 'Select Language';

  @override
  String get close => 'Close';

  @override
  String get settings => 'Settings';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get currentLanguage => 'Current Language';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get profile => 'Profile';

  @override
  String get privacy => 'Privacy Settings';

  @override
  String get notifications => 'Notification Settings';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get logout => 'Logout';

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
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get restoreLoginFailed => 'Failed to restore login status';

  @override
  String get updateFailed => 'Update failed, please try again later';

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
  String loadRestaurantFail(String error) {
    return 'Failed to load restaurants: $error';
  }

  @override
  String loadReviewFail(String error) {
    return 'Failed to load reviews: $error';
  }

  @override
  String postReviewFail(String error) {
    return 'Failed to post review: $error';
  }

  @override
  String loadStaffFail(String error) {
    return 'Failed to load staff list: $error';
  }

  @override
  String loadStaffDetailFail(String error) {
    return 'Failed to load staff details: $error';
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
