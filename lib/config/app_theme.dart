
import 'package:flutter/material.dart';

class AppTheme {
  static const Color purple = Color(0xFF44355B);
  static const Color darkPurple = Color(0xFF31263E);
  static const Color charcoal = Color(0xFF221E22);
  static const Color gold = Color(0xFFECA72C);
  static const Color orange = Color(0xFFEE5622);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: purple,
      onPrimary: Colors.white,
      secondary: gold,
      onSecondary: charcoal,
      tertiary: orange,
      onTertiary: Colors.white,
      surface: Color(0xFFFFFBF5),
      onSurface: charcoal,
      error: Color(0xFFB3261E),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFF9F1),
    appBarTheme: const AppBarTheme(
      backgroundColor: purple,
      foregroundColor: Colors.white,
      centerTitle: false,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: gold,
      foregroundColor: charcoal,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: gold,
      onPrimary: charcoal,
      secondary: orange,
      onSecondary: Colors.white,
      tertiary: purple,
      onTertiary: Colors.white,
      surface: darkPurple,
      onSurface: Colors.white,
      error: Color(0xFFFFB4AB),
    ),
    scaffoldBackgroundColor: charcoal,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPurple,
      foregroundColor: Colors.white,
      centerTitle: false,
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: orange,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: darkPurple,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
