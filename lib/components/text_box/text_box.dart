import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 8, top: 10),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
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

              // edit button
              IconButton(
                onPressed: onPressed, 
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}