import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({
    Key? key,
    this.title,
    this.actions,
    this.loadingIcon,
    this.loadingOnPressed,
    this.showBackArrow = true,
  }) : super(key: key);

  final Widget? title;
  final bool showBackArrow;
  final IconData? loadingIcon;
  final List<Widget>? actions;
  final VoidCallback? loadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[900],
      automaticallyImplyLeading: true,
      leading: null, 
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
