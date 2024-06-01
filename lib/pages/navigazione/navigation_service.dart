import 'package:flutter/material.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login/login_or_register_page.dart';
import 'package:app/pages/profile_screen.dart';

class NavigationService {
  static void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  static void navigateToLoginOrRegisterPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
    );
  }

  static void navigateToCenterPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

}
