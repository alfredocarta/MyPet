import 'package:app/components/appbar/back_app_bar.dart';
import 'package:app/services/firestore.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart'; // Importa la libreria per l'invio di e-mail

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({Key? key}) : super(key: key);
  
  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  final FirestoreService firestoreService = FirestoreService();
  List<DateTimeRange> bookedSlots = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );

    // Recupera le prenotazioni da Firestore quando la pagina si apre
    retrieveBookingsFromFirestore();
  }

  Future<void> retrieveBookingsFromFirestore() async {
    try {
      List<DateTimeRange> bookings = await firestoreService.fetchBookingsFromFirestore();

      setState(() {
        bookedSlots = bookings;
      });

      print('Bookings retrieved from Firestore successfully: $bookedSlots');
    } catch (error) {
      print('Error retrieving bookings from Firestore: $error');
    }
  }

  Stream<dynamic>? getBookingStreamMock({required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock({required BookingService newBooking}) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String userEmail = user.email!;

        // Recupera i dati dell'utente da Firestore
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection('Users').doc(userEmail).get();
        String userName = userData['username']; // Assumendo che il nome dell'utente sia memorizzato nel campo 'username' nel documento dell'utente

        // Crea un nuovo documento per la prenotazione
        await FirebaseFirestore.instance.collection('bookings').add({
          'userEmail': userEmail,
          'userName': userName,
          'bookingStart': newBooking.bookingStart,
          'bookingEnd': newBooking.bookingEnd,
          // Aggiungi altri dettagli della prenotazione se necessario
        });

        setState(() {
          bookedSlots.add(DateTimeRange(start: newBooking.bookingStart, end: newBooking.bookingEnd));
        });

        String vetEmail = 'od3rfl401@gmail.com'; // Indirizzo e-mail del veterinario
        DateTime bookingDate = newBooking.bookingStart; // Data della prenotazione

        await sendEmailToVet(vetEmail, userName, bookingDate);

        print('Booking uploaded successfully.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Prenotazione completata con successo!'),
          ),
        );
      } else {
        print('User is not logged in.');
      }
    } catch (error) {
      print('Error uploading booking to Firestore: $error');
    }
  }


  Future<void> sendEmailToVet(String vetEmail, String userName, DateTime bookingDate) async {
    final Email email = Email(
      body: 'Ciao,\n\nHai una nuova prenotazione da $userName per il $bookingDate.\n\nCordiali saluti,\nL\'app MyPet',
      subject: 'Nuova prenotazione',
      recipients: [vetEmail],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      print('E-mail inviata con successo al veterinario.');
    } catch (error) {
      print('Errore durante l\'invio dell\'e-mail al veterinario: $error');
    }
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
  List<DateTimeRange> allSlots = [
    // Aggiungi qui gli altri slot generati
  ];

  // Aggiungi gli slot prenotati recuperati da Firestore
  allSlots.addAll(bookedSlots);

  return allSlots;
}

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(start: DateTime(now.year, now.month, now.day, 12, 0), end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
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
        body: Center(
          child: BookingCalendar(
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            pauseSlots: generatePauseSlots(),
            pauseSlotText: 'PRANZO',
            hideBreakTime: false,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const CircularProgressIndicator(),
            locale: 'hu_HU',
            startingDayOfWeek: StartingDayOfWeek.tuesday,
            wholeDayIsBookedWidget: const Text('Sorry, for this day everything is booked'),
          ),
        ),
      );
  }
}
