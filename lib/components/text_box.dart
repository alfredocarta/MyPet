import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  final TextEditingController? controller;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),

              // edit button
              IconButton(
                onPressed: onPressed, 
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
          //text
          if (controller != null) // Controlla se il controller è stato fornito
            TextFormField(
              controller: controller, // Usa il controller fornito
              readOnly: true, // Impedisce all'utente di modificare direttamente il testo
              decoration: InputDecoration(
                hintText: text,
                border: InputBorder.none,
              ),
            ),
          if (controller == null) // Se il controller non è stato fornito, mostra solo il testo
            Text(text),
        ],
      ),
    );
  }
}