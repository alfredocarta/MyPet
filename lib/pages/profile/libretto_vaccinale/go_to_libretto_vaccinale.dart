import 'package:flutter/material.dart';

class GoToLibVacc extends StatelessWidget {
  const GoToLibVacc({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Libretto vaccinale',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.edit),
          ),
        ),
        
      ],
    );
  }
}