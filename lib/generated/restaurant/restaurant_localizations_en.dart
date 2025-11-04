// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'restaurant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class RestaurantLocalizationsEn extends RestaurantLocalizations {
  RestaurantLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noRestaurants => 'No restaurant information available';

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
  String get restaurantImages => 'Restaurant Images';

  @override
  String get averagePrice => 'Average Price';

  @override
  String get recommendedDishes => 'Recommended Dishes';

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
  String get restaurantInfoInvalid => 'Restaurant information is invalid';

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
  String loadRestaurantFail(String error) {
    return 'Failed to load restaurants: $error';
  }
}
