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
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}