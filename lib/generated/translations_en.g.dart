///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsChatEn chat = TranslationsChatEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsRestaurantEn restaurant = TranslationsRestaurantEn._(_root);
	late final TranslationsReviewEn review = TranslationsReviewEn._(_root);
	late final TranslationsSettingEn setting = TranslationsSettingEn._(_root);
	late final TranslationsStaffEn staff = TranslationsStaffEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Application title
	///
	/// en: 'FoodieConnect'
	String get appTitle => 'FoodieConnect';

	/// Application Chinese name
	///
	/// en: 'FoodieConnect'
	String get foodieConnect => 'FoodieConnect';

	/// Application subtitle
	///
	/// en: 'Discover food, share experiences'
	String get discoverFoodShareExperience => 'Discover food, share experiences';

	/// Search box prompt text
	///
	/// en: 'Search'
	String get search => 'Search';

	/// Search dishes placeholder
	///
	/// en: 'Search dishes...'
	String get searchDish => 'Search dishes...';

	/// All categories filter label
	///
	/// en: 'All'
	String get allCategories => 'All';

	/// Home tab text
	///
	/// en: 'Home'
	String get home => 'Home';

	/// Loading prompt
	///
	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// Loading failed prompt
	///
	/// en: 'Loading failed'
	String get loadingFailed => 'Loading failed';

	/// Retry button text
	///
	/// en: 'Retry'
	String get retry => 'Retry';

	/// Business status
	///
	/// en: 'Open'
	String get open => 'Open';

	/// Closed status
	///
	/// en: 'Closed'
	String get closed => 'Closed';

	/// User profile title
	///
	/// en: 'Profile'
	String get userProfile => 'Profile';

	/// Other user profile title
	///
	/// en: 'User Profile'
	String get otherUserProfile => 'User Profile';

	/// Connections list title
	///
	/// en: 'Connections'
	String get connectionsList => 'Connections';

	/// My connections title
	///
	/// en: 'My Connections'
	String get myConnections => 'My Connections';

	/// Connect button text
	///
	/// en: 'Connect'
	String get connect => 'Connect';

	/// Connected status text
	///
	/// en: 'Connected'
	String get connected => 'Connected';

	/// Button text to enter chat room in read-only mode
	///
	/// en: 'Enter Read-only Mode'
	String get enterReadOnlyMode => 'Enter Read-only Mode';

	/// Read-only mode notification
	///
	/// en: 'You are currently in read-only mode, you can only view messages, not send them'
	String get readOnlyModeNotice => 'You are currently in read-only mode, you can only view messages, not send them';

	/// Read-only mode bottom tip
	///
	/// en: 'Read-only mode: You can view messages, but cannot send'
	String get readOnlyModeTip => 'Read-only mode: You can view messages, but cannot send';

	/// Disconnect button text
	///
	/// en: 'Disconnect'
	String get disconnect => 'Disconnect';

	/// Disconnect confirmation dialog
	///
	/// en: 'Are you sure you want to disconnect from {username}?'
	String disconnectConfirm({required Object username}) => 'Are you sure you want to disconnect from ${username}?';

	/// Food preferences title
	///
	/// en: 'Food Preferences'
	String get foodPreferences => 'Food Preferences';

	/// No food preferences message
	///
	/// en: 'No food preferences'
	String get noFoodPreferences => 'No food preferences';

	/// Personal bio title
	///
	/// en: 'Personal Bio'
	String get personalBio => 'Personal Bio';

	/// No bio message
	///
	/// en: 'This person is lazy and left nothing...'
	String get noBio => 'This person is lazy and left nothing...';

	/// Recommended restaurants title
	///
	/// en: 'Recommended Restaurants'
	String get recommendedRestaurants => 'Recommended Restaurants';

	/// No recommended restaurants message
	///
	/// en: 'No recommended restaurants'
	String get noRecommendedRestaurants => 'No recommended restaurants';

	/// No connections message
	///
	/// en: 'No connections'
	String get noConnections => 'No connections';

	/// Discover users message
	///
	/// en: 'Go discover interesting users'
	String get discoverUsers => 'Go discover interesting users';

	/// Save button text
	///
	/// en: 'Save'
	String get save => 'Save';

	/// Edit button text
	///
	/// en: 'Edit'
	String get edit => 'Edit';

	/// Save success message
	///
	/// en: 'Saved successfully'
	String get saveSuccess => 'Saved successfully';

	/// Save failed message
	///
	/// en: 'Save failed'
	String get saveFailed => 'Save failed';

	/// Connect success message
	///
	/// en: 'Connected successfully'
	String get connectSuccess => 'Connected successfully';

	/// Connect failed message
	///
	/// en: 'Connect failed'
	String get connectFailed => 'Connect failed';

	/// Disconnect success message
	///
	/// en: 'Disconnected'
	String get disconnectSuccess => 'Disconnected';

	/// Disconnect failed message
	///
	/// en: 'Disconnect failed'
	String get disconnectFailed => 'Disconnect failed';

	/// User not found message
	///
	/// en: 'User not found'
	String get userNotFound => 'User not found';

	/// Unknown user text
	///
	/// en: 'Unknown User'
	String get unknownUser => 'Unknown User';

	/// Bio input placeholder
	///
	/// en: 'Tell us about yourself...'
	String get introduceYourself => 'Tell us about yourself...';

	/// Cancel button text
	///
	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// Recommendations feature title
	///
	/// en: 'Recommendations'
	String get recommendations => 'Recommendations';

	/// Recommended users title
	///
	/// en: 'Recommended Users'
	String get recommendedUsers => 'Recommended Users';

	/// View more button
	///
	/// en: 'View More'
	String get viewMore => 'View More';

	/// No recommended users message
	///
	/// en: 'No recommended users'
	String get noRecommendations => 'No recommended users';

	/// Searching recommendations message
	///
	/// en: 'The system is finding users you might be interested in'
	String get searchingRecommendations => 'The system is finding users you might be interested in';

	/// Interested status
	///
	/// en: 'Interested'
	String get interested => 'Interested';

	/// Not interested status
	///
	/// en: 'Not Interested'
	String get notInterested => 'Not Interested';

	/// Mark interested success message
	///
	/// en: 'Marked as interested'
	String get markAsInterested => 'Marked as interested';

	/// Mark not interested success message
	///
	/// en: 'Marked as not interested'
	String get markAsNotInterested => 'Marked as not interested';

	/// Recommendation score label
	///
	/// en: 'Recommendation Score'
	String get recommendationScore => 'Recommendation Score';

	/// Recommendation reason label
	///
	/// en: 'Recommendation Reason'
	String get recommendationReason => 'Recommendation Reason';

	/// Collaborative filtering recommendation reason
	///
	/// en: 'Recommended based on common preferences'
	String get collaborativeRecommendation => 'Recommended based on common preferences';

	/// Social recommendation reason
	///
	/// en: 'People you connect with also connect with them'
	String get socialRecommendation => 'People you connect with also connect with them';

	/// Hybrid recommendation reason
	///
	/// en: 'Comprehensive recommendation'
	String get hybridRecommendation => 'Comprehensive recommendation';

	/// Common interests description
	///
	/// en: 'Common interests: {interests: String}'
	String commonInterests({required String interests}) => 'Common interests: ${interests}';

	/// Common restaurant visits description
	///
	/// en: 'Visited {count: int} restaurants together'
	String commonVisits({required int count}) => 'Visited ${count} restaurants together';

	/// Filter button
	///
	/// en: 'Filter'
	String get filter => 'Filter';

	/// Sort button
	///
	/// en: 'Sort'
	String get sort => 'Sort';

	/// Filter dialog title
	///
	/// en: 'Filter Recommendations'
	String get filterByStatus => 'Filter Recommendations';

	/// Sort dialog title
	///
	/// en: 'Sort By'
	String get sortBy => 'Sort By';

	/// All option
	///
	/// en: 'All'
	String get all => 'All';

	/// Unviewed status
	///
	/// en: 'Unviewed'
	String get unviewed => 'Unviewed';

	/// Viewed status
	///
	/// en: 'Viewed'
	String get viewed => 'Viewed';

	/// Sort by score
	///
	/// en: 'Recommendation Score'
	String get sortByScore => 'Recommendation Score';

	/// Sort by time
	///
	/// en: 'Creation Time'
	String get sortByTime => 'Creation Time';

	/// Sort by view time
	///
	/// en: 'View Time'
	String get sortByViewTime => 'View Time';

	/// Clear recommendations button
	///
	/// en: 'Clear All Recommendations'
	String get clearAllRecommendations => 'Clear All Recommendations';

	/// Clear recommendations confirmation dialog content
	///
	/// en: 'Are you sure you want to clear all recommendations? This action cannot be undone.'
	String get clearAllConfirm => 'Are you sure you want to clear all recommendations? This action cannot be undone.';

	/// Total recommendations count
	///
	/// en: '{count: int} recommendations total'
	String totalRecommendations({required int count}) => '${count} recommendations total';

	/// No more recommendations message
	///
	/// en: 'No more recommendations'
	String get noMoreRecommendations => 'No more recommendations';

	/// View recommendation details message
	///
	/// en: 'View recommendation details'
	String get recommendationDetail => 'View recommendation details';

	/// Operation failed message
	///
	/// en: 'Operation failed: {error: String}'
	String operationFailed({required String error}) => 'Operation failed: ${error}';

	/// Discover page title
	///
	/// en: 'Discover'
	String get discover => 'Discover';

	/// Back button text
	///
	/// en: 'Back'
	String get back => 'Back';

	/// Settings button text
	///
	/// en: 'Settings'
	String get settings => 'Settings';

	/// Edit profile button text
	///
	/// en: 'Edit Profile'
	String get editProfile => 'Edit Profile';

	/// Clear all recommendations button text
	///
	/// en: 'Clear All Recommendations'
	String get clearAll => 'Clear All Recommendations';

	/// Confirm button text
	///
	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// Common restaurants label
	///
	/// en: 'Common Restaurants'
	String get commonRestaurants => 'Common Restaurants';

	/// Similarity label
	///
	/// en: 'Similarity'
	String get similarity => 'Similarity';
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Login button text
	///
	/// en: 'Login'
	String get login => 'Login';

	/// Register button text
	///
	/// en: 'Register'
	String get register => 'Register';

	/// Email input field label
	///
	/// en: 'Email Address'
	String get email => 'Email Address';

	/// Password input field label
	///
	/// en: 'Password'
	String get password => 'Password';

	/// Display name input field label
	///
	/// en: 'Display Name'
	String get displayName => 'Display Name';

	/// Phone number input field label
	///
	/// en: 'Phone Number'
	String get phoneNumber => 'Phone Number';

	/// Email validation error message
	///
	/// en: 'Please enter email address'
	String get pleaseEnterEmail => 'Please enter email address';

	/// Email format validation error message
	///
	/// en: 'Please enter a valid email address'
	String get pleaseEnterValidEmail => 'Please enter a valid email address';

	/// Password validation error message
	///
	/// en: 'Please enter password'
	String get pleaseEnterPassword => 'Please enter password';

	/// Password length validation error message
	///
	/// en: 'Password must be at least 6 characters'
	String get passwordMinLength => 'Password must be at least 6 characters';

	/// Forgot password link text
	///
	/// en: 'Forgot Password?'
	String get forgotPassword => 'Forgot Password?';

	/// No account prompt text
	///
	/// en: 'Don't have an account yet?'
	String get noAccountYet => 'Don\'t have an account yet?';

	/// Register now link text
	///
	/// en: 'Register Now'
	String get registerNow => 'Register Now';

	/// Already have account prompt text
	///
	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// Login now link text
	///
	/// en: 'Login Now'
	String get loginNow => 'Login Now';

	/// Create account title
	///
	/// en: 'Create Account'
	String get createAccount => 'Create Account';

	/// Registration page subtitle
	///
	/// en: 'Join FoodieConnect, discover more food'
	String get joinFoodieConnect => 'Join FoodieConnect, discover more food';

	/// Login failed prompt
	///
	/// en: 'Login failed, please try again later'
	String get loginFailed => 'Login failed, please try again later';

	/// Checking login status prompt
	///
	/// en: 'Checking login status...'
	String get checkingLoginStatus => 'Checking login status...';

	/// Authentication check failed prompt
	///
	/// en: 'Authentication check failed'
	String get authCheckFailed => 'Authentication check failed';

	/// Authentication check timeout prompt
	///
	/// en: 'Authentication check timeout'
	String get authCheckTimeout => 'Authentication check timeout';

	/// Error message shown to user
	///
	/// en: 'Invalid email or password'
	String get invalidEmailOrPassword => 'Invalid email or password';

	/// Prefix when registration throws
	///
	/// en: 'Registration failed'
	String get registrationFailed => 'Registration failed';

	/// Error message shown to user
	///
	/// en: 'Logout failed'
	String get logoutFailed => 'Logout failed';

	/// Error message shown to user
	///
	/// en: 'Failed to restore login status'
	String get restoreLoginFailed => 'Failed to restore login status';

	/// Login success message
	///
	/// en: 'Login successful'
	String get loginSuccessful => 'Login successful';

	/// Registration success message
	///
	/// en: 'Registration successful'
	String get registrationSuccessful => 'Registration successful';
}

// Path: chat
class TranslationsChatEn {
	TranslationsChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Chat room title
	///
	/// en: 'Chat Room'
	String get chatRoom => 'Chat Room';

	/// Chat room description
	///
	/// en: 'Chat with staff in real-time for more details'
	String get chatWithStaff => 'Chat with staff in real-time for more details';

	/// Enter chat room button
	///
	/// en: 'Enter Chat Room'
	String get enterChatRoom => 'Enter Chat Room';

	/// Restaurant chat verification title
	///
	/// en: 'Restaurant Chat Verification'
	String get restaurantChatVerification => 'Restaurant Chat Verification';

	/// Enter restaurant ID and verification code prompt
	///
	/// en: 'Please enter restaurant ID and verification code to join the chat room'
	String get enterRestaurantIdAndCode => 'Please enter restaurant ID and verification code to join the chat room';

	/// Verification code label
	///
	/// en: 'Verification Code'
	String get verificationCode => 'Verification Code';

	/// Please enter verification code prompt
	///
	/// en: 'Please enter verification code'
	String get pleaseEnterVerificationCode => 'Please enter verification code';

	/// Verification failed prompt
	///
	/// en: 'Verification failed, please check restaurant ID and verification code'
	String get verificationFailed => 'Verification failed, please check restaurant ID and verification code';

	/// Verification error prompt
	///
	/// en: 'Verification failed: {error: String}'
	String verificationError({required String error}) => 'Verification failed: ${error}';

	/// Failed to get chat room information prompt
	///
	/// en: 'Failed to get chat room information'
	String get failedToGetChatRoomInfo => 'Failed to get chat room information';

	/// Failed to enter read-only mode prompt
	///
	/// en: 'Failed to enter read-only mode: '
	String get enterReadOnlyModeError => 'Failed to enter read-only mode: ';

	/// Verify and start chat button
	///
	/// en: 'Verify and Start Chat'
	String get verifyAndStartChat => 'Verify and Start Chat';

	/// Please verify first prompt
	///
	/// en: 'Please join the chat room through the verification interface first'
	String get pleaseVerifyFirst => 'Please join the chat room through the verification interface first';

	/// Staff chat feature moved prompt
	///
	/// en: 'Staff chat feature has been moved to restaurant chat room'
	String get staffChatFeatureMoved => 'Staff chat feature has been moved to restaurant chat room';

	/// Restaurant chat room name
	///
	/// en: 'Restaurant Chat Room'
	String get restaurantChatRoom => 'Restaurant Chat Room';

	/// Failed to initialize chat room prompt
	///
	/// en: 'Failed to initialize chat room'
	String get initializeChatRoomFailed => 'Failed to initialize chat room';

	/// Failed to initialize chat room error prompt
	///
	/// en: 'Failed to initialize chat room: {error: String}'
	String initializeChatRoomError({required String error}) => 'Failed to initialize chat room: ${error}';

	/// No available chat room prompt
	///
	/// en: 'No available chat room currently'
	String get noAvailableChatRoom => 'No available chat room currently';

	/// No messages prompt
	///
	/// en: 'No messages yet, start chatting!'
	String get noMessagesStartChat => 'No messages yet, start chatting!';

	/// WebSocket not connected prompt
	///
	/// en: 'WebSocket not connected'
	String get websocketNotConnected => 'WebSocket not connected';

	/// Connected status
	///
	/// en: 'Connected'
	String get connected => 'Connected';

	/// Disconnected status
	///
	/// en: 'Disconnected'
	String get disconnected => 'Disconnected';

	/// Enter message prompt
	///
	/// en: 'Enter message...'
	String get enterMessage => 'Enter message...';

	/// New messages prompt
	///
	/// en: 'New Messages'
	String get newMessages => 'New Messages';

	/// Chat title
	///
	/// en: 'Chat'
	String get chat => 'Chat';

	/// Label for today in chat time separator
	///
	/// en: 'Today'
	String get today => 'Today';

	/// Label for yesterday in chat time separator
	///
	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';

	/// Date format when message is from this year
	///
	/// en: '{month: int}/{day: int}'
	String dateFormatThisYear({required int month, required int day}) => '${month}/${day}';

	/// Date format when message is from another year
	///
	/// en: '{year: int}/{month: int}/{day: int}'
	String dateFormatOtherYear({required int year, required int month, required int day}) => '${year}/${month}/${day}';

	/// Time format used after today/yesterday labels
	///
	/// en: '{hour: String}:{minute: String}'
	String timeFormat({required String hour, required String minute}) => '${hour}:${minute}';

	/// Error hint when STOMP connection fails
	///
	/// en: 'STOMP connection error：{error: String}'
	String stompConnectionError({required String error}) => 'STOMP connection error：${error}';

	/// Toast when initial connect throws
	///
	/// en: 'STOMP WebSocket connection failed：{error: String}'
	String stompConnectFail({required String error}) => 'STOMP WebSocket connection failed：${error}';

	/// Hint when waiting for connection timeout
	///
	/// en: 'WebSocket connection timeout，please check network'
	String get websocketTimeout => 'WebSocket connection timeout，please check network';

	/// Hint when back-end does not return roomId/tempToken
	///
	/// en: 'Verification failed：roomId or tempToken missing'
	String get verifyFailNoRoomOrToken => 'Verification failed：roomId or tempToken missing';

	/// Toast when verifyChatRoom API throws
	///
	/// en: 'Verify room failed：{error: String}'
	String verifyRoomFail({required String error}) => 'Verify room failed：${error}';

	/// Toast when STOMP joinRoom throws
	///
	/// en: 'Join room failed：{error: String}'
	String joinRoomFail({required String error}) => 'Join room failed：${error}';

	/// Toast when fetchMessages API throws
	///
	/// en: 'Load messages failed：{error: String}'
	String loadMessageFail({required String error}) => 'Load messages failed：${error}';

	/// Toast when sendMessage but socket disconnected
	///
	/// en: 'STOMP WebSocket not connected，can not send message'
	String get notConnectedCantSend => 'STOMP WebSocket not connected，can not send message';

	/// Toast when sendMessage API throws
	///
	/// en: 'Send message failed：{error: String}'
	String sendMessageFail({required String error}) => 'Send message failed：${error}';

	/// Toast when leaveRoom API throws
	///
	/// en: 'Leave room failed：{error: String}'
	String leaveRoomFail({required String error}) => 'Leave room failed：${error}';

	/// Toast when subscribeToNotifications throws
	///
	/// en: 'Subscribe notification failed：{error: String}'
	String subscribeNotificationFail({required String error}) => 'Subscribe notification failed：${error}';

	/// Thrown when send/join is called before connected
	///
	/// en: 'Not connected, please wait for WebSocket to complete'
	String get stompNotConnected => 'Not connected, please wait for WebSocket to complete';

	/// WebSocket connection status
	///
	/// en: 'Connecting to WebSocket...'
	String get websocketConnecting => 'Connecting to WebSocket...';

	/// Connection exception text pushed to connectionStateController
	///
	/// en: 'WebSocket connection failed: {error: String}'
	String stompConnectFailed({required String error}) => 'WebSocket connection failed: ${error}';

	/// en: 'Connected'
	String get stompConnected => 'Connected';

	/// en: 'Disconnected'
	String get stompDisconnected => 'Disconnected';

	/// en: 'Failed to parse message'
	String get msgParseFailed => 'Failed to parse message';

	/// en: 'Failed to parse notification'
	String get notificationParseFailed => 'Failed to parse notification';

	/// Label for current user
	///
	/// en: 'Me'
	String get me => 'Me';

	/// Button text to enter chat room in read-only mode
	///
	/// en: 'Enter Read-only Mode'
	String get enterReadOnlyMode => 'Enter Read-only Mode';

	/// Read-only mode notification
	///
	/// en: 'You are currently in read-only mode, you can only view messages, not send them'
	String get readOnlyModeNotice => 'You are currently in read-only mode, you can only view messages, not send them';

	/// Read-only mode bottom tip
	///
	/// en: 'Read-only mode: You can view messages, but cannot send'
	String get readOnlyModeTip => 'Read-only mode: You can view messages, but cannot send';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Profile page title
	///
	/// en: 'Profile'
	String get profileTitle => 'Profile';

	/// Other user profile page title
	///
	/// en: 'User Profile'
	String get otherProfileTitle => 'User Profile';

	/// Edit button text
	///
	/// en: 'Edit'
	String get edit => 'Edit';

	/// Save button text
	///
	/// en: 'Save'
	String get save => 'Save';

	/// Loading prompt
	///
	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// Loading failed prompt
	///
	/// en: 'Loading failed'
	String get loadingFailed => 'Loading failed';

	/// Retry button text
	///
	/// en: 'Retry'
	String get retry => 'Retry';

	/// User not found message
	///
	/// en: 'User not found'
	String get userNotFound => 'User not found';

	/// Unknown user text
	///
	/// en: 'Unknown User'
	String get unknownUser => 'Unknown User';

	/// Food preferences title
	///
	/// en: 'Food Preferences'
	String get foodPreferences => 'Food Preferences';

	/// No food preferences message
	///
	/// en: 'No food preferences'
	String get noFoodPreferences => 'No food preferences';

	/// Personal bio title
	///
	/// en: 'Personal Bio'
	String get personalBio => 'Personal Bio';

	/// Bio input placeholder
	///
	/// en: 'Tell us about yourself...'
	String get introduceYourself => 'Tell us about yourself...';

	/// Connect button text
	///
	/// en: 'Connect'
	String get connect => 'Connect';

	/// Connected status text
	///
	/// en: 'Connected'
	String get connected => 'Connected';

	/// Save success message
	///
	/// en: 'Saved successfully'
	String get saveSuccess => 'Saved successfully';

	/// Save failed message
	///
	/// en: 'Save failed: {error: String}'
	String saveFailed({required String error}) => 'Save failed: ${error}';

	/// Connect failed message
	///
	/// en: 'Connect failed'
	String get connectFailed => 'Connect failed';

	/// Disconnect failed message
	///
	/// en: 'Disconnect failed'
	String get disconnectFailed => 'Disconnect failed';

	/// Recommended restaurants title
	///
	/// en: 'Recommended Restaurants'
	String get recommendedRestaurants => 'Recommended Restaurants';

	/// My recommended restaurants title
	///
	/// en: 'My Recommended Restaurants'
	String get myRecommendedRestaurants => 'My Recommended Restaurants';

	/// User recommended restaurants title
	///
	/// en: 'User Recommended Restaurants'
	String get userRecommendedRestaurants => 'User Recommended Restaurants';

	/// Error message shown to user
	///
	/// en: 'update failed'
	String get updateFailed => 'update failed';

	/// Edit profile page title
	///
	/// en: 'Edit Profile'
	String get editProfile => 'Edit Profile';

	/// Email field label
	///
	/// en: 'Email'
	String get email => 'Email';

	/// Username field label
	///
	/// en: 'Username'
	String get username => 'Username';

	/// Phone field label
	///
	/// en: 'Phone'
	String get phone => 'Phone';

	/// Change avatar option title
	///
	/// en: 'Change Avatar'
	String get changeAvatar => 'Change Avatar';

	/// Take photo option
	///
	/// en: 'Take Photo'
	String get takePhoto => 'Take Photo';

	/// Select from gallery option
	///
	/// en: 'Select from Gallery'
	String get selectFromGallery => 'Select from Gallery';

	/// Avatar update success message
	///
	/// en: 'Avatar updated successfully'
	String get avatarUpdateSuccess => 'Avatar updated successfully';

	/// Avatar upload failed message
	///
	/// en: 'Avatar upload failed: {error: String}'
	String avatarUploadFailed({required String error}) => 'Avatar upload failed: ${error}';

	/// Avatar update failed message
	///
	/// en: 'Avatar update failed: {error: String}'
	String avatarUpdateFailed({required String error}) => 'Avatar update failed: ${error}';

	/// Email cannot be changed message
	///
	/// en: 'Email address cannot be changed'
	String get emailCannotBeChanged => 'Email address cannot be changed';

	/// Username input hint
	///
	/// en: 'Please enter username'
	String get usernameHint => 'Please enter username';

	/// Phone input hint
	///
	/// en: 'Please enter phone number (optional)'
	String get phoneHint => 'Please enter phone number (optional)';

	/// Saving message
	///
	/// en: 'Saving...'
	String get saving => 'Saving...';

	/// Delete recommendation success message
	///
	/// en: 'Recommendation deleted'
	String get deleteRecommendationSuccess => 'Recommendation deleted';

	/// Delete recommendation failed message
	///
	/// en: 'Failed to delete recommendation: {error: String}'
	String deleteRecommendationFailed({required String error}) => 'Failed to delete recommendation: ${error}';
}

// Path: restaurant
class TranslationsRestaurantEn {
	TranslationsRestaurantEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// No restaurant information prompt
	///
	/// en: 'No restaurant information available'
	String get noRestaurants => 'No restaurant information available';

	/// Basic information title
	///
	/// en: 'Basic Information'
	String get basicInfo => 'Basic Information';

	/// Address label
	///
	/// en: 'Address'
	String get address => 'Address';

	/// Distance prompt
	///
	/// en: '{distance: String} from you'
	String distanceFromYou({required String distance}) => '${distance} from you';

	/// Business hours label
	///
	/// en: 'Business Hours'
	String get businessHours => 'Business Hours';

	/// Phone label
	///
	/// en: 'Phone'
	String get phone => 'Phone';

	/// Rating label
	///
	/// en: 'Rating'
	String get rating => 'Rating';

	/// Review count prompt
	///
	/// en: '{count: int} reviews'
	String totalReviews({required int count}) => '${count} reviews';

	/// Restaurant images title
	///
	/// en: 'Restaurant Images'
	String get restaurantImages => 'Restaurant Images';

	/// Average price title
	///
	/// en: 'Average Price'
	String get averagePrice => 'Average Price';

	/// Recommended dishes title
	///
	/// en: 'Recommended Dishes'
	String get recommendedDishes => 'Recommended Dishes';

	/// Menu title
	///
	/// en: 'Menu'
	String get menu => 'Menu';

	/// View dish reviews text
	///
	/// en: 'View Dish Reviews'
	String get viewDishReviews => 'View Dish Reviews';

	/// View dish list button
	///
	/// en: 'View Dish List'
	String get viewDishList => 'View Dish List';

	/// View full menu text
	///
	/// en: 'View Full Menu'
	String get viewFullMenu => 'View Full Menu';

	/// View menu button
	///
	/// en: 'View Menu'
	String get viewMenu => 'View Menu';

	/// Menu feature in development prompt
	///
	/// en: 'Menu feature in development'
	String get menuFeatureInDevelopment => 'Menu feature in development';

	/// Failed to get menu prompt
	///
	/// en: 'Failed to get menu'
	String get getMenuFailed => 'Failed to get menu';

	/// Failed to get shop information prompt
	///
	/// en: 'Failed to get shop information'
	String get getShopInfoFailed => 'Failed to get shop information';

	/// Restaurant information invalid prompt
	///
	/// en: 'Restaurant information is invalid'
	String get restaurantInfoInvalid => 'Restaurant information is invalid';

	/// Shop features title
	///
	/// en: 'Shop Features'
	String get shopFeatures => 'Shop Features';

	/// View comments feature title
	///
	/// en: 'View Comments'
	String get viewComments => 'View Comments';

	/// View user reviews description
	///
	/// en: 'View User Reviews'
	String get viewUserReviews => 'View User Reviews';

	/// Instant chat feature title
	///
	/// en: 'Instant Chat'
	String get instantChat => 'Instant Chat';

	/// Chat with staff in real-time description
	///
	/// en: 'Chat with staff in real-time'
	String get chatWithStaffRealtime => 'Chat with staff in real-time';

	/// View staff feature title
	///
	/// en: 'View Staff'
	String get viewStaff => 'View Staff';

	/// Online staff list description
	///
	/// en: 'Online Staff List'
	String get onlineStaffList => 'Online Staff List';

	/// View menu feature title
	///
	/// en: 'View Menu'
	String get viewMenuDishes => 'View Menu';

	/// Browse all dishes description
	///
	/// en: 'Browse all dishes'
	String get browseAllDishes => 'Browse all dishes';

	/// Hint when RestaurantService.list throws
	///
	/// en: 'Failed to load restaurants: {error: String}'
	String loadRestaurantFail({required String error}) => 'Failed to load restaurants: ${error}';

	/// Recommend restaurant button tooltip
	///
	/// en: 'Recommend Restaurant'
	String get recommendRestaurant => 'Recommend Restaurant';

	/// Recommendation success message
	///
	/// en: 'Recommendation successful'
	String get recommendSuccess => 'Recommendation successful';

	/// Recommendation failed message
	///
	/// en: 'Recommendation failed: '
	String get recommendFailed => 'Recommendation failed: ';
}

// Path: review
class TranslationsReviewEn {
	TranslationsReviewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// User comments title
	///
	/// en: 'User Comments'
	String get userComments => 'User Comments';

	/// Publish review button
	///
	/// en: 'Publish Review'
	String get publishReview => 'Publish Review';

	/// Rating label
	///
	/// en: 'Rating'
	String get ratingScore => 'Rating';

	/// Review content label
	///
	/// en: 'Review Content'
	String get reviewContent => 'Review Content';

	/// Review content input box prompt
	///
	/// en: 'Share your dining experience...'
	String get shareDiningExperience => 'Share your dining experience...';

	/// Add images title
	///
	/// en: 'Add Images'
	String get addImages => 'Add Images';

	/// Take photo button
	///
	/// en: 'Take Photo'
	String get takePhoto => 'Take Photo';

	/// Gallery button
	///
	/// en: 'Gallery'
	String get selectFromGallery => 'Gallery';

	/// Select from album text
	///
	/// en: 'Select from Album'
	String get selectFromAlbum => 'Select from Album';

	/// Add image prompt
	///
	/// en: 'Add Image'
	String get addImage => 'Add Image';

	/// Publish button
	///
	/// en: 'Publish'
	String get publish => 'Publish';

	/// Please enter review content prompt
	///
	/// en: 'Please enter review content'
	String get pleaseEnterReviewContent => 'Please enter review content';

	/// Review published prompt
	///
	/// en: 'Review published'
	String get reviewPublished => 'Review published';

	/// Publish failed prompt
	///
	/// en: 'Publish failed'
	String get publishFailed => 'Publish failed';

	/// Failed to take photo prompt
	///
	/// en: 'Failed to take photo'
	String get takePhotoFailed => 'Failed to take photo';

	/// Failed to select image prompt
	///
	/// en: 'Failed to select image'
	String get selectImageFailed => 'Failed to select image';

	/// No reviews prompt
	///
	/// en: 'No reviews yet'
	String get noReviews => 'No reviews yet';

	/// User reviews title
	///
	/// en: 'User Reviews'
	String get userReviews => 'User Reviews';

	/// Review count
	///
	/// en: '{count: int} reviews'
	String reviewCount({required int count}) => '${count} reviews';

	/// Error hint when listByRestaurant throws
	///
	/// en: 'Failed to load reviews: {error: String}'
	String loadReviewFail({required String error}) => 'Failed to load reviews: ${error}';

	/// Error hint when postReview/postWithImages/postWithImageFiles throws
	///
	/// en: 'Failed to post review: {error: String}'
	String postReviewFail({required String error}) => 'Failed to post review: ${error}';

	/// Dish reviews title
	///
	/// en: 'Dish Reviews'
	String get dishReviews => 'Dish Reviews';

	/// Review dish screen title
	///
	/// en: 'Review Dish - {itemName: String}'
	String reviewDish({required String itemName}) => 'Review Dish - ${itemName}';

	/// Reviewing dish info text
	///
	/// en: 'Reviewing Dish: {itemName: String}'
	String reviewingDish({required String itemName}) => 'Reviewing Dish: ${itemName}';

	/// Review update success message
	///
	/// en: 'Review updated'
	String get reviewUpdated => 'Review updated';

	/// Parameter error message
	///
	/// en: 'Parameter error'
	String get parameterError => 'Parameter error';

	/// Review staff screen title
	///
	/// en: 'Review Staff - {staffName: String}'
	String reviewStaff({required String staffName}) => 'Review Staff - ${staffName}';

	/// Reviewing staff info text
	///
	/// en: 'Reviewing Staff: {staffName: String}'
	String reviewingStaff({required String staffName}) => 'Reviewing Staff: ${staffName}';

	/// Missing staff ID error message
	///
	/// en: 'Missing staff ID'
	String get missingStaffId => 'Missing staff ID';

	/// Review publish failed message
	///
	/// en: 'Review failed: {error: String}'
	String publishReviewFailed({required String error}) => 'Review failed: ${error}';
}

// Path: setting
class TranslationsSettingEn {
	TranslationsSettingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Select language title
	///
	/// en: 'Select Language'
	String get selectLanguage => 'Select Language';

	/// Close button text
	///
	/// en: 'Close'
	String get close => 'Close';

	/// Settings title
	///
	/// en: 'Settings'
	String get settings => 'Settings';

	/// Language settings title
	///
	/// en: 'Language Settings'
	String get languageSettings => 'Language Settings';

	/// Current language label
	///
	/// en: 'Current Language'
	String get currentLanguage => 'Current Language';

	/// Account settings title
	///
	/// en: 'Account Settings'
	String get accountSettings => 'Account Settings';

	/// Profile
	///
	/// en: 'Profile'
	String get profile => 'Profile';

	/// Privacy settings
	///
	/// en: 'Privacy Settings'
	String get privacy => 'Privacy Settings';

	/// Notification settings
	///
	/// en: 'Notification Settings'
	String get notifications => 'Notification Settings';

	/// About
	///
	/// en: 'About'
	String get about => 'About';

	/// Version
	///
	/// en: 'Version'
	String get version => 'Version';

	/// Logout
	///
	/// en: 'Logout'
	String get logout => 'Logout';

	/// Are you sure you want to log out prompt
	///
	/// en: 'Are you sure you want to log out?'
	String get sureLogout => 'Are you sure you want to log out?';
}

// Path: staff
class TranslationsStaffEn {
	TranslationsStaffEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Staff reviews title
	///
	/// en: 'Staff Reviews'
	String get staffReviews => 'Staff Reviews';

	/// No staff information prompt
	///
	/// en: 'No staff information available'
	String get noStaffInfo => 'No staff information available';

	/// View all staff button
	///
	/// en: 'View All Staff'
	String get viewAllStaff => 'View All Staff';

	/// Experience label
	///
	/// en: 'Experience'
	String get experience => 'Experience';

	/// Staff list title
	///
	/// en: 'Staff List'
	String get staffList => 'Staff List';

	/// Failed to get staff list prompt
	///
	/// en: 'Failed to get staff list'
	String get getStaffListFailed => 'Failed to get staff list';

	/// No staff information prompt
	///
	/// en: 'No staff information available'
	String get noStaff => 'No staff information available';

	/// Staff details title
	///
	/// en: 'Staff Details'
	String get staffDetails => 'Staff Details';

	/// Staff information does not exist prompt
	///
	/// en: 'Staff information does not exist'
	String get staffInfoNotExists => 'Staff information does not exist';

	/// Failed to get staff details prompt
	///
	/// en: 'Failed to get staff details'
	String get getStaffDetailsFailed => 'Failed to get staff details';

	/// Failed to load staff reviews prompt
	///
	/// en: 'Failed to load staff reviews'
	String get loadStaffReviewsFailed => 'Failed to load staff reviews';

	/// Error when listByRestaurant throws
	///
	/// en: 'Failed to load staff list: {error: String}'
	String loadStaffFail({required String error}) => 'Failed to load staff list: ${error}';

	/// Error when getById throws
	///
	/// en: 'Failed to load staff details: {error: String}'
	String loadStaffDetailFail({required String error}) => 'Failed to load staff details: ${error}';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.appTitle' => 'FoodieConnect',
			'app.foodieConnect' => 'FoodieConnect',
			'app.discoverFoodShareExperience' => 'Discover food, share experiences',
			'app.search' => 'Search',
			'app.searchDish' => 'Search dishes...',
			'app.allCategories' => 'All',
			'app.home' => 'Home',
			'app.loading' => 'Loading...',
			'app.loadingFailed' => 'Loading failed',
			'app.retry' => 'Retry',
			'app.open' => 'Open',
			'app.closed' => 'Closed',
			'app.userProfile' => 'Profile',
			'app.otherUserProfile' => 'User Profile',
			'app.connectionsList' => 'Connections',
			'app.myConnections' => 'My Connections',
			'app.connect' => 'Connect',
			'app.connected' => 'Connected',
			'app.enterReadOnlyMode' => 'Enter Read-only Mode',
			'app.readOnlyModeNotice' => 'You are currently in read-only mode, you can only view messages, not send them',
			'app.readOnlyModeTip' => 'Read-only mode: You can view messages, but cannot send',
			'app.disconnect' => 'Disconnect',
			'app.disconnectConfirm' => ({required Object username}) => 'Are you sure you want to disconnect from ${username}?',
			'app.foodPreferences' => 'Food Preferences',
			'app.noFoodPreferences' => 'No food preferences',
			'app.personalBio' => 'Personal Bio',
			'app.noBio' => 'This person is lazy and left nothing...',
			'app.recommendedRestaurants' => 'Recommended Restaurants',
			'app.noRecommendedRestaurants' => 'No recommended restaurants',
			'app.noConnections' => 'No connections',
			'app.discoverUsers' => 'Go discover interesting users',
			'app.save' => 'Save',
			'app.edit' => 'Edit',
			'app.saveSuccess' => 'Saved successfully',
			'app.saveFailed' => 'Save failed',
			'app.connectSuccess' => 'Connected successfully',
			'app.connectFailed' => 'Connect failed',
			'app.disconnectSuccess' => 'Disconnected',
			'app.disconnectFailed' => 'Disconnect failed',
			'app.userNotFound' => 'User not found',
			'app.unknownUser' => 'Unknown User',
			'app.introduceYourself' => 'Tell us about yourself...',
			'app.cancel' => 'Cancel',
			'app.recommendations' => 'Recommendations',
			'app.recommendedUsers' => 'Recommended Users',
			'app.viewMore' => 'View More',
			'app.noRecommendations' => 'No recommended users',
			'app.searchingRecommendations' => 'The system is finding users you might be interested in',
			'app.interested' => 'Interested',
			'app.notInterested' => 'Not Interested',
			'app.markAsInterested' => 'Marked as interested',
			'app.markAsNotInterested' => 'Marked as not interested',
			'app.recommendationScore' => 'Recommendation Score',
			'app.recommendationReason' => 'Recommendation Reason',
			'app.collaborativeRecommendation' => 'Recommended based on common preferences',
			'app.socialRecommendation' => 'People you connect with also connect with them',
			'app.hybridRecommendation' => 'Comprehensive recommendation',
			'app.commonInterests' => ({required String interests}) => 'Common interests: ${interests}',
			'app.commonVisits' => ({required int count}) => 'Visited ${count} restaurants together',
			'app.filter' => 'Filter',
			'app.sort' => 'Sort',
			'app.filterByStatus' => 'Filter Recommendations',
			'app.sortBy' => 'Sort By',
			'app.all' => 'All',
			'app.unviewed' => 'Unviewed',
			'app.viewed' => 'Viewed',
			'app.sortByScore' => 'Recommendation Score',
			'app.sortByTime' => 'Creation Time',
			'app.sortByViewTime' => 'View Time',
			'app.clearAllRecommendations' => 'Clear All Recommendations',
			'app.clearAllConfirm' => 'Are you sure you want to clear all recommendations? This action cannot be undone.',
			'app.totalRecommendations' => ({required int count}) => '${count} recommendations total',
			'app.noMoreRecommendations' => 'No more recommendations',
			'app.recommendationDetail' => 'View recommendation details',
			'app.operationFailed' => ({required String error}) => 'Operation failed: ${error}',
			'app.discover' => 'Discover',
			'app.back' => 'Back',
			'app.settings' => 'Settings',
			'app.editProfile' => 'Edit Profile',
			'app.clearAll' => 'Clear All Recommendations',
			'app.confirm' => 'Confirm',
			'app.commonRestaurants' => 'Common Restaurants',
			'app.similarity' => 'Similarity',
			'auth.login' => 'Login',
			'auth.register' => 'Register',
			'auth.email' => 'Email Address',
			'auth.password' => 'Password',
			'auth.displayName' => 'Display Name',
			'auth.phoneNumber' => 'Phone Number',
			'auth.pleaseEnterEmail' => 'Please enter email address',
			'auth.pleaseEnterValidEmail' => 'Please enter a valid email address',
			'auth.pleaseEnterPassword' => 'Please enter password',
			'auth.passwordMinLength' => 'Password must be at least 6 characters',
			'auth.forgotPassword' => 'Forgot Password?',
			'auth.noAccountYet' => 'Don\'t have an account yet?',
			'auth.registerNow' => 'Register Now',
			'auth.alreadyHaveAccount' => 'Already have an account?',
			'auth.loginNow' => 'Login Now',
			'auth.createAccount' => 'Create Account',
			'auth.joinFoodieConnect' => 'Join FoodieConnect, discover more food',
			'auth.loginFailed' => 'Login failed, please try again later',
			'auth.checkingLoginStatus' => 'Checking login status...',
			'auth.authCheckFailed' => 'Authentication check failed',
			'auth.authCheckTimeout' => 'Authentication check timeout',
			'auth.invalidEmailOrPassword' => 'Invalid email or password',
			'auth.registrationFailed' => 'Registration failed',
			'auth.logoutFailed' => 'Logout failed',
			'auth.restoreLoginFailed' => 'Failed to restore login status',
			'auth.loginSuccessful' => 'Login successful',
			'auth.registrationSuccessful' => 'Registration successful',
			'chat.chatRoom' => 'Chat Room',
			'chat.chatWithStaff' => 'Chat with staff in real-time for more details',
			'chat.enterChatRoom' => 'Enter Chat Room',
			'chat.restaurantChatVerification' => 'Restaurant Chat Verification',
			'chat.enterRestaurantIdAndCode' => 'Please enter restaurant ID and verification code to join the chat room',
			'chat.verificationCode' => 'Verification Code',
			'chat.pleaseEnterVerificationCode' => 'Please enter verification code',
			'chat.verificationFailed' => 'Verification failed, please check restaurant ID and verification code',
			'chat.verificationError' => ({required String error}) => 'Verification failed: ${error}',
			'chat.failedToGetChatRoomInfo' => 'Failed to get chat room information',
			'chat.enterReadOnlyModeError' => 'Failed to enter read-only mode: ',
			'chat.verifyAndStartChat' => 'Verify and Start Chat',
			'chat.pleaseVerifyFirst' => 'Please join the chat room through the verification interface first',
			'chat.staffChatFeatureMoved' => 'Staff chat feature has been moved to restaurant chat room',
			'chat.restaurantChatRoom' => 'Restaurant Chat Room',
			'chat.initializeChatRoomFailed' => 'Failed to initialize chat room',
			'chat.initializeChatRoomError' => ({required String error}) => 'Failed to initialize chat room: ${error}',
			'chat.noAvailableChatRoom' => 'No available chat room currently',
			'chat.noMessagesStartChat' => 'No messages yet, start chatting!',
			'chat.websocketNotConnected' => 'WebSocket not connected',
			'chat.connected' => 'Connected',
			'chat.disconnected' => 'Disconnected',
			'chat.enterMessage' => 'Enter message...',
			'chat.newMessages' => 'New Messages',
			'chat.chat' => 'Chat',
			'chat.today' => 'Today',
			'chat.yesterday' => 'Yesterday',
			'chat.dateFormatThisYear' => ({required int month, required int day}) => '${month}/${day}',
			'chat.dateFormatOtherYear' => ({required int year, required int month, required int day}) => '${year}/${month}/${day}',
			'chat.timeFormat' => ({required String hour, required String minute}) => '${hour}:${minute}',
			'chat.stompConnectionError' => ({required String error}) => 'STOMP connection error：${error}',
			'chat.stompConnectFail' => ({required String error}) => 'STOMP WebSocket connection failed：${error}',
			'chat.websocketTimeout' => 'WebSocket connection timeout，please check network',
			'chat.verifyFailNoRoomOrToken' => 'Verification failed：roomId or tempToken missing',
			'chat.verifyRoomFail' => ({required String error}) => 'Verify room failed：${error}',
			'chat.joinRoomFail' => ({required String error}) => 'Join room failed：${error}',
			'chat.loadMessageFail' => ({required String error}) => 'Load messages failed：${error}',
			'chat.notConnectedCantSend' => 'STOMP WebSocket not connected，can not send message',
			'chat.sendMessageFail' => ({required String error}) => 'Send message failed：${error}',
			'chat.leaveRoomFail' => ({required String error}) => 'Leave room failed：${error}',
			'chat.subscribeNotificationFail' => ({required String error}) => 'Subscribe notification failed：${error}',
			'chat.stompNotConnected' => 'Not connected, please wait for WebSocket to complete',
			'chat.websocketConnecting' => 'Connecting to WebSocket...',
			'chat.stompConnectFailed' => ({required String error}) => 'WebSocket connection failed: ${error}',
			'chat.stompConnected' => 'Connected',
			'chat.stompDisconnected' => 'Disconnected',
			'chat.msgParseFailed' => 'Failed to parse message',
			'chat.notificationParseFailed' => 'Failed to parse notification',
			'chat.me' => 'Me',
			'chat.enterReadOnlyMode' => 'Enter Read-only Mode',
			'chat.readOnlyModeNotice' => 'You are currently in read-only mode, you can only view messages, not send them',
			'chat.readOnlyModeTip' => 'Read-only mode: You can view messages, but cannot send',
			'profile.profileTitle' => 'Profile',
			'profile.otherProfileTitle' => 'User Profile',
			'profile.edit' => 'Edit',
			'profile.save' => 'Save',
			'profile.loading' => 'Loading...',
			'profile.loadingFailed' => 'Loading failed',
			'profile.retry' => 'Retry',
			'profile.userNotFound' => 'User not found',
			'profile.unknownUser' => 'Unknown User',
			'profile.foodPreferences' => 'Food Preferences',
			'profile.noFoodPreferences' => 'No food preferences',
			'profile.personalBio' => 'Personal Bio',
			'profile.introduceYourself' => 'Tell us about yourself...',
			'profile.connect' => 'Connect',
			'profile.connected' => 'Connected',
			'profile.saveSuccess' => 'Saved successfully',
			'profile.saveFailed' => ({required String error}) => 'Save failed: ${error}',
			'profile.connectFailed' => 'Connect failed',
			'profile.disconnectFailed' => 'Disconnect failed',
			'profile.recommendedRestaurants' => 'Recommended Restaurants',
			'profile.myRecommendedRestaurants' => 'My Recommended Restaurants',
			'profile.userRecommendedRestaurants' => 'User Recommended Restaurants',
			'profile.updateFailed' => 'update failed',
			'profile.editProfile' => 'Edit Profile',
			'profile.email' => 'Email',
			'profile.username' => 'Username',
			'profile.phone' => 'Phone',
			'profile.changeAvatar' => 'Change Avatar',
			'profile.takePhoto' => 'Take Photo',
			'profile.selectFromGallery' => 'Select from Gallery',
			'profile.avatarUpdateSuccess' => 'Avatar updated successfully',
			'profile.avatarUploadFailed' => ({required String error}) => 'Avatar upload failed: ${error}',
			'profile.avatarUpdateFailed' => ({required String error}) => 'Avatar update failed: ${error}',
			'profile.emailCannotBeChanged' => 'Email address cannot be changed',
			'profile.usernameHint' => 'Please enter username',
			'profile.phoneHint' => 'Please enter phone number (optional)',
			'profile.saving' => 'Saving...',
			'profile.deleteRecommendationSuccess' => 'Recommendation deleted',
			'profile.deleteRecommendationFailed' => ({required String error}) => 'Failed to delete recommendation: ${error}',
			'restaurant.noRestaurants' => 'No restaurant information available',
			'restaurant.basicInfo' => 'Basic Information',
			'restaurant.address' => 'Address',
			'restaurant.distanceFromYou' => ({required String distance}) => '${distance} from you',
			'restaurant.businessHours' => 'Business Hours',
			'restaurant.phone' => 'Phone',
			'restaurant.rating' => 'Rating',
			'restaurant.totalReviews' => ({required int count}) => '${count} reviews',
			'restaurant.restaurantImages' => 'Restaurant Images',
			'restaurant.averagePrice' => 'Average Price',
			'restaurant.recommendedDishes' => 'Recommended Dishes',
			'restaurant.menu' => 'Menu',
			'restaurant.viewDishReviews' => 'View Dish Reviews',
			'restaurant.viewDishList' => 'View Dish List',
			'restaurant.viewFullMenu' => 'View Full Menu',
			'restaurant.viewMenu' => 'View Menu',
			'restaurant.menuFeatureInDevelopment' => 'Menu feature in development',
			'restaurant.getMenuFailed' => 'Failed to get menu',
			'restaurant.getShopInfoFailed' => 'Failed to get shop information',
			'restaurant.restaurantInfoInvalid' => 'Restaurant information is invalid',
			'restaurant.shopFeatures' => 'Shop Features',
			'restaurant.viewComments' => 'View Comments',
			'restaurant.viewUserReviews' => 'View User Reviews',
			'restaurant.instantChat' => 'Instant Chat',
			'restaurant.chatWithStaffRealtime' => 'Chat with staff in real-time',
			'restaurant.viewStaff' => 'View Staff',
			'restaurant.onlineStaffList' => 'Online Staff List',
			'restaurant.viewMenuDishes' => 'View Menu',
			'restaurant.browseAllDishes' => 'Browse all dishes',
			'restaurant.loadRestaurantFail' => ({required String error}) => 'Failed to load restaurants: ${error}',
			'restaurant.recommendRestaurant' => 'Recommend Restaurant',
			'restaurant.recommendSuccess' => 'Recommendation successful',
			'restaurant.recommendFailed' => 'Recommendation failed: ',
			'review.userComments' => 'User Comments',
			'review.publishReview' => 'Publish Review',
			'review.ratingScore' => 'Rating',
			'review.reviewContent' => 'Review Content',
			'review.shareDiningExperience' => 'Share your dining experience...',
			'review.addImages' => 'Add Images',
			'review.takePhoto' => 'Take Photo',
			'review.selectFromGallery' => 'Gallery',
			'review.selectFromAlbum' => 'Select from Album',
			'review.addImage' => 'Add Image',
			'review.publish' => 'Publish',
			'review.pleaseEnterReviewContent' => 'Please enter review content',
			'review.reviewPublished' => 'Review published',
			'review.publishFailed' => 'Publish failed',
			'review.takePhotoFailed' => 'Failed to take photo',
			'review.selectImageFailed' => 'Failed to select image',
			'review.noReviews' => 'No reviews yet',
			'review.userReviews' => 'User Reviews',
			'review.reviewCount' => ({required int count}) => '${count} reviews',
			'review.loadReviewFail' => ({required String error}) => 'Failed to load reviews: ${error}',
			'review.postReviewFail' => ({required String error}) => 'Failed to post review: ${error}',
			'review.dishReviews' => 'Dish Reviews',
			'review.reviewDish' => ({required String itemName}) => 'Review Dish - ${itemName}',
			'review.reviewingDish' => ({required String itemName}) => 'Reviewing Dish: ${itemName}',
			'review.reviewUpdated' => 'Review updated',
			'review.parameterError' => 'Parameter error',
			'review.reviewStaff' => ({required String staffName}) => 'Review Staff - ${staffName}',
			'review.reviewingStaff' => ({required String staffName}) => 'Reviewing Staff: ${staffName}',
			'review.missingStaffId' => 'Missing staff ID',
			'review.publishReviewFailed' => ({required String error}) => 'Review failed: ${error}',
			'setting.selectLanguage' => 'Select Language',
			'setting.close' => 'Close',
			'setting.settings' => 'Settings',
			'setting.languageSettings' => 'Language Settings',
			'setting.currentLanguage' => 'Current Language',
			'setting.accountSettings' => 'Account Settings',
			'setting.profile' => 'Profile',
			'setting.privacy' => 'Privacy Settings',
			'setting.notifications' => 'Notification Settings',
			'setting.about' => 'About',
			'setting.version' => 'Version',
			'setting.logout' => 'Logout',
			'setting.sureLogout' => 'Are you sure you want to log out?',
			'staff.staffReviews' => 'Staff Reviews',
			'staff.noStaffInfo' => 'No staff information available',
			'staff.viewAllStaff' => 'View All Staff',
			'staff.experience' => 'Experience',
			'staff.staffList' => 'Staff List',
			'staff.getStaffListFailed' => 'Failed to get staff list',
			'staff.noStaff' => 'No staff information available',
			'staff.staffDetails' => 'Staff Details',
			'staff.staffInfoNotExists' => 'Staff information does not exist',
			'staff.getStaffDetailsFailed' => 'Failed to get staff details',
			'staff.loadStaffReviewsFailed' => 'Failed to load staff reviews',
			'staff.loadStaffFail' => ({required String error}) => 'Failed to load staff list: ${error}',
			'staff.loadStaffDetailFail' => ({required String error}) => 'Failed to load staff details: ${error}',
			_ => null,
		};
	}
}
