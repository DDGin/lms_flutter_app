import 'package:flutter/material.dart';
import 'colors.dart';

class MidnightTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: MidnightColors.teal,
    colorScheme: const ColorScheme.light(
      primary: MidnightColors.white,
      secondary: MidnightColors.aqua,
      surface: MidnightColors.lightGray,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MidnightColors.midnightBlue,
      foregroundColor: MidnightColors.lightGray,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: MidnightColors.midnightBlue),
      bodyMedium: TextStyle(color: MidnightColors.deepBlue),
      bodySmall: TextStyle(color: MidnightColors.black),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: MidnightColors.midnightBlue,
    colorScheme: const ColorScheme.dark(
      primary: MidnightColors.deepBlue,
      secondary: MidnightColors.aqua,
      surface: MidnightColors.midnightBlue,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MidnightColors.deepBlue,
      foregroundColor: MidnightColors.lightGray,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: MidnightColors.aqua),
      bodyMedium: TextStyle(color: MidnightColors.teal),
      bodySmall: TextStyle(color: MidnightColors.white),
    ),
  );
}
