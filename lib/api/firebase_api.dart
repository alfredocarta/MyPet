import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Inizializza le notifiche push
  Future<void> initNotifications() async {
    try {
      await _firebaseMessaging.requestPermission();
      final fCMToken = await _firebaseMessaging.getToken();
      print('Token: $fCMToken');
    } catch (error) {
      print('Errore durante l inizializzazione delle notifiche: $error');
      // Gestisci l'errore e fornisci feedback all'utente se necessario
    }
  }

  // Ottiene un riferimento alla collezione delle prenotazioni con un determinato ID del luogo
  CollectionReference<SportBooking> getBookingCollection({required String placeId}) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .doc(placeId)
        .collection('bookings')
        .withConverter<SportBooking>(
          fromFirestore: (snapshots, _) => SportBooking.fromJson(snapshots.data()!),
          toFirestore: (booking, _) => booking.toJson(),
        );
  }

  // Carica una nuova prenotazione su Firestore
  Future<void> uploadBookingFirebase({required String placeId, required SportBooking newBooking}) async {
    try {
      await getBookingCollection(placeId: placeId).add(newBooking);
      print('Prenotazione caricata con successo!');
    } catch (error) {
      print('Errore durante il caricamento della prenotazione: $error');
      // Gestisci l'errore e fornisci feedback all'utente se necessario
    }
  }

  // Ottiene uno stream di prenotazioni da Firestore
  Stream<List<DateTimeRange>> getBookingStreamFirebase({
    required String placeId,
    required DateTime start,
    required DateTime end,
  }) {
    try {
      return getBookingCollection(placeId: placeId)
          .where('bookingStart', isGreaterThanOrEqualTo: start)
          .where('bookingStart', isLessThanOrEqualTo: end)
          .snapshots()
          .map((snapshot) => convertStreamResultFirebase(streamResult: snapshot));
    } catch (error) {
      print('Errore durante lottenimento dello stream di prenotazioni: $error');
      // Gestisci l'errore e fornisci feedback all'utente se necessario
      return Stream.empty();
    }
  }

  // Converte i risultati dello stream di prenotazioni in una lista di DateTimeRange
  List<DateTimeRange> convertStreamResultFirebase({required QuerySnapshot<SportBooking> streamResult}) {
    List<DateTimeRange> converted = [];
    for (var doc in streamResult.docs) {
      final booking = doc.data();
      converted.add(DateTimeRange(start: booking.bookingStart!, end: booking.bookingEnd!));
    }
    return converted;
  }
}

class SportBooking {
  final String? userId;
  final String? userName;
  final String? placeId;
  final String? serviceName;
  final int? serviceDuration;
  final int? servicePrice;
  final DateTime? bookingStart;
  final DateTime? bookingEnd;
  final String? email;
  final String? phoneNumber;
  final String? placeAddress;

  SportBooking({
    this.email,
    this.phoneNumber,
    this.placeAddress,
    this.bookingStart,
    this.bookingEnd,
    this.placeId,
    this.userId,
    this.userName,
    this.serviceName,
    this.serviceDuration,
    this.servicePrice,
  });

  factory SportBooking.fromJson(Map<String, dynamic> json) => SportBooking(
        userId: json['userId'] as String?,
        userName: json['userName'] as String?,
        placeId: json['placeId'] as String?,
        serviceName: json['serviceName'] as String?,
        serviceDuration: json['serviceDuration'] as int?,
        servicePrice: json['servicePrice'] as int?,
        bookingStart: json['bookingStart'] != null ? DateTime.parse(json['bookingStart'] as String) : null,
        bookingEnd: json['bookingEnd'] != null ? DateTime.parse(json['bookingEnd'] as String) : null,
        email: json['email'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        placeAddress: json['placeAddress'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'placeId': placeId,
        'serviceName': serviceName,
        'serviceDuration': serviceDuration,
        'servicePrice': servicePrice,
        'bookingStart': bookingStart?.toIso8601String(),
        'bookingEnd': bookingEnd?.toIso8601String(),
        'email': email,
        'phoneNumber': phoneNumber,
        'placeAddress': placeAddress,
      };
}
