import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'restaurant_localizations_en.dart';
import 'restaurant_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of RestaurantLocalizations
/// returned by `RestaurantLocalizations.of(context)`.
///
/// Applications need to include `RestaurantLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'restaurant/restaurant_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RestaurantLocalizations.localizationsDelegates,
///   supportedLocales: RestaurantLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the RestaurantLocalizations.supportedLocales
/// property.
abstract class RestaurantLocalizations {
  RestaurantLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RestaurantLocalizations? of(BuildContext context) {
    return Localizations.of<RestaurantLocalizations>(
      context,
      RestaurantLocalizations,
    );
  }

  static const LocalizationsDelegate<RestaurantLocalizations> delegate =
      _RestaurantLocalizationsDelegate();

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

  /// No restaurant information prompt
  ///
  /// In en, this message translates to:
  /// **'No restaurant information available'**
  String get noRestaurants;

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

  /// Restaurant information invalid prompt
  ///
  /// In en, this message translates to:
  /// **'Restaurant information is invalid'**
  String get restaurantInfoInvalid;

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

  /// Hint when RestaurantService.list throws
  ///
  /// In en, this message translates to:
  /// **'Failed to load restaurants: {error}'**
  String loadRestaurantFail(String error);
}

class _RestaurantLocalizationsDelegate
    extends LocalizationsDelegate<RestaurantLocalizations> {
  const _RestaurantLocalizationsDelegate();

  @override
  Future<RestaurantLocalizations> load(Locale locale) {
    return SynchronousFuture<RestaurantLocalizations>(
      lookupRestaurantLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_RestaurantLocalizationsDelegate old) => false;
}

RestaurantLocalizations lookupRestaurantLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return RestaurantLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return RestaurantLocalizationsEn();
    case 'zh':
      return RestaurantLocalizationsZh();
  }

  throw FlutterError(
    'RestaurantLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
