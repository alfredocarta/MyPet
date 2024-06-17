import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:booking_calendar/booking_calendar.dart'; // Assicurati di importare il corretto pacchetto per il calendario

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({Key? key}) : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DateTimeRange> bookedSlots = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('it_IT', null).then((_) {
      setState(() {});
    });

    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );

    // Recupera le prenotazioni da Firestore quando la pagina si apre
    retrieveBookingsFromFirestore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    retrieveBookingsFromFirestore();
  }

  Future<void> retrieveBookingsFromFirestore() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userEmail = user.email!;

        // Query Firestore per recuperare le prenotazioni dell'utente
        final querySnapshot = await firestore
            .collection('bookings')
            .where('userEmail', isEqualTo: userEmail)
            .get();

        final List<DateTimeRange> bookings = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final DateTime start = (data['bookingStart'] as Timestamp).toDate();
          final DateTime end = (data['bookingEnd'] as Timestamp).toDate();
          return DateTimeRange(start: start, end: end);
        }).toList();

        setState(() {
          bookedSlots = bookings;
        });

        print('Prenotazioni recuperate da Firestore con successo: $bookedSlots');
      }
    } catch (error) {
      print('Errore durante il recupero delle prenotazioni da Firestore: $error');
    }
  }

  Stream<dynamic>? getBookingStreamMock({required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock({required BookingService newBooking}) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userEmail = user.email!;
        final userData = await firestore.collection('Users').doc(userEmail).get();
        final userName = userData['username'];
        final nome = userData['nome'];
        final cognome = userData['cognome'];

        // Crea un documento per la nuova prenotazione in Firestore
        await firestore.collection('bookings').add({
          'userEmail': userEmail,
          'userName': userName,
          'nome': nome,
          'cognome': cognome,
          'bookingStart': newBooking.bookingStart,
          'bookingEnd': newBooking.bookingEnd,
        });

        setState(() {
          bookedSlots.add(DateTimeRange(start: newBooking.bookingStart, end: newBooking.bookingEnd));
        });

        final vetEmail = 'cartaalfredo@gmail.com';
        final bookingDate = DateFormat.yMMMMd('it_IT').format(newBooking.bookingStart);

        await sendEmailToVet(vetEmail, nome, cognome, bookingDate);

        print('Appuntamento prenotato con successo.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appuntamento prenotato con successo!'),
          ),
        );
      } else {
        print('Utente non registrato.');
      }
    } catch (error) {
      print('Errore durante l\'upload della prenotazione su Firestore: $error');
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> sendEmailToVet(String vetEmail, String nome, String cognome, String bookingDate) async {
    final Email email = Email(
      body: 'Ciao,\n\nHai una richiesta di appuntamento da $nome $cognome per il $bookingDate.\n\nCordiali saluti,\nL\'app MyPet',
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

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    List<DateTimeRange> allSlots = [
      // Aggiungi altri slot se necessario
    ];

    allSlots.addAll(bookedSlots); // Aggiungi gli slot prenotati

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
      appBar: AppBar(
        title: Text(
          'MyPet',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            // Torna indietro alla homepage e passa eventuali dati aggiornati
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: BookingCalendar(
          bookingService: mockBookingService,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'Pranzo',
          hideBreakTime: false,
          loadingWidget: const Text('Caricamento dati...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'it_IT', // Imposta la localizzazione italiana
          startingDayOfWeek: StartingDayOfWeek.monday,
          wholeDayIsBookedWidget: const Text('Spiacenti, tutto è prenotato per questo giorno'),
          availableSlotText: 'Disponibile',
          selectedSlotText: 'Selezionato',
          bookedSlotText: 'Prenotato',
          bookingButtonText: 'Prenota',
        ),
      ),
    );
  }
}
