import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final VoidCallback? onBackPressed;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.titleLarge.copyWith(
          color: titleColor ?? AppColors.onSurface,
        ),
      ),
      centerTitle: false,
      elevation: 0, // 扁平化设计，无阴影
      backgroundColor: backgroundColor ?? AppColors.surface,
      surfaceTintColor: Colors.transparent, // 移除表面着色
      automaticallyImplyLeading: false, // 禁用自动添加返回按钮
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.onSurface,
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      actions: actions,
      // 添加底部边框以增强扁平化设计的层次感
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.outlineVariant,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}