import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({
    super.key,
    this.title,
    this.actions,
    this.loadingIcon,
    this.loadingOnPressed,
    this.showBackArrow = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? loadingIcon;
  final List<Widget>? actions;
  final VoidCallback? loadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      automaticallyImplyLeading: true,
      title: title,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            )
          : loadingIcon != null
              ? IconButton(
                  onPressed: loadingOnPressed,
                  icon: Icon(loadingIcon, color: Colors.white),
                )
              : null,
      
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
