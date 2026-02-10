import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/menu_item_model.dart';
import '../presentation/providers/menu_item_provider.dart';
import '../presentation/widgets/dish_list_item_widget.dart';

class DishListScreen extends StatefulWidget {
  final String? restaurantId;
  final String? restaurantName;

  const DishListScreen({
    super.key,
    this.restaurantId,
    this.restaurantName,
  });

  @override
  State<DishListScreen> createState() => _DishListScreenState();
}

class _DishListScreenState extends State<DishListScreen> {
  late String _restaurantId;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _restaurantId = widget.restaurantId ??
        (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantId'] as String? ??
        '1';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      _loadCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final provider = Provider.of<MenuItemProvider>(context, listen: false);
    await provider.fetchMenuItems(_restaurantId);
  }

  Future<void> _loadCategories() async {
    final provider = Provider.of<MenuItemProvider>(context, listen: false);
    await provider.fetchCategories(_restaurantId);
  }

  Future<void> _onSearch(String keyword) async {
    final provider = Provider.of<MenuItemProvider>(context, listen: false);
    if (keyword.trim().isEmpty) {
      await provider.fetchMenuItems(_restaurantId);
    } else {
      await provider.searchMenuItems(keyword);
    }
  }

  Future<void> _onCategorySelected(int? categoryId) async {
    final provider = Provider.of<MenuItemProvider>(context, listen: false);
    if (categoryId == null) {
      await provider.fetchMenuItems(_restaurantId);
    } else {
      await provider.fetchItemsByCategory(_restaurantId, categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final restaurantName = widget.restaurantName ??
        (ModalRoute.of(context)?.settings.arguments as Map?)?['restaurantName'] as String?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          restaurantName ?? 'Dishes',
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
      ),
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(),
          // Category filters
          _buildCategoryFilters(),
          // Content
          Expanded(
            child: Consumer<MenuItemProvider>(
              builder: (context, provider, child) {
                // Loading state
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error state
                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '加载失败，请重试',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.error!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (provider.searchKeyword.isNotEmpty) {
                              _onSearch(provider.searchKeyword);
                            } else if (provider.selectedCategoryId != null) {
                              _onCategorySelected(provider.selectedCategoryId);
                            } else {
                              _loadData();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  );
                }

                // Empty state
                if (provider.menuItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          provider.searchKeyword.isNotEmpty
                              ? Icons.search_off
                              : Icons.restaurant_menu,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.searchKeyword.isNotEmpty
                              ? '未找到相关菜品'
                              : '该餐厅暂无菜品',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Success state
                return ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: provider.menuItems.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  itemBuilder: (context, index) {
                    final item = provider.menuItems[index];
                    return DishListItemWidget(
                      item: item,
                      onTap: () => _navigateToDishDetail(item),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Consumer<MenuItemProvider>(
        builder: (context, provider, child) {
          return TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '搜索菜品...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: provider.searchKeyword.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.black),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onSubmitted: _onSearch,
          );
        },
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return Consumer<MenuItemProvider>(
      builder: (context, provider, child) {
        if (provider.categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: provider.categories.length + 1,
            itemBuilder: (context, index) {
              // All items option
              if (index == 0) {
                final isSelected = provider.isAllSelected;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: const Text('全部'),
                    selected: isSelected,
                    onSelected: (_) {
                      _onCategorySelected(null);
                    },
                    backgroundColor: Colors.grey[200],
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide.none,
                    ),
                  ),
                );
              }

              // Category options
              final category = provider.categories[index - 1];
              final isSelected = provider.selectedCategoryId == category.id;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  label: Text(category.name),
                  selected: isSelected,
                  onSelected: (_) {
                    _onCategorySelected(category.id);
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToDishDetail(MenuItem item) {
    Navigator.pushNamed(
      context,
      '/dish_detail',
      arguments: {
        'restaurantId': _restaurantId,
        'dishId': item.id.toString(),
      },
    );
  }
}
