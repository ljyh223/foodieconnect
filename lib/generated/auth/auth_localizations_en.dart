// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AuthLocalizationsEn extends AuthLocalizations {
  AuthLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get displayName => 'Display Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get pleaseEnterEmail => 'Please enter email address';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email address';

  @override
  String get pleaseEnterPassword => 'Please enter password';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get noAccountYet => 'Don\'t have an account yet?';

  @override
  String get registerNow => 'Register Now';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginNow => 'Login Now';

  @override
  String get createAccount => 'Create Account';

  @override
  String get joinTableTalk => 'Join TableTalk, discover more food';

  @override
  String get loginFailed => 'Login failed, please try again later';

  @override
  String get checkingLoginStatus => 'Checking login status...';

  @override
  String get authCheckFailed => 'Authentication check failed';

  @override
  String get authCheckTimeout => 'Authentication check timeout';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get registrationFailed => 'Registration failed';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get restoreLoginFailed => 'Failed to restore login status';

  @override
  String get loginSuccessful => 'Login successful';

  @override
  String get registrationSuccessful => 'Registration successful';
}
