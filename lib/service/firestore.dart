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

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  Future<void> updateNote(String noteId, String newNote) async {
    try {
      await notes
          .doc(noteId)
          .update({'note': newNote, 'timestamp': Timestamp.now()});
      log('Note updated successfully', name: 'Firestore');
    } catch (e) {
      log('Error updating note: $e', name: 'Firestore', level: 1000);
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await notes.doc(noteId).delete();
      log('Note deleted successfully', name: 'Firestore');
    } catch (e) {
      log('Error deleting note: $e', name: 'Firestore', level: 1000);
    }
  }
}
