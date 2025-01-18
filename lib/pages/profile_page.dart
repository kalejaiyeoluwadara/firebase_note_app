import 'package:firebase/components/my_back_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>?> getUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch additional user details from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to load user details.'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final userDetails = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      MyBackButton(),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Profile Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Username: ${userDetails['username'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Email: ${FirebaseAuth.instance.currentUser?.email ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   'Account Created: ${userDetails['created_at'] != null ? (userDetails['created_at'] as Timestamp).toDate().toString() : 'N/A'}',
                  //   style: const TextStyle(fontSize: 16),
                  // ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No user details available.'),
            );
          }
        },
      ),
    );
  }
}
