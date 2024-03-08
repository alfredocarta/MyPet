import 'package:app/pages/center_page.dart';
import 'package:flutter/material.dart';
import 'package:app/components/bottom_nav_bar.dart';
import 'package:app/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // Metodo per effettuare il logout dell'utente
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0; // Imposta l'indice iniziale su 0 (corrispondente a ProfilePage)

  void navigateBottomBar(int index) {
    setState(() {
        _selectedIndex = index;
    });
  }

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
        onTabChange: navigateBottomBar, 
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const CenterPage(),
          ProfilePage(
            onTap: () {
              // Logica per il tap all'interno di ProfilePage
            },
          ),
        ],
      ),
    );
  }
}
