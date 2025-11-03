import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/providers/language_provider.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/widgets/language_selector_widget.dart';
import '../core/services/localization_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.I.settings),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[50],
      body: ListView(
        children: [
          // 语言设置部分
          _buildSection(
            context,
            title: LocalizationService.I.languageSettings,
            children: [
              Consumer<LanguageProvider>(
                builder: (context, languageProvider, child) {
                  return ListTile(
                    leading: const Icon(Icons.language, color: Colors.blue),
                    title: Text(LocalizationService.I.currentLanguage),
                    subtitle: Text(languageProvider.currentLanguageName),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LanguageSettingsScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          
          // 账户设置部分
          _buildSection(
            context,
            title: LocalizationService.I.accountSettings,
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: Text(LocalizationService.I.profile),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: 导航到个人资料页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(LocalizationService.I.profile)),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.orange),
                title: Text(LocalizationService.I.privacy),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: 导航到隐私设置页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(LocalizationService.I.privacy)),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.purple),
                title: Text(LocalizationService.I.notifications),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: 导航到通知设置页面
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(LocalizationService.I.notifications)),
                  );
                },
              ),
            ],
          ),
          
          // 关于部分
          _buildSection(
            context,
            title: LocalizationService.I.about,
            children: [
              ListTile(
                leading: const Icon(Icons.info, color: Colors.grey),
                title: Text(LocalizationService.I.version),
                subtitle: const Text('1.0.0'),
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
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(LocalizationService.I.logout),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required List<Widget> children}) {
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
              color: Colors.grey[600],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: children,
          ),
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
          title: Text(LocalizationService.I.logout),
          content: const Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocalizationService.I.close),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                var auth =Provider.of<AuthProvider>(context, listen: false);
                auth.setContext(context);
                auth.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text(LocalizationService.I.logout),
            ),
          ],
        );
      },
    );
  }
}

// 语言设置子页面
class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.I.languageSettings),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[50],
      body: const Column(
        children: [
          // 使用现有的语言选择器组件
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: LanguageSelectorDialog(),
            ),
          ),
        ],
      ),
    );
  }
}