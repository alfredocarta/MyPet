import 'package:app/pages/center_page.dart';
import 'package:flutter/material.dart';
import 'package:app/components/bottom_nav_bar.dart';
import 'package:app/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0; // Imposta l'indice iniziale su 0 (corrispondente a ProfilePage)

  void navigateBottomBar(int index) {
    setState(() {
        _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const CenterPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text("Romeo"),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(index), 
      ),
      body: _pages[_selectedIndex],
    );
  }
}
