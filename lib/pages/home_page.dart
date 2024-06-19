import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:app/components/button/home_button.dart';
import 'package:app/components/button/phone_button.dart';
import 'package:app/pages/booking_screen.dart';
import 'package:app/pages/notes.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        } else {
          setState(() {
            nextBooking = null;
          });
        }
      }
    } catch (error) {
      print('Error fetching next booking: $error');
    }
  }

  void addAppointmentToCalendar(DateTime startTime, DateTime endTime, String title, String description) {
    final Event event = Event(
      title: title,
      description: description,
      startDate: startTime,
      endDate: endTime,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 30),
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // Lista di email degli invitati
      ),
    );

    Add2Calendar.addEvent2Cal(event).then((success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Appuntamento aggiunto al calendario!' : 'Errore durante l\'aggiunta al calendario'),
        ),
      );
    });
  }

  void onTap() {
    if (nextBooking != null) {
      addAppointmentToCalendar(
        nextBooking!, // Inizio dell'appuntamento
        nextBooking!.add(const Duration(minutes: 30)), // Fine dell'appuntamento, aggiungi la durata desiderata
        'Appuntamento dal veterinario', // Titolo dell'evento
        'Dettagli del tuo appuntamento', // Descrizione dell'evento
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nessun appuntamento disponibile'),
        ),
      );
    }
  }

  Future<void> refreshData() async {
    await fetchNextBooking();
    setState(() {}); // Aggiorna lo stato per riflettere i nuovi dati
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Colors.grey, // Imposta il colore del cerchio di aggiornamento a grigio
        onRefresh: refreshData,
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    children: [
                      const Divider(),

                      // Aggiungi il promemoria per la prossima prenotazione
                      nextBooking != null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
                              ),
                              padding: const EdgeInsets.only(left: 15, bottom: 18, top: 18, right: 15),
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Il tuo prossimo appuntamento:',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey[800]),
                                          ),
                                          Text(
                                            DateFormat.yMMMMd('it_IT').add_Hm().format(nextBooking!),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10.0),

                                      GestureDetector(
                                        onTap: onTap,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Aggiungi al Calendario',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                        'Il tuo prossimo appuntamento:',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey[800]),
                                      ),
                                      const Text(
                                        'Non ci sono prenotazioni',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                      const SizedBox(height: 5),

                      HomeButton(
                        sectionName: 'Non hai un appuntamento?',
                        text: 'Prenotalo subito',
                        icon: Icons.event,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BookingCalendarDemoApp()),
                          );
                        },
                      ),

                      const SizedBox(height: 5),

                      const PhoneNumberButton(
                        phoneNumber: '0373 0541106',
                      ),

                      const SizedBox(height: 5),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color.fromARGB(255, 167, 165, 165)),
                        ),
                        padding: const EdgeInsets.only(left: 15, bottom: 18, top: 18, right: 15),
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hai bisogno di annotare qualcosa?',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyNotes()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Aggiungi una nota',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.note_add,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child:
                  Text('Errore ${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
