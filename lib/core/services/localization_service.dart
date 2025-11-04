import 'package:flutter/widgets.dart';
import 'package:tabletalk/generated/app/app_localizations.dart';
import 'package:tabletalk/generated/auth/auth_localizations.dart';
import 'package:tabletalk/generated/chat/chat_localizations.dart';
import 'package:tabletalk/generated/profile/profile_localizations.dart';
import 'package:tabletalk/generated/restaurant/restaurant_localizations.dart';
import 'package:tabletalk/generated/review/review_localizations.dart';
import 'package:tabletalk/generated/setting/setting_localizations.dart';
import 'package:tabletalk/generated/staff/staff_localizations.dart';


class LocalizationService {
  static final LocalizationService _singleton = LocalizationService._internal();
  LocalizationService._internal();
  static LocalizationService get I => _singleton;

  AppLocalizations? _app;
  AuthLocalizations? _auth;
  ChatLocalizations? _chat;
  RestaurantLocalizations? _restaurant;
  ReviewLocalizations? _review;
  SettingLocalizations? _setting;
  StaffLocalizations? _staff;
  ProfileLocalizations? _profile;

  /// 在 MaterialApp.builder 中调用
  static void update(BuildContext context) {
    final i = _singleton;
    i._app = AppLocalizations.of(context);
    i._auth = AuthLocalizations.of(context);
    i._chat = ChatLocalizations.of(context);
    i._restaurant = RestaurantLocalizations.of(context);
    i._review = ReviewLocalizations.of(context);
    i._setting = SettingLocalizations.of(context);
    i._staff = StaffLocalizations.of(context);
    i._profile = ProfileLocalizations.of(context);
  }

  // === 模块代理访问 ===
  AppLocalizations get app => _app!;
  AuthLocalizations get auth => _auth!;
  ChatLocalizations get chat => _chat!;
  RestaurantLocalizations get restaurant => _restaurant!;
  ReviewLocalizations get review => _review!;
  SettingLocalizations get setting => _setting!;
  StaffLocalizations get staff => _staff!;
  ProfileLocalizations get profile => _profile!;

}