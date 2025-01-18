import 'package:firebase/components/my_drawer.dart';
import 'package:firebase/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WallPage extends StatelessWidget {
  const WallPage({super.key});
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          title: const Text(
            'W A L L',
            style: TextStyle(),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: logout,
              child: const Icon(
                Icons.logout,
              ),
            ),
            const SizedBox(
              width: 19,
            )
          ],
        ),
        drawer: const MyDrawer(),
        body: Scaffold(
          body: const Column(
            children: [
              SizedBox(height: 20),
              MyTextfield(hintText: 'Say somthing', obscureText: false)
            ],
          ),
        ));
  }
}
