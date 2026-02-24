import 'package:flutter/material.dart';

class MontebitTheme {
  static const Color primaryColor = Color(0xff446900);

  static ThemeData get lightTheme {
    final theme = ThemeData.light();

    return theme.copyWith(
      primaryColor: primaryColor,
      colorScheme: theme.colorScheme.copyWith(primary: primaryColor),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xffFBFAF2)),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xffE4E3DB),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        prefixStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(letterSpacing: .1),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffFBFAF2)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xffE9E8E1),
        foregroundColor: primaryColor,
      ),
    );
  }
}
