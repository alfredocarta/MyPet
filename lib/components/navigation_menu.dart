import 'package:app/pages/home_page.dart';
import 'package:app/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // Metodo per effettuare il logout dell'utente
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "MyPet",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 100, // Puoi regolare questo valore secondo le tue esigenze
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[900], 
            selectedItemColor: Colors.white, 
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
          children: controller.screens, // Utilizza gli schermi dal controller di navigazione
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomePage(), 
    const ProfilePage(), 
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}