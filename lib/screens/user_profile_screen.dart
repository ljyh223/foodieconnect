import 'package:flutter/material.dart';
import 'profile_view_screen.dart';

/// 用户个人主页入口
/// 现在直接导航到新的 ProfileViewScreen
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 直接返回 ProfileViewScreen，保持向后兼容性
    return const ProfileViewScreen();
  }
}