import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Icons.arrow_right,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title;
  final String value;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Titolo
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15),
              ),
            ),

            const SizedBox(width: 8.0),

            // Valore
            Expanded(
              flex: 2, // Imposta un rapporto di flessione di 2
              child: Center(
                child: Row(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 3.0),

            // Icona
            Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }
}