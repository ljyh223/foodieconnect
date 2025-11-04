// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'staff_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class StaffLocalizationsEn extends StaffLocalizations {
  StaffLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get staffReviews => 'Staff Reviews';

  @override
  String get noStaffInfo => 'No staff information available';

  @override
  String get viewAllStaff => 'View All Staff';

  @override
  String get experience => 'Experience';

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
  String loadStaffFail(String error) {
    return 'Failed to load staff list: $error';
  }

  @override
  String loadStaffDetailFail(String error) {
    return 'Failed to load staff details: $error';
  }
}
