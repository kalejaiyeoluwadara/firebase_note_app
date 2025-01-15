import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer'; // Import for using Log.e

class Firestore {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(String note) async {
    try {
      await notes.add({'note': note, 'timestamp': Timestamp.now()});
      log('Note added successfully', name: 'Firestore');
    } catch (e) {
      log('Error adding note: $e',
          name: 'Firestore', level: 1000); // Logging the error
    }
  }
}
