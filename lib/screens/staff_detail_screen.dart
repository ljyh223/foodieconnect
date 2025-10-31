import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/models/staff_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../presentation/widgets/card_widget.dart';
import '../core/services/staff_service.dart';
import '../core/services/api_service.dart';

class StaffDetailScreen extends StatefulWidget {
  final String? staffId;

  const StaffDetailScreen({super.key, this.staffId});

  @override
  State<StaffDetailScreen> createState() => _StaffDetailScreenState();
}

class _StaffDetailScreenState extends State<StaffDetailScreen> {
  late Future<Staff> _staffFuture;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStaff();
  }

  Future<void> _loadStaff() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final staffId = widget.staffId ?? (ModalRoute.of(context)?.settings.arguments as Map?)?['staffId'] as String?;
      if (staffId != null) {
        _staffFuture = StaffService.getById(staffId);
      } else {
        throw Exception('缺少店员ID');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void startChat(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/chat',
      arguments: {'staffId': widget.staffId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: '店员详情',
        showBackButton: true,
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('加载失败：$_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadStaff,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<Staff>(
      future: _staffFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('获取店员详情失败：${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadStaff,
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        final staff = snapshot.data;
        if (staff == null) {
          return const Center(child: Text('店员信息不存在'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: staff.avatarUrl != null && staff.avatarUrl!.isNotEmpty
                            ? Image.network(
                                ApiService.getFullImageUrl(staff.avatarUrl),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text(
                                      staff.name.isNotEmpty ? staff.name.substring(0, 1) : '',
                                      style: TextStyle(
                                        color: AppColors.onPrimaryContainer,
                                        fontSize: 48,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  staff.name.isNotEmpty ? staff.name.substring(0, 1) : '',
                                  style: TextStyle(
                                    color: AppColors.onPrimaryContainer,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      staff.name,
                      style: AppTextStyles.headlineSmall,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          staff.position,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getStatusColor(staff.status),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getStatusText(staff.status),
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${staff.experience}经验 · 评分 ${staff.rating}/5.0',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => startChat(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            '立即咨询',
                            style: AppTextStyles.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '专业技能',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: staff.skills.map((skill) {
                        return Chip(
                          label: Text(skill),
                          backgroundColor: AppColors.secondaryContainer,
                          labelStyle: TextStyle(
                            color: AppColors.onSecondaryContainer,
                            fontSize: 14,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '语言能力',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: staff.languages.map((language) {
                        return Chip(
                          label: Text(language),
                          backgroundColor: AppColors.tertiaryContainer,
                          labelStyle: TextStyle(
                            color: AppColors.onTertiaryContainer,
                            fontSize: 14,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (staff.reviews.isNotEmpty)
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '顾客评价',
                        style: AppTextStyles.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      ...staff.reviews.map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review.userName,
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                  Text(
                                    _buildRatingStars(review.rating),
                                    style: TextStyle(
                                      color: AppColors.ratingStar,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                review.content,
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'ONLINE':
        return '在线';
      case 'OFFLINE':
        return '离线';
      case 'BUSY':
        return '忙碌';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'ONLINE':
        return AppColors.onlineStatus;
      case 'OFFLINE':
        return AppColors.offlineStatus;
      case 'BUSY':
        return AppColors.busy;
      default:
        return AppColors.offlineStatus;
    }
  }

  String _buildRatingStars(double rating) {
    String stars = '';
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars += '★';
      } else {
        stars += '☆';
      }
    }
    return stars;
  }
}