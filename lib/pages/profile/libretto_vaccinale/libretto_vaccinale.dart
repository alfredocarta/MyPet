import 'package:app/components/appbar/back_app_bar.dart';
import 'package:flutter/material.dart';

class LibVacc extends StatelessWidget {
  const LibVacc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Text(
          'Libretto vaccinale',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}