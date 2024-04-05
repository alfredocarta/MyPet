import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSignOut;

  const CustomAppBar({
    super.key, 
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Romeo",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: onSignOut,
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
