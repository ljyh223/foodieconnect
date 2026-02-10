import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/menu_item_model.dart';
import '../data/models/dish_review_model.dart';
import '../core/services/api_service.dart';
import '../presentation/providers/dish_review_provider.dart';
import '../presentation/providers/menu_item_provider.dart';
import '../presentation/widgets/dish_review_card.dart';

/// 菜品详情页面
class DishDetailScreen extends StatefulWidget {
  final String restaurantId;
  final String? menuItemId;

  const DishDetailScreen({
    super.key,
    required this.restaurantId,
    this.menuItemId,
  });

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  MenuItem? _dish;
  DishReviewStats? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final menuItemId = widget.menuItemId ?? args?['dishId']?.toString();

    if (menuItemId == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final provider = Provider.of<MenuItemProvider>(context, listen: false);
      final dish = await provider.fetchMenuItemDetail(menuItemId);

      if (dish != null && mounted) {
        setState(() {
          _dish = dish;
          _isLoading = false;
        });
        _loadReviews(menuItemId);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadReviews(String menuItemId) async {
    final reviewProvider = Provider.of<DishReviewProvider>(context, listen: false);
    await reviewProvider.fetchByMenuItem(
      widget.restaurantId,
      menuItemId,
    );
    await reviewProvider.fetchStats(
      widget.restaurantId,
      menuItemId,
    );
    if (mounted) {
      setState(() {
        _stats = reviewProvider.stats;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_dish == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: const Center(
          child: Text('菜品信息加载失败'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildDishImage(),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  if (_stats != null) _buildRatingStats(),
                  const SizedBox(height: 12),
                  if (_dish!.description != null && _dish!.description!.isNotEmpty) ...[
                    Text(
                      _dish!.description!,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  _buildDishInfo(),
                  const SizedBox(height: 24),
                  _buildReviewsHeader(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _buildReviewsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateReview,
        backgroundColor: Colors.black,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        _dish?.name ?? '菜品详情',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildDishImage() {
    String displayImageUrl = '';
    if (_dish?.imageUrl != null && _dish!.imageUrl!.isNotEmpty) {
      displayImageUrl = ApiService.getFullImageUrl(_dish!.imageUrl!);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        displayImageUrl.isNotEmpty
            ? Image.network(
                displayImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
              )
            : _buildPlaceholderImage(),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Text(
          _dish?.name.isNotEmpty == true ? _dish!.name.substring(0, 1) : '',
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            _dish!.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        if (_dish!.price > 0) ...[
          const SizedBox(width: 16),
          Text(
            '¥${_dish!.price.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRatingStats() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 18),
              const SizedBox(width: 4),
              Text(
                _stats!.averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '${_stats!.totalReviews} reviews',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDishInfo() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (_dish!.spiceLevel != null && _dish!.spiceLevel!.isNotEmpty)
          _buildInfoChip(
            _getSpiceLevelIcon(_dish!.spiceLevel!),
            _getSpiceLevelText(_dish!.spiceLevel!),
          ),
        if (_dish!.preparationTime != null && _dish!.preparationTime! > 0)
          _buildInfoChip(Icons.schedule, '${_dish!.preparationTime} min'),
        if (_dish!.calories != null && _dish!.calories! > 0)
          _buildInfoChip(Icons.local_fire_department, '${_dish!.calories} cal'),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF616161)),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSpiceLevelIcon(String level) {
    switch (level.toUpperCase()) {
      case 'NONE':
        return Icons.grain;
      case 'MILD':
        return Icons.whatshot_outlined;
      case 'MEDIUM':
        return Icons.whatshot;
      case 'HOT':
        return Icons.local_fire_department;
      default:
        return Icons.grain;
    }
  }

  String _getSpiceLevelText(String level) {
    switch (level.toUpperCase()) {
      case 'NONE':
        return 'No Spice';
      case 'MILD':
        return 'Mild';
      case 'MEDIUM':
        return 'Medium';
      case 'HOT':
        return 'Hot';
      default:
        return level;
    }
  }

  Widget _buildReviewsHeader() {
    return Row(
      children: [
        const Text(
          'Reviews',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        if (_stats != null)
          Text(
            '${_stats!.totalReviews} reviews',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
      ],
    );
  }

  Widget _buildReviewsList() {
    return Consumer<DishReviewProvider>(
      builder: (context, provider, child) {
        final reviews = provider.reviews;

        if (provider.isLoading && _dish == null) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (reviews.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'No reviews yet',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return DishReviewCard(review: reviews[index]);
            },
            childCount: reviews.length,
          ),
        );
      },
    );
  }

  void _navigateToCreateReview() {
    Navigator.pushNamed(
      context,
      '/create_dish_review',
      arguments: {
        'restaurantId': widget.restaurantId,
        'menuItemId': _dish!.id.toString(),
        'itemName': _dish!.name,
      },
    ).then((_) => _loadData());
  }
}
