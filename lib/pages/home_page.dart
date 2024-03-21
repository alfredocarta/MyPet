import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
    backgroundColor: Colors.grey[100], // Imposta il colore di sfondo della pagina
    body: const Center(
      child: Text('Home'),
    ),
  );
  }
}