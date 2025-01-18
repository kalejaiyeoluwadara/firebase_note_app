import 'package:firebase/components/my_button.dart';
import 'package:firebase/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signUp() async {
    if (isLoading) return;

    // Validate fields
    if (usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showErrorMessage('All fields are required.');
      return;
    }

    if (passwordController.text.length < 6) {
      showErrorMessage('Password must be at least 6 characters long.');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showErrorMessage('Passwords do not match.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Show loading indicator
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
      // Create user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Create Firestore document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'created_at': FieldValue.serverTimestamp(),
      });

      // Dismiss the loading dialog
      Navigator.pop(context);

      // Show success message
      showSuccessMessage('Registration successful!');
    } on FirebaseAuthException catch (e) {
      // Dismiss the loading dialog
      if (Navigator.canPop(context)) Navigator.pop(context);
      showErrorMessage(_getFirebaseAuthErrorMessage(e.code));
    } catch (e) {
      // Dismiss the loading dialog and handle unexpected errors
      if (Navigator.canPop(context)) Navigator.pop(context);
      showErrorMessage('An unexpected error occurred. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
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

  void showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
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

  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An undefined error occurred.';
    }
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
                const Icon(
                  Icons.person,
                  size: 80,
                ),
                const SizedBox(height: 10),
                Text(
                  'M I N I M A L',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                MyTextfield(
                  hintText: 'Username',
                  obscureText: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: isLoading ? 'Loading...' : 'Sign Up',
                  onTap: isLoading ? null : signUp,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
