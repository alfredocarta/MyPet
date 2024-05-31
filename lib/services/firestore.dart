import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DateTimeRange>> fetchBookingsFromFirestore() async {
    List<DateTimeRange> bookings = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('bookings').get();
      querySnapshot.docs.forEach((doc) {
        Timestamp startTimestamp = doc['bookingStart'];
        Timestamp endTimestamp = doc['bookingEnd'];
        DateTime start = startTimestamp.toDate();
        DateTime end = endTimestamp.toDate();
        bookings.add(DateTimeRange(start: start, end: end));
      });
    } catch (error) {
      print('Error fetching bookings from Firestore: $error');
      // Rilancia l'errore per gestirlo nel chiamante se necessario
      throw error;
    }

    return bookings;
  }

  Future<void> uploadBookingToFirestore(BookingService newBooking) async {
    try {
      await _firestore.collection('bookings').add({
        'serviceName': newBooking.serviceName,
        'bookingStart': newBooking.bookingStart,
        'bookingEnd': newBooking.bookingEnd,
        // Aggiungi altri campi della prenotazione qui...
      });
      print('Booking uploaded successfully.');
    } catch (error) {
      print('Error uploading booking to Firestore: $error');
      // Rilancia l'errore per gestirlo nel chiamante se necessario
      throw error;
    }
  }


  // get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // get collection of notes
  final CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

  // CREATE: add a new note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
    
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream = 
      notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  // UPDATE: update notes given a doc id
  Future<void> updateNote(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes given a doc id
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }

}