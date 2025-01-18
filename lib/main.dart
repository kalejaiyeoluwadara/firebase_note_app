import 'package:firebase/firebase_options.dart';
import 'package:firebase/pages/login_or_register.dart';
import 'package:firebase/theme/dark_mode.dart';
import 'package:firebase/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wall App',
        // theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: const LoginOrRegister());
  }
}
