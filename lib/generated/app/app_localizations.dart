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
/// import 'app/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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

  /// Search box prompt text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Loading prompt
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

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

  /// User profile title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get userProfile;

  /// Other user profile title
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get otherUserProfile;

  /// Following list title
  ///
  /// In en, this message translates to:
  /// **'Following List'**
  String get followingList;

  /// My following title
  ///
  /// In en, this message translates to:
  /// **'My Following'**
  String get myFollowing;

  /// Connect button text
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// Follow button text
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// Following status text
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get following;

  /// Unfollow button text
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get unfollow;

  /// Unfollow confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unfollow {username}?'**
  String unfollowConfirm(Object username);

  /// Food preferences title
  ///
  /// In en, this message translates to:
  /// **'Food Preferences'**
  String get foodPreferences;

  /// No food preferences message
  ///
  /// In en, this message translates to:
  /// **'No food preferences'**
  String get noFoodPreferences;

  /// Personal bio title
  ///
  /// In en, this message translates to:
  /// **'Personal Bio'**
  String get personalBio;

  /// No bio message
  ///
  /// In en, this message translates to:
  /// **'This person is lazy and left nothing...'**
  String get noBio;

  /// Recommended restaurants title
  ///
  /// In en, this message translates to:
  /// **'Recommended Restaurants'**
  String get recommendedRestaurants;

  /// No recommended restaurants message
  ///
  /// In en, this message translates to:
  /// **'No recommended restaurants'**
  String get noRecommendedRestaurants;

  /// No following message
  ///
  /// In en, this message translates to:
  /// **'No following'**
  String get noFollowing;

  /// Discover users message
  ///
  /// In en, this message translates to:
  /// **'Go discover interesting users'**
  String get discoverUsers;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Save success message
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get saveSuccess;

  /// Save failed message
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFailed;

  /// Follow success message
  ///
  /// In en, this message translates to:
  /// **'Followed successfully'**
  String get followSuccess;

  /// Follow failed message
  ///
  /// In en, this message translates to:
  /// **'Follow failed'**
  String get followFailed;

  /// Unfollow success message
  ///
  /// In en, this message translates to:
  /// **'Unfollowed'**
  String get unfollowSuccess;

  /// Unfollow failed message
  ///
  /// In en, this message translates to:
  /// **'Unfollow failed'**
  String get unfollowFailed;

  /// User not found message
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// Unknown user text
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get unknownUser;

  /// Bio input placeholder
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself...'**
  String get introduceYourself;
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
