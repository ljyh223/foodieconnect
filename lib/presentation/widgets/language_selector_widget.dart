import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../../core/services/localization_service.dart';

/// 语言选择器组件
class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return PopupMenuButton<Locale>(
          tooltip: LocalizationService.I.setting.selectLanguage,
          onSelected: (Locale locale) {
            languageProvider.changeLanguage(locale);
          },
          itemBuilder: (BuildContext context) {
            return LanguageProvider.supportedLocales.map((Locale locale) {
              final String languageCode = locale.countryCode != null
                  ? '${locale.languageCode}_${locale.countryCode}'
                  : locale.languageCode;
              
              final isSelected = languageProvider.locale == locale;
              
              return PopupMenuItem<Locale>(
                value: locale,
                child: Row(
                  children: [
                    // 语言图标
                    _buildLanguageIcon(locale),
                    const SizedBox(width: 12),
                    // 语言名称
                    Expanded(
                      child: Text(
                        LanguageProvider.languageNames[languageCode] ?? 'Unknown',
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Theme.of(context).primaryColor : null,
                        ),
                      ),
                    ),
                    // 选中标记
                    if (isSelected)
                      Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                  ],
                ),
              );
            }).toList();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language,
                  color: Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  languageProvider.currentLanguageName,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 构建语言图标
  Widget _buildLanguageIcon(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        if (locale.countryCode == 'TW') {
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '繁',
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '简',
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      case 'en':
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'EN',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      default:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.language,
            size: 16,
            color: Colors.grey[600],
          ),
        );
    }
  }
}

/// 简单的语言选择对话框
class LanguageSelectorDialog extends StatelessWidget {
  const LanguageSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return AlertDialog(
          title: Text(LocalizationService.I.setting.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: LanguageProvider.supportedLocales.map((Locale locale) {
              final String languageCode = locale.countryCode != null 
                  ? '${locale.languageCode}_${locale.countryCode}'
                  : locale.languageCode;
              
              final isSelected = languageProvider.locale == locale;
              
              return ListTile(
                leading: _buildLanguageIcon(locale),
                title: Text(
                  LanguageProvider.languageNames[languageCode] ?? 'Unknown',
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                onTap: () {
                  languageProvider.changeLanguage(locale);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocalizationService.I.setting.close),
            ),
          ],
        );
      },
    );
  }

  /// 构建语言图标
  Widget _buildLanguageIcon(Locale locale) {
    switch (locale.languageCode) {
      case 'zh':
        if (locale.countryCode == 'TW') {
          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                '繁',
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                '简',
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      case 'en':
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'EN',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      default:
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.language,
            size: 20,
            color: Colors.grey[600],
          ),
        );
    }
  }
}