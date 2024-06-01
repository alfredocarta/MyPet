import 'package:app/pages/home_page.dart';
import 'package:app/pages/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            SizedBox(width: 10),
            Text(
              'MyPet',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.grey[500],
            ),
            onPressed: signUserOut,
          ),
          const SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 100, 
          child: BottomNavigationBar(
            backgroundColor: Colors.white, 
            selectedItemColor: Colors.black, 
            unselectedItemColor: Colors.grey, 
            currentIndex: controller.selectedIndex.value,
            onTap: (index) => controller.selectedIndex.value = index,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profilo'),
            ],
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens, 
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomePage(), 
    const ProfileScreen(), 
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}