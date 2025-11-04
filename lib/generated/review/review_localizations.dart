import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'review_localizations_en.dart';
import 'review_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ReviewLocalizations
/// returned by `ReviewLocalizations.of(context)`.
///
/// Applications need to include `ReviewLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'review/review_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ReviewLocalizations.localizationsDelegates,
///   supportedLocales: ReviewLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the ReviewLocalizations.supportedLocales
/// property.
abstract class ReviewLocalizations {
  ReviewLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ReviewLocalizations? of(BuildContext context) {
    return Localizations.of<ReviewLocalizations>(context, ReviewLocalizations);
  }

  static const LocalizationsDelegate<ReviewLocalizations> delegate =
      _ReviewLocalizationsDelegate();

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

  /// No reviews prompt
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviews;

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
}

class _ReviewLocalizationsDelegate
    extends LocalizationsDelegate<ReviewLocalizations> {
  const _ReviewLocalizationsDelegate();

  @override
  Future<ReviewLocalizations> load(Locale locale) {
    return SynchronousFuture<ReviewLocalizations>(
      lookupReviewLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_ReviewLocalizationsDelegate old) => false;
}

ReviewLocalizations lookupReviewLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return ReviewLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ReviewLocalizationsEn();
    case 'zh':
      return ReviewLocalizationsZh();
  }

  throw FlutterError(
    'ReviewLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
