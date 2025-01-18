import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: TextTheme().apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  dialogTheme: DialogTheme(
    backgroundColor:
        Colors.grey.shade300, // Set the background color for dialogs
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ), // Customize the title text style
    contentTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ), // Customize the content text style
  ),
);
