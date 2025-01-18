import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirestorePosts {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  /// Adds a new post to the "posts" collection
  Future<void> addPost(String content) async {
    try {
      await posts.add({
        'UserEmail': user?.email,
        'PostMessage': content,
        'Timestamp': Timestamp.now(),
      });
      log('Post added successfully', name: 'FirestorePosts');
    } catch (e) {
      log('Error adding post: $e', name: 'FirestorePosts', level: 1000);
    }
  }

  /// Retrieves a stream of posts ordered by timestamp (most recent first)
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream =
        posts.orderBy('Timestamp', descending: true).snapshots();
    return postsStream;
  }

  /// Updates a specific post by ID
  Future<void> updatePost(
      String postId, String newTitle, String newContent) async {
    try {
      await posts.doc(postId).update({
        'PostMessage': newContent,
        'Timestamp': Timestamp.now(),
      });
      log('Post updated successfully', name: 'FirestorePosts');
    } catch (e) {
      log('Error updating post: $e', name: 'FirestorePosts', level: 1000);
    }
  }

  /// Deletes a specific post by ID
  Future<void> deletePost(String postId) async {
    try {
      await posts.doc(postId).delete();
      log('Post deleted successfully', name: 'FirestorePosts');
    } catch (e) {
      log('Error deleting post: $e', name: 'FirestorePosts', level: 1000);
    }
  }
}
