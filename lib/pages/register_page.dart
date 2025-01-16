// ignore_for_file: prefer_const_constructors

import 'package:firebase/components/my_button.dart';
import 'package:firebase/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username_controller = TextEditingController();

  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();

  void signUp() async {
    // Show loading screen
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (confirm_password_controller.text == password_controller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username_controller.text.trim(),
          password: password_controller.text.trim(),
        );
      } else {
        ErrorMessage('Passwords don\'t match');
      }

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
              child: const Text('OK'),
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
            padding: const EdgeInsets.all(16.0), // Add some padding for spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Ensure some top spacing
                Center(
                  child: Icon(
                    Icons.lock,
                    size: 40,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Let\'s create an account for you.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  textAlign: TextAlign.center, // Center align the text
                ),
                SizedBox(height: 25),
                MyTextfield(
                  hintText: 'username',
                  obscureText: false,
                  controller: username_controller,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  hintText: 'password',
                  obscureText: true,
                  controller: password_controller,
                ),
                SizedBox(height: 10),
                MyTextfield(
                  hintText: 'confirm password',
                  obscureText: true,
                  controller: confirm_password_controller,
                ),

                SizedBox(height: 20),
                MyButton(
                  text: 'Sign Up',
                  onTap: signUp,
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        // Handle navigation to the registration page
                      },
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
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
