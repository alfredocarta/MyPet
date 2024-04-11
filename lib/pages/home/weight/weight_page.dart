import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/components/appbar/back_app_bar.dart';
import 'package:app/pages/home/weight/weight_column.dart';
import 'package:app/pages/home/weight/weight_column_circle.dart';

class MyWeight extends StatefulWidget {
  final String currentWeight;

  const MyWeight({
    super.key,
    required this.currentWeight,
  });

  @override
  State<MyWeight> createState() => _MyWeightState();
}

class _MyWeightState extends State<MyWeight> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");

  String currentWeight = '';

  @override
  void initState() {
    super.initState();
    // Inizializza currentWeight con il peso attuale dal widget o da Firestore
    currentWeight = widget.currentWeight;
    // Aggiorna currentWeight quando ricevi un aggiornamento dallo stream Firestore
    FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        setState(() {
          currentWeight = userData['peso'] ?? widget.currentWeight;
        });
      }
    });
  }

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
      backgroundColor: Colors.grey[100],
      appBar: const BackAppBar(
        title: Text(
          'MyPet',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editField('peso');
        },
        backgroundColor: Colors.grey[900],
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: ListView(
        children: [
          const Divider(),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Weight Tracker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[400]!),
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WeightColumn(
                  weight: '3',
                  label: 'Peso Iniziale',
                ),
                WeightColumnCircle(
                  currentWeight: currentWeight,
                  label: 'Peso Attuale',
                ),
                const WeightColumn(
                  weight: '6',
                  label: 'Peso Obiettivo',
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[100],
            width: double.infinity,
            height: 550,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  Text(
                    'Statistiche',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
