// ignore_for_file: prefer_const_constructors

import 'package:firebase/components/my_button.dart';
import 'package:firebase/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();

  final password_controller = TextEditingController();

  void signIn() async {
    // Show loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Attempt sign-in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username_controller.text.trim(),
        password: password_controller.text.trim(),
      );

      // Dismiss the loading dialog on success
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      ErrorMessage(e.code);
    }
  }

  void ErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'M I N I M A L',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center, // Center align the text
                ),
                SizedBox(height: 25),
                MyTextfield(
                  hintText: 'email',
                  obscureText: false,
                  controller: username_controller,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  hintText: 'password',
                  obscureText: true,
                  controller: password_controller,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  text: 'Sign In',
                  onTap: signIn,
                ),
                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(width: 3),
                    GestureDetector(
                      onTap: () {
                        // Handle navigation to the registration page
                      },
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30), // Add spacing at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
