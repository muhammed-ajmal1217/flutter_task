import 'package:flutter/material.dart';

class AppColors {
  static const loginBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 11, 45, 73),
      Color.fromARGB(255, 39, 102, 150),
    ],
  );

  static const loginTextfieldColor = Color.fromARGB(255, 215, 215, 215);
  static const loginTextColor =  Colors.white;
  static const mainButtonColor = Colors.blue;
  static const toggleLoginTextColor = Color.fromARGB(255, 33, 243, 229);
}
