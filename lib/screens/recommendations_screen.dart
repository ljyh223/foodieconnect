import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../data/models/user_recommendation_model.dart';
import '../presentation/providers/recommendation_provider.dart';
import '../presentation/widgets/recommended_user_card.dart';

/// 推荐发现页面
class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialRecommendations();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，实现无限滚动
  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = 200.0; // 距离底部200px时开始加载

    if (maxScroll - currentScroll <= delta) {
      _loadMoreRecommendations();
    }
  }

  /// 加载初始推荐
  Future<void> _loadInitialRecommendations() async {
    final provider = Provider.of<RecommendationProvider>(
      context,
      listen: false,
    );

    // 强制刷新，忽略首页缓存的数据
    await provider.refreshRecommendations();
  }

  /// 加载更多推荐
  Future<void> _loadMoreRecommendations() async {
    final provider = Provider.of<RecommendationProvider>(
      context,
      listen: false,
    );

    if (!provider.isLoading && provider.hasMore) {
      await provider.loadMoreRecommendations();
    }
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    try {
      final provider = Provider.of<RecommendationProvider>(
        context,
        listen: false,
      );
      await provider.refreshRecommendations();
    } catch (e) {
      // 错误已在Provider中处理
    }
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 64,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            t.app.noRecommendations,
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.app.searchingRecommendations,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _onRefresh, child: Text(t.app.retry)),
        ],
      ),
    );
  }

  /// 构建错误状态
  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            t.app.loadingFailed,
            style: AppTextStyles.titleMedium.copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _onRefresh, child: Text(t.app.retry)),
        ],
      ),
    );
  }

  /// 构建加载状态
  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  /// 构建推荐列表
  Widget _buildRecommendationsList(List<UserRecommendation> recommendations) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount:
            recommendations.length +
            (Provider.of<RecommendationProvider>(context).hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < recommendations.length) {
            final recommendation = recommendations[index];
            return RecommendedUserCard(recommendation: recommendation);
          } else {
            // 底部加载指示器
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Consumer<RecommendationProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return Text(
                      t.app.noMoreRecommendations,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  /// 构建筛选选项
  Widget _buildFilterOptions() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 筛选按钮
          OutlinedButton.icon(
            onPressed: _showFilterDialog,
            icon: const Icon(
              Icons.filter_list,
              size: 16,
              color: AppColors.onSurface,
            ),
            label: Text(
              t.app.filter,
              style: TextStyle(color: AppColors.onSurface),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              foregroundColor: AppColors.onSurface,
            ),
          ),

          const SizedBox(width: 12),

          // 排序按钮
          OutlinedButton.icon(
            onPressed: _showSortDialog,
            icon: const Icon(Icons.sort, size: 16, color: AppColors.onSurface),
            label: Text(
              t.app.sort,
              style: TextStyle(color: AppColors.onSurface),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              foregroundColor: AppColors.onSurface,
            ),
          ),

          const Spacer(),

          // 统计信息
          Consumer<RecommendationProvider>(
            builder: (context, provider, child) {
              return Text(
                t.app.totalRecommendations(count: provider.recommendations.length),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// 显示筛选对话框
  void _showFilterDialog() {
    final filterByStatus = t.app.filterByStatus;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          filterByStatus,
          style: TextStyle(color: AppColors.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption(t.app.all, null),
            _buildFilterOption(t.app.unviewed, RecommendationStatus.unviewed),
            _buildFilterOption(t.app.viewed, RecommendationStatus.viewed),
            _buildFilterOption(
              t.app.interested,
              RecommendationStatus.interested,
            ),
            _buildFilterOption(
              t.app.notInterested,
              RecommendationStatus.notInterested,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              t.app.cancel,
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建筛选选项
  Widget _buildFilterOption(
    String title,
    RecommendationStatus? selectedStatus,
  ) {
    return Consumer<RecommendationProvider>(
      builder: (context, provider, child) {
        return RadioListTile<RecommendationStatus?>(
          title: Text(title, style: TextStyle(color: AppColors.onSurface)),
          value: selectedStatus,
          groupValue: provider.filterStatus,
          onChanged: (value) {
            Navigator.of(context).pop();
            provider.setFilterStatus(value);
          },
        );
      },
    );
  }

  /// 显示排序对话框
  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(t.app.sortBy, style: TextStyle(color: AppColors.onSurface)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSortOption(t.app.sortByScore, 'score'),
            _buildSortOption(t.app.sortByTime, 'createdAt'),
            _buildSortOption(t.app.sortByViewTime, 'viewedAt'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              t.app.cancel,
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建排序选项
  Widget _buildSortOption(String title, String sortBy) {
    return Consumer<RecommendationProvider>(
      builder: (context, provider, child) {
        return RadioListTile<String>(
          title: Text(title, style: TextStyle(color: AppColors.onSurface)),
          value: sortBy,
          groupValue: provider.sortBy,
          onChanged: (value) {
            Navigator.of(context).pop();
            provider.setSortBy(value!);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.app.recommendations),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          // 清除所有推荐按钮
          IconButton(
            onPressed: _showClearAllDialog,
            icon: const Icon(Icons.clear_all),
            tooltip: t.app.clearAllRecommendations,
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: Consumer<RecommendationProvider>(
        builder: (context, provider, child) {
          // 显示错误状态
          if (provider.error != null && provider.recommendations.isEmpty) {
            return _buildErrorState(provider.error!);
          }

          // 显示加载状态
          if (provider.isLoading && provider.recommendations.isEmpty) {
            return _buildLoadingState();
          }

          // 显示空状态
          if (provider.recommendations.isEmpty && !provider.isLoading) {
            return _buildEmptyState();
          }

          // 显示推荐列表
          return Column(
            children: [
              _buildFilterOptions(),
              Expanded(
                child: _buildRecommendationsList(
                  provider.processedRecommendations,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 显示清除所有推荐对话框
  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          t.app.clearAll,
          style: TextStyle(color: AppColors.onSurface),
        ),
        content: Text(
          t.app.clearAllConfirm,
          style: TextStyle(color: AppColors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              t.app.cancel,
              style: TextStyle(color: AppColors.primary),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final provider = Provider.of<RecommendationProvider>(
                context,
                listen: false,
              );
              await provider.clearAllRecommendations();
            },
            child: Text(
              t.app.confirm,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
