import 'package:flutter/material.dart';
import 'package:tabletalk/core/services/localization_service.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../data/models/staff_model.dart';
import '../presentation/widgets/app_bar_widget.dart';
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
  List<StaffReview> _reviews = [];
  bool _isLoadingReviews = false;
  int _reviewPage = 0;
  final int _reviewPageSize = 5;

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
      final staffId =
          widget.staffId ??
          (ModalRoute.of(context)?.settings.arguments as Map?)?['staffId']
              as String?;
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

  /// 加载店员评价
  Future<void> _loadStaffReviews(
    String staffId, {
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      setState(() {
        _reviewPage = 0;
        _isLoadingReviews = true;
      });
    } else {
      setState(() {
        _isLoadingReviews = true;
      });
    }

    try {
      final newReviews = await StaffService.getStaffReviews(
        staffId,
        page: _reviewPage,
        size: _reviewPageSize,
      );

      setState(() {
        if (isRefresh) {
          _reviews = newReviews;
        } else {
          _reviews.addAll(newReviews);
        }
        _reviewPage++;
      });
    } catch (e) {
      debugPrint('加载店员评价失败: $e');
    } finally {
      setState(() {
        _isLoadingReviews = false;
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
      appBar: AppBarWidget(title: LocalizationService.I.staff.staffDetails, showBackButton: true),
      body: SafeArea(child: _buildContent()),
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
            ElevatedButton(onPressed: _loadStaff, child: Text(LocalizationService.I.app.retry)),
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
                Text('${LocalizationService.I.staff.getStaffDetailsFailed}${snapshot.error}'),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: _loadStaff, child: Text(LocalizationService.I.app.retry)),
              ],
            ),
          );
        }

        final staff = snapshot.data;
        if (staff == null) {
          return Center(child: Text(LocalizationService.I.staff.staffInfoNotExists));
        }

        // 加载店员评价
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_reviews.isEmpty && !_isLoadingReviews) {
            _loadStaffReviews(staff.id, isRefresh: true);
          }
        });

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo is ScrollEndNotification &&
                !_isLoadingReviews &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 100) {
              _loadStaffReviews(staff.id);
            }
            return false;
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 大圆形头像 - 屏幕宽度的2/3
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    height: MediaQuery.of(context).size.width * 2 / 3,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child:
                          staff.avatarUrl != null && staff.avatarUrl!.isNotEmpty
                          ? Image.network(
                              ApiService.getFullImageUrl(staff.avatarUrl),
                              width: MediaQuery.of(context).size.width * 2 / 3,
                              height: MediaQuery.of(context).size.width * 2 / 3,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    staff.name.isNotEmpty
                                        ? staff.name.substring(0, 1)
                                        : '',
                                    style: TextStyle(
                                      color: AppColors.onPrimaryContainer,
                                      fontSize:
                                          MediaQuery.of(context).size.width / 6,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                staff.name.isNotEmpty
                                    ? staff.name.substring(0, 1)
                                    : '',
                                style: TextStyle(
                                  color: AppColors.onPrimaryContainer,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 3行文字说明信息
                Column(
                  children: [
                    Text(
                      staff.name,
                      style: AppTextStyles.headlineSmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      staff.position,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${LocalizationService.I.restaurant.rating} ${staff.rating}/5.0 · ${staff.experience}${LocalizationService.I.staff.experience}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // 用户评价列表
                if (_reviews.isNotEmpty) ...[
                  Row(
                    children: [
                      Text(
                        LocalizationService.I.review.userReviews,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        LocalizationService.I.review.reviewCount(_reviews.length),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._reviews.map((review) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 用户头像（带占位符）
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: review.userAvatar != null && review.userAvatar!.isNotEmpty
                                      ? Image.network(
                                          ApiService.getFullImageUrl(review.userAvatar!),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return _buildUserAvatarPlaceholder(review.userName);
                                          },
                                        )
                                      : _buildUserAvatarPlaceholder(review.userName),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // 用户名和评分
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          review.userName,
                                          style: AppTextStyles.bodyMedium.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          _buildRatingStars(review.rating),
                                          style: TextStyle(
                                            color: AppColors.ratingStar,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(review.content, style: AppTextStyles.bodyMedium),
                          const SizedBox(height: 4),
                          Text(
                            review.createdAt.toIso8601String().split('T')[0],
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  if (_isLoadingReviews)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ],
            ),
          ),
        );
      },
    );
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

  /// 构建用户头像占位符
  Widget _buildUserAvatarPlaceholder(String userName) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          userName.isNotEmpty ? userName.substring(0, 1) : '',
          style: TextStyle(
            color: AppColors.onPrimaryContainer,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
