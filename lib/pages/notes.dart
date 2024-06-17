import 'package:app/components/appbar/back_app_bar.dart';
import 'package:app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({super.key});

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {

  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // test controller
  final TextEditingController textController = TextEditingController();
  
  // open a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[100],
        content: TextField(
          controller: textController,
        ),
        actions: [
          // button to save
          ElevatedButton(
            onPressed: () {

              // add a new note
              if ( docID == null ) {
                firestoreService.addNote(textController.text);
              }

              // update an existing note
              else {
                firestoreService.updateNote(docID, textController.text);
              }
 
              // clear the text controller
              textController.clear();

              // close the box
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ), 
            child: const Text(
              "Aggiungi",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      )
    );
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
        onPressed: openNoteBox,
        backgroundColor: Colors.grey[900],
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          // if we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // display as a list tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // update button
                      IconButton(
                      onPressed: () => openNoteBox(docID: docID),
                      icon: const Icon(Icons.settings),
                      ),

                      // delete button
                      IconButton(
                      onPressed: () => firestoreService.deleteNote(docID),
                      icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } 
          
          // if there is no data return nothing
          else {
            return const Text("no notes...");
          }
        },
      ),
    );
  }
}
