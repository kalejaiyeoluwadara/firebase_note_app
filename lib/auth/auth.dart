import 'package:firebase/pages/login_or_register.dart';
import 'package:firebase/pages/wall_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WallPage();
            } else {
              return LoginOrRegister();
            }
          }),
    );
  }
}
