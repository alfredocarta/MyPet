import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String sectionName;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const HomeButton({
    required this.sectionName,
    required this.text,
    required this.onPressed,
    required this.icon, 
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 12, top: 12, right: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12,
                  ),
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            Icon(
              icon, // Utilizza l'icona specificata nel parametro
              color: Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
