import 'package:firebase/pages/login_page.dart';
import 'package:firebase/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showlogin = true;
  void toggle() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return (LoginPage(onTap: toggle));
    } else {
      return RegisterPage(
        onTap: toggle,
      );
    }
  }
}
