import 'package:app/components/back_app_bar.dart';
import 'package:app/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  final userCollection = FirebaseFirestore.instance.collection("users"); 

  Future<void> editField(BuildContext context, String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Modifica $field",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Inserisci nuovo $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancella
          TextButton(
            child: const Text('Cancella', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),

          // salva
          TextButton(
            child: const Text('Salva', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    // aggiorna su firestore
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Text('Scheda biografica'),
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) { // Check if snapshot has data and it's not null
            final userData = snapshot.data!.data() as Map<String, dynamic>?;

            return ListView(
              children: [
                const SizedBox(height: 25),

                const Icon(
                  Icons.person,
                  size: 72,
                ),

                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Scheda biografica',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

                // username
                MyTextBox(
                  text: userData?['email'] ?? '', // Use null-aware operator and null check
                  sectionName: 'Username',
                  onPressed: () => editField(context, 'email'),
                ),

                // Nome
                MyTextBox(
                  text: userData?['nome'] ?? '', // Use null-aware operator and null check
                  sectionName: 'Nome',
                  onPressed: () => editField(context, 'nome'),
                ),

                // Data di nascita
                MyTextBox(
                  text: 'dd/mm/yyyy',
                  sectionName: 'Data di Nascita',
                  onPressed: () => editField(context, 'Data'),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Errore ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}