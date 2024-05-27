import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/pages/home/Eventi/booking_service.dart'; 
import '/pages/home/Eventi/booking_service_helper.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
  }

  static Future<void> uploadBooking({
    required String serviceName,
    required int serviceDuration,
    required DateTime bookingStart,
    required DateTime bookingEnd,
  }) async {
    BookingService newBooking = await createBookingService(
      serviceName: serviceName,
      serviceDuration: serviceDuration,
      bookingStart: bookingStart,
      bookingEnd: bookingEnd,
    );

    await FirebaseFirestore.instance.collection('bookings').add(newBooking.toJson());
    print('${newBooking.toJson()} has been uploaded to Firestore');
  }
}
