import 'package:app/components/button/home_button.dart';
import 'package:app/components/button/phone_button.dart';
import 'package:app/pages/home/Eventi/booking_screen.dart';
import 'package:app/pages/home/chat_page.dart';
import 'package:app/pages/home/food/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users");
  DateTime? nextBooking;

  @override
  void initState() {
    super.initState();
    fetchNextBooking();
  }

  Future<void> fetchNextBooking() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userEmail = user.email!;

        // Query per ottenere le prenotazioni dell'utente corrente ordinate per data
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('userEmail', isEqualTo: userEmail)
            .orderBy('bookingStart')
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var nextBookingData = querySnapshot.docs.first.data() as Map<String, dynamic>;
          setState(() {
            nextBooking = (nextBookingData['bookingStart'] as Timestamp).toDate();
          });
        }
      }
    } catch (error) {
      print('Error fetching next booking: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Column(
                children: [
                  const Divider(),

                  // Aggiungi il promemoria per la prossima prenotazione
                  nextBooking != null
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
                          ),
                          padding: const EdgeInsets.only(left: 15, bottom: 12, top: 12, right: 15),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prossima prenotazione:',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Colors.grey[800],),
                                  ),
                                  Text(
                                    DateFormat.yMMMMd('it_IT').add_Hm().format(nextBooking!),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Nessuna prenotazione futura trovata',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),

                  HomeButton(
                    sectionName: 'Non sei prenotato?',
                    text: 'Effettua una prenotazione',
                    icon: Icons.event,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookingCalendarDemoApp()),
                      );
                    },
                  ),

                  const PhoneNumberButton(
                    phoneNumber: '3348343186',
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: HomeButton(
                          sectionName: 'Note',
                          text: 'Aggiungi una nota',
                          icon: Icons.note_add,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MyFood()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  

                ],
              ),
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
