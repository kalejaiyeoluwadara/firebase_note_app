import 'package:firebase/auth/auth.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/pages/login_or_register.dart';
import 'package:firebase/pages/profile_page.dart';
import 'package:firebase/pages/users_page.dart';
import 'package:firebase/pages/wall_page.dart';
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
        debugShowCheckedModeBanner: false,
        routes: {
          '/users_page': (context) => const UsersPage(),
          '/profile_page': (context) => const ProfilePage(),
          '/home_page': (context) => const WallPage(),
          '/login_or_register_page': (context) => const LoginOrRegister(),
        },
        home: const AuthPage());
  }
}
