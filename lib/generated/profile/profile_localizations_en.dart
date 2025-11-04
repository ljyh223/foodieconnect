// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profile_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ProfileLocalizationsEn extends ProfileLocalizations {
  ProfileLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get profileTitle => 'Profile';

  @override
  String get otherProfileTitle => 'User Profile';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get loading => 'Loading...';

  @override
  String get loadingFailed => 'Loading failed';

  @override
  String get retry => 'Retry';

  @override
  String get userNotFound => 'User not found';

  @override
  String get unknownUser => 'Unknown User';

  @override
  String get foodPreferences => 'Food Preferences';

  @override
  String get noFoodPreferences => 'No food preferences';

  @override
  String get personalBio => 'Personal Bio';

  @override
  String get introduceYourself => 'Tell us about yourself...';

  @override
  String get connect => 'Connect';

  @override
  String get following => 'Following';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String saveFailed(String error) {
    return 'Save failed: $error';
  }

  @override
  String get followFailed => 'Follow failed';

  @override
  String get unfollowFailed => 'Unfollow failed';

  @override
  String get recommendedRestaurants => 'Recommended Restaurants';
}
