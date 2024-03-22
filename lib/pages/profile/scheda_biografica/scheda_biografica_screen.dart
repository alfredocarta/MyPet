import 'package:app/components/back_app_bar.dart';
import 'package:app/components/text_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedaBiograficaScreen extends StatefulWidget {
  const SchedaBiograficaScreen({super.key});
  @override
  State<SchedaBiograficaScreen> createState() => _SchedaBiograficaScreenState();
}

class _SchedaBiograficaScreenState extends State<SchedaBiograficaScreen> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  final userCollection = FirebaseFirestore.instance.collection("Users"); 

  Future<void> editField(String field) async {
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
    if (newValue.trim().length > 0) {
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Text(
          'Scheda biografica',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) { 
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                /*
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

                username
                MyTextBox(
                  text: userData['username'], 
                  sectionName: 'Username',
                  onPressed: () => editField('username'),
                ),*/

                const SizedBox(height: 5),

                // Nome
                MyTextBox(
                  text: userData['nome'], 
                  sectionName: 'Nome',
                  onPressed: () => editField('nome'),
                ),

                // Data di nascita
                MyTextBox(
                  text: userData['dataDiNascita'], 
                  sectionName: 'Data di nascita',
                  onPressed: () => editField('dataDiNascita'),
                ),

                // Mantello
                MyTextBox(
                  text: userData['mantello'], 
                  sectionName: 'Mantello',
                  onPressed: () => editField('mantello'),
                ),

                // Razza
                MyTextBox(
                  text: userData['razza'], 
                  sectionName: 'Razza',
                  onPressed: () => editField('razza'),
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