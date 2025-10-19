import 'package:flutter/material.dart';

import '../views/theme/colors.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default to system setting

  ThemeMode get themeMode => _themeMode;

  bool get isDarkThemeSet => _themeMode == ThemeMode.dark;

  // Define your custom light and dark themes
  static final ThemeData lightTheme = ThemeData(
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

  static final ThemeData darkTheme = ThemeData(
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

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Tells all listening widgets to rebuild
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}
