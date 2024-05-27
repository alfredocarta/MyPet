import 'package:firebase_auth/firebase_auth.dart';
import 'booking_service.dart'; // Assicurati di importare il modello BookingService

Future<BookingService> createBookingService({
  required String serviceName,
  required int serviceDuration,
  required DateTime bookingStart,
  required DateTime bookingEnd,
}) async {
  User? user = FirebaseAuth.instance.currentUser;

  return BookingService(
    userId: user?.uid,
    userName: user?.displayName,
    userEmail: user?.email,
    userPhoneNumber: user?.phoneNumber,
    serviceName: serviceName,
    serviceDuration: serviceDuration,
    bookingStart: bookingStart,
    bookingEnd: bookingEnd,
  );
}
