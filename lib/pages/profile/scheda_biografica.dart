import 'package:app/components/bottom_nav_bar.dart';
import 'package:app/pages/center_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:flutter/material.dart';

class SchedaBiografica extends StatefulWidget {
  const SchedaBiografica({super.key});

  @override
  State<SchedaBiografica> createState() => _SchedaBiograficaState();
}

class _SchedaBiograficaState extends State<SchedaBiografica> {
  int _selectedIndex = 1; 

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
      ),
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavBar(
        onTabChange: navigateBottomBar, 
      ),
      
    );
  }
}