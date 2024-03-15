import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSignOut;

  const CustomAppBar({super.key, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[900],
      title: const Text("Romeo"),
      actions: [
        IconButton(
          onPressed: onSignOut,
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
