import 'package:flutter/material.dart';
import 'package:tabletalk/core/services/localization_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/models/staff_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
import '../core/services/staff_service.dart';
import '../core/services/api_service.dart';

class StaffScreen extends StatefulWidget {
  final String? restaurantId;

  const StaffScreen({super.key, this.restaurantId});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  late Future<List<Staff>> _staffFuture;
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
      final restaurantId = widget.restaurantId ?? (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String?;
      if (restaurantId != null) {
        _staffFuture = StaffService.listByRestaurant(restaurantId);
      } else {
        throw Exception('缺少餐厅ID');
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

  void navigateToStaffDetail(String staffId) {
    Navigator.pushNamed(
      context,
      '/staff_detail',
      arguments: {'staffId': staffId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBarWidget(
        title: LocalizationService.I.staff.staffList,
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildContent(),
        ),
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
            Text('${LocalizationService.I.app.loadingFailed}：$_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadStaff,
              child: Text(LocalizationService.I.app.retry),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<List<Staff>>(
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
                Text('${LocalizationService.I.staff.getStaffListFailed}${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadStaff,
                  child: Text(LocalizationService.I.app.retry),
                ),
              ],
            ),
          );
        }

        final staffList = snapshot.data ?? [];

        if (staffList.isEmpty) {
          return Center(child: Text(LocalizationService.I.staff.noStaff));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: staffList.length,
          itemBuilder: (context, index) {
            final staff = staffList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // 头像
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: staff.avatarUrl != null && staff.avatarUrl!.isNotEmpty
                          ? Image.network(
                              ApiService.getFullImageUrl(staff.avatarUrl),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    staff.name.isNotEmpty ? staff.name.substring(0, 1) : '',
                                    style: TextStyle(
                                      color: AppColors.onPrimaryContainer,
                                      fontSize: 24,
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 名字和职位信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff.name,
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          staff.position,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Review按钮
                  ElevatedButton(
                    onPressed: () => navigateToStaffDetail(staff.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Review',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}