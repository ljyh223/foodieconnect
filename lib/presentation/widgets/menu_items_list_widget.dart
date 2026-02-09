import 'package:flutter/material.dart';
import 'package:foodieconnect/generated/translations.g.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/api_service.dart';
import '../../data/models/menu_item_model.dart';
import 'card_widget.dart';

/// 菜品列表组件
class MenuItemsListWidget extends StatefulWidget {
  final String restaurantId;
  final String? selectedMenuItemId;
  final Function(String menuItemId, String itemName)? onItemSelected;

  const MenuItemsListWidget({
    super.key,
    required this.restaurantId,
    this.selectedMenuItemId,
    this.onItemSelected,
  });

  @override
  State<MenuItemsListWidget> createState() => _MenuItemsListWidgetState();
}

class _MenuItemsListWidgetState extends State<MenuItemsListWidget> {
  List<MenuItem> _menuItems = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // TODO: 从API获取菜品列表
      // final menuItems = await MenuItemApi.getMenuItems(widget.restaurantId);
      // 临时使用空列表
      setState(() {
        _menuItems = [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('加载失败: $_error', style: AppTextStyles.bodySmall),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _loadMenuItems,
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      );
    }

    if (_menuItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            '菜品列表',
            style: AppTextStyles.titleMedium,
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _menuItems.length,
            itemBuilder: (context, index) {
              final item = _menuItems[index];
              final isSelected = widget.selectedMenuItemId == item.id.toString();
              return _buildMenuItemCard(item, isSelected);
            },
          ),
        ),
        const Divider(height: 32, thickness: 1),
      ],
    );
  }

  Widget _buildMenuItemCard(MenuItem item, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (widget.onItemSelected != null) {
          widget.onItemSelected!(item.id.toString(), item.name);
        }
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          elevation: isSelected ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 菜品图片
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                        ? Image.network(
                            ApiService.getFullImageUrl(item.imageUrl!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.surfaceVariant,
                                child: Center(
                                  child: Text(
                                    item.name.isNotEmpty ? item.name[0] : '',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: AppColors.surfaceVariant,
                            child: Center(
                              child: Text(
                                item.name.isNotEmpty ? item.name[0] : '',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 8),
                // 菜品名称
                Text(
                  item.name,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // 价格
                Text(
                  '¥${item.price.toStringAsFixed(0)}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // 评分
                if (item.rating != null && item.rating! > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.rating!.toStringAsFixed(1),
                        style: AppTextStyles.bodySmall,
                      ),
                      if (item.reviewCount != null && item.reviewCount! > 0)
                        Text(
                          ' (${item.reviewCount})',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
