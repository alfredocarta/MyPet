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
  final userCollection = FirebaseFirestore.instance.collection("Users"); 

  Future<void> editField(String field) async {
    String newValue = "";
    String hintText = "Inserisci nuovo $field";
    if (field == "nomeAnimale") {
      hintText = "Come si chiama il tuo animale?";
    }
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
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Linea orizzontale
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Linea orizzontale
            ),
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
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) { 
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const Divider(),
                                
                // Nome
                MyTextBox(
                  text: userData['nome'], 
                  sectionName: 'Nome',
                  onPressed: () => editField('nome'),
                ),

                // Cognome
                MyTextBox(
                  text: userData['cognome'], 
                  sectionName: 'Cognome',
                  onPressed: () => editField('cognome'),
                ),

                // Nome dell'animale
                MyTextBox(
                  text: userData['nomeAnimale'], 
                  sectionName: 'Come si chiama il tuo animale?',
                  onPressed: () => editField('nomeAnimale'),
                ),

                // Data di nascita dell'animale
                MyTextBox(
                  text: userData['dataNascita'], 
                  sectionName: 'Quando è nato il tuo animale?',
                  onPressed: () => editField('dataNascita'),
                ),

                // microchip dell'animale
                MyTextBox(
                  text: userData['microchip'], 
                  sectionName: 'Microchip',
                  onPressed: () => editField('microchip'),
                ),

                // genere dell'animale
                MyTextBox(
                  text: userData['genere'], 
                  sectionName: 'Genere',
                  onPressed: () => editField('genere'),
                ),

                // razza dell'animale
                MyTextBox(
                  text: userData['razza'], 
                  sectionName: 'Razza',
                  onPressed: () => editField('razza'),
                ),

                // mantello dell'animale
                MyTextBox(
                  text: userData['mantello'], 
                  sectionName: 'Mantello',
                  onPressed: () => editField('mantello'),
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