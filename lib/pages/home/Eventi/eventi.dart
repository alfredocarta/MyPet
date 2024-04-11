import 'package:app/components/appbar/back_app_bar.dart';
import 'package:flutter/material.dart';

class MyEvent extends StatelessWidget {
  const MyEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const BackAppBar(
        title: Text(
          'MyPet',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Divider(),
    );
  }
}