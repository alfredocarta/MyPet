import 'package:app/pages/navigazione/navigation_menu.dart';
import 'package:app/pages/login/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          // user is logged in
          if ( snapshot.hasData ) {
            return NavigationMenu();
          }
          // user is not logged id
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}