import 'package:cloud_firestore/cloud_firestore.dart';

class WeightFirestoreService {
  // get collection of weights
  final CollectionReference weights = FirebaseFirestore.instance.collection('Users');

  // CREATE: add a new note
  Future<void> addWeight(String weight) {
    return weights.add({
      'weight': weight,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: get weights from database
  Stream<QuerySnapshot> getWeightsStream() {
    final weightsStream = 
      weights.orderBy('timestamp', descending: true).snapshots();
    return weightsStream;
  }

  // UPDATE: update weights given a doc id
  Future<void> updateWeight(String docID, String newWeight) {
    return weights.doc(docID).update({
      'weight': newWeight,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: delete notes given a doc id
  Future<void> deleteWeight(String docID) {
    return weights.doc(docID).delete();
  }

}