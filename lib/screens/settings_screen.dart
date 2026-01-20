import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/providers/language_provider.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/widgets/language_selector_widget.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../core/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.setting.settings),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: ListView(
        children: [
          // 语言设置部分
          _buildSection(
            context,
            title: t.setting.languageSettings,
            children: [
              Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return ListTile(
                    leading: Icon(Icons.language, color: AppColors.onSurface),
                    title: Text(
                      t.setting.currentLanguage,
                      style: TextStyle(color: AppColors.onSurface),
                    ),
                    subtitle: Text(
                      languageProvider.currentLanguageName,
                      style: TextStyle(color: AppColors.onSurfaceVariant),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onTap: () {
                      _showLanguageSelector(context);
                    },
                  );
                },
              ),
            ],
          ),

          // 账户设置部分
          _buildSection(
            context,
            title: t.setting.accountSettings,
            children: [
              ListTile(
                leading: Icon(Icons.person, color: AppColors.onSurface),
                title: Text(
                  t.setting.profile,
                  style: TextStyle(color: AppColors.onSurface),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
                onTap: () {
                  // TODO: 导航到个人资料页面
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(t.setting.profile)));
                },
              ),
              ListTile(
                leading: Icon(Icons.lock, color: AppColors.onSurface),
                title: Text(
                  t.setting.privacy,
                  style: TextStyle(color: AppColors.onSurface),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
                onTap: () {
                  // TODO: 导航到隐私设置页面
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(t.setting.privacy)));
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications, color: AppColors.onSurface),
                title: Text(
                  t.setting.notifications,
                  style: TextStyle(color: AppColors.onSurface),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
                onTap: () {
                  // TODO: 导航到通知设置页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.setting.notifications)),
                  );
                },
              ),
            ],
          ),

          // 关于部分
          _buildSection(
            context,
            title: t.setting.about,
            children: [
              ListTile(
                leading: Icon(Icons.info, color: AppColors.onSurface),
                title: Text(
                  t.setting.version,
                  style: TextStyle(color: AppColors.onSurface),
                ),
                subtitle: Text(
                  '1.0.0',
                  style: TextStyle(color: AppColors.onSurfaceVariant),
                ),
              ),
            ],
          ),

          // 退出登录按钮
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _showLogoutConfirmation(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.onError,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(t.setting.logout),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        Container(
          color: AppColors.surface,
          child: Column(children: children),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            t.setting.logout,
            style: TextStyle(color: AppColors.onSurface),
          ),
          content: Text(
            t.setting.sureLogout,
            style: TextStyle(color: AppColors.onSurfaceVariant),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                t.setting.close,
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                var auth = Provider.of<AuthProvider>(context, listen: false);
                auth.setContext(context);
                auth.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text(
                t.setting.logout,
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LanguageSelectorDialog();
      },
    );
  }
}
