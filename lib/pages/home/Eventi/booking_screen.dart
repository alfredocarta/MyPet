import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart'; // Importa la libreria per l'invio di e-mail

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({super.key});

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;
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
  }

  Stream<dynamic>? getBookingStreamMock({required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock({required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');

    // Invia un'e-mail al veterinario
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String vetEmail = 'alfredocarta01@icloud.com'; // Indirizzo e-mail del veterinario
        String userName = user.displayName ?? 'Utente'; // Nome dell'utente (se disponibile)
        DateTime bookingDate = newBooking.bookingStart; // Data della prenotazione

        await sendEmailToVet(vetEmail, userName, bookingDate);
      }
    } catch (error) {
      print('Error sending email to veterinarian: $error');
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
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(start: fourth, end: fourth.add(const Duration(minutes: 50))));
    converted.add(DateTimeRange(
      start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
      end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0),
    ));
    return converted;
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
      theme: ThemeData(primarySwatch: Colors.blue),
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
