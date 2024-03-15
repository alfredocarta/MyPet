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

  final userCollection = FirebaseFirestore.instance.collection("Users"); 

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
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
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

                // username
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'Username',
                  onPressed: () => editField(context, 'Username'),
                ),

                // Nome
                MyTextBox(
                  text: userData['nome'],
                  sectionName: 'Nome',
                  onPressed: () => editField(context, 'Nome'),
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


/* import 'package:app/components/back_app_bar.dart';
import 'package:app/components/text_box.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final userColletion = Firebase.instance.collection("Users");

  // edit field
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
    if ( newValue.trim().length > 0 ) {
      await userColletion.doc(currentUser.email).update({field: newValue});
    }
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
            text: 'Nome vuoto', 
            sectionName: 'Nome', 
            onPressed: () => editField('Nome'),
          ),

          // Data di nascita
          MyTextBox(
            text: 'dd/mm/yyyy', 
            sectionName: 'Data di Nascita', 
            onPressed: () => editField('Data'),
          ),
        ],
      ),
    );
  }
}
*/
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