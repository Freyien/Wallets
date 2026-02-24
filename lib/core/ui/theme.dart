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
      ),
    );
  }
}
