import 'package:app/components/back_app_bar.dart';
import 'package:app/components/text_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _birthDateController = TextEditingController();

  // edit field
  Future<void> editField(String field) async {}

  @override
  void initState() {
    super.initState();
    _birthDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Text('Scheda biografica'),
      ),
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          const SizedBox(height: 50),

          const Icon(
            Icons.person,
            size: 72,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Scheda biografica',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          // Nome
          MyTextBox(
            text: 'Inserisci il nome del tuo animale', 
            sectionName: 'Nome', 
            onPressed: () => editField('nome'),
          ),

          // Data di nascita
          MyTextBox(
            text: 'Inserisci la data di nascita del tuo animale', 
            sectionName: 'Data di Nascita', 
            onPressed: () => editField('data'),
            controller: _birthDateController, // Utilizza il controller per la data di nascita
          ),
        ],
      ),
    );
  }
}

/* body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileMenu(
                title: 'Nome',
                value: 'Romeo',
                onPressed: () {},
              ),
              const SizedBox(height: 10), // Aggiungi spazio tra i due ProfileMenu
              ProfileMenu(
                title: 'D. nascita',
                value: '08/10/2001',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ), */