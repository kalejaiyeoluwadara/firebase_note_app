import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Users page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
