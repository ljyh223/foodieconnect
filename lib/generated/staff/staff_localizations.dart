import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'staff_localizations_en.dart';
import 'staff_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of StaffLocalizations
/// returned by `StaffLocalizations.of(context)`.
///
/// Applications need to include `StaffLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'staff/staff_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: StaffLocalizations.localizationsDelegates,
///   supportedLocales: StaffLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the StaffLocalizations.supportedLocales
/// property.
abstract class StaffLocalizations {
  StaffLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static StaffLocalizations? of(BuildContext context) {
    return Localizations.of<StaffLocalizations>(context, StaffLocalizations);
  }

  static const LocalizationsDelegate<StaffLocalizations> delegate =
      _StaffLocalizationsDelegate();

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
}

class _StaffLocalizationsDelegate
    extends LocalizationsDelegate<StaffLocalizations> {
  const _StaffLocalizationsDelegate();

  @override
  Future<StaffLocalizations> load(Locale locale) {
    return SynchronousFuture<StaffLocalizations>(
      lookupStaffLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_StaffLocalizationsDelegate old) => false;
}

StaffLocalizations lookupStaffLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return StaffLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return StaffLocalizationsEn();
    case 'zh':
      return StaffLocalizationsZh();
  }

  throw FlutterError(
    'StaffLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
