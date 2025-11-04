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
  String get search => 'Search';

  @override
  String get loading => 'Loading...';

  @override
  String get loadingFailed => 'Loading failed';

  @override
  String get retry => 'Retry';

  @override
  String get open => 'Open';

  @override
  String get closed => 'Closed';

  @override
  String get userProfile => 'Profile';

  @override
  String get otherUserProfile => 'User Profile';

  @override
  String get followingList => 'Following List';

  @override
  String get myFollowing => 'My Following';

  @override
  String get connect => 'Connect';

  @override
  String get follow => 'Follow';

  @override
  String get following => 'Following';

  @override
  String get unfollow => 'Unfollow';

  @override
  String unfollowConfirm(Object username) {
    return 'Are you sure you want to unfollow $username?';
  }

  @override
  String get foodPreferences => 'Food Preferences';

  @override
  String get noFoodPreferences => 'No food preferences';

  @override
  String get personalBio => 'Personal Bio';

  @override
  String get noBio => 'This person is lazy and left nothing...';

  @override
  String get recommendedRestaurants => 'Recommended Restaurants';

  @override
  String get noRecommendedRestaurants => 'No recommended restaurants';

  @override
  String get noFollowing => 'No following';

  @override
  String get discoverUsers => 'Go discover interesting users';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String get saveFailed => 'Save failed';

  @override
  String get followSuccess => 'Followed successfully';

  @override
  String get followFailed => 'Follow failed';

  @override
  String get unfollowSuccess => 'Unfollowed';

  @override
  String get unfollowFailed => 'Unfollow failed';

  @override
  String get userNotFound => 'User not found';

  @override
  String get unknownUser => 'Unknown User';

  @override
  String get introduceYourself => 'Tell us about yourself...';
}
