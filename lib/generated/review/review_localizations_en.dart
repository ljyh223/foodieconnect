// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'review_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ReviewLocalizationsEn extends ReviewLocalizations {
  ReviewLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get noReviews => 'No reviews yet';

  @override
  String get userReviews => 'User Reviews';

  @override
  String reviewCount(int count) {
    return '$count reviews';
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
  String get dishReviews => 'Dish Reviews';
}
