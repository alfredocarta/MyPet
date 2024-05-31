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
      await firestoreService.uploadBookingToFirestore(newBooking);
      setState(() {
        // Aggiorna lo stato per contrassegnare lo slot come "booked"
        // Ad esempio, se `newBooking` contiene le informazioni sull'intervallo di tempo della prenotazione,
        // puoi aggiornare lo stato dell'applicazione per contrassegnare quell'intervallo come "booked".
      });
      print('Booking uploaded successfully.');
    } catch (error) {
      print('Error uploading booking to Firestore: $error');
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
    return MaterialApp(
      title: 'Booking Calendar Demo',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Calendar Demo'),
        ),
        body: Center(
          child: BookingCalendar(
            bookingService: mockBookingService,
            convertStreamResultToDateTimeRanges: convertStreamResultMock,
            getBookingStream: getBookingStreamMock,
            uploadBooking: uploadBookingMock,
            pauseSlots: generatePauseSlots(),
            pauseSlotText: 'LUNCH',
            hideBreakTime: false,
            loadingWidget: const Text('Fetching data...'),
            uploadingWidget: const CircularProgressIndicator(),
            locale: 'hu_HU',
            startingDayOfWeek: StartingDayOfWeek.tuesday,
            wholeDayIsBookedWidget: const Text('Sorry, for this day everything is booked'),
          ),
        ),
      ),
    );
  }
}
