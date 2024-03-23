import 'package:flutter/material.dart';

class GoToProfile extends StatelessWidget {
  const GoToProfile({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
          child: FractionallySizedBox(
            widthFactor: 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.arrow_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}