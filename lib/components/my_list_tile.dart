import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String message;
  final String userEmail;
  final Timestamp timestamp;
  const MyListTile(
      {super.key,
      required this.message,
      required this.userEmail,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          title: Text(message),
          subtitle: Text(
            userEmail,
            style: TextStyle(color: Colors.grey[700], fontSize: 12),
          ),
        ),
      ),
    );
  }
}
