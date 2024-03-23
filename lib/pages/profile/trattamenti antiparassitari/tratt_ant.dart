import 'package:app/components/appbar/back_app_bar.dart';
import 'package:flutter/material.dart';

class TrattAnt extends StatelessWidget {
  const TrattAnt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Text(
          'T. antiparassitari',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}