import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference readings =
      FirebaseFirestore.instance.collection('solar_readings');

  Stream<DocumentSnapshot> getLatestReading() {
    return readings
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }
}