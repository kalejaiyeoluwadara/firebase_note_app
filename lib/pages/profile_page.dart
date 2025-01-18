import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Profile page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
