import 'package:app/components/back_app_bar%20copy.dart';
import 'package:app/pages/profile/profile_menu.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Text('Scheda biografica'),
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileMenu(
                title: 'Nome',
                value: 'Romeo',
                onPressed: () {},
              ),
              const SizedBox(height: 10), // Aggiungi spazio tra i due ProfileMenu
              ProfileMenu(
                title: 'D. nascita',
                value: '08/10/2001',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

