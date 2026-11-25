
import 'package:flutter/material.dart';

class AppTheme {
  // Light mode colors
  static const Color lightText = Color(0xFF0F0A0A);
  static const Color lightBody = Color(0xFFF5EFED);
  static const Color lightButton = Color(0xFF2292A4);
  static const Color lightAppBar = Color(0xFFBDBF09);
  static const Color lightIcon = Color(0xFFD96C06);

  // Dark mode colors
  static const Color darkBody = Color(0xFF141204);
  static const Color darkAppBar = Color(0xFF262A10);
  static const Color darkButton = Color(0xFF54442B);
  static const Color darkIcon = Color(0xFFA9714B);
  static const Color darkText = Color(0xFFE8985E);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    scaffoldBackgroundColor: lightBody,
    primaryColor: lightButton,
    iconTheme: const IconThemeData(color: lightIcon),

    colorScheme: const ColorScheme.light(
      primary: lightButton,
      onPrimary: lightText,
      secondary: lightIcon,
      onSecondary: lightText,
      surface: lightBody,
      onSurface: lightText,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: lightAppBar,
      foregroundColor: lightText,
      iconTheme: IconThemeData(color: lightIcon),
      elevation: 0,
      centerTitle: false,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: lightBody,
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: lightButton,
      foregroundColor: lightBody,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightButton,
        foregroundColor: lightBody,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: lightButton,
        foregroundColor: lightBody,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: lightButton,
          width: 2,
        ),
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightText),
      bodyMedium: TextStyle(color: lightText),
      titleLarge: TextStyle(
        color: lightText,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: lightText),
      headlineMedium: TextStyle(
        color: lightText,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: darkBody,
    primaryColor: darkButton,
    iconTheme: const IconThemeData(color: darkIcon),

    colorScheme: const ColorScheme.dark(
      primary: darkButton,
      onPrimary: darkText,
      secondary: darkIcon,
      onSecondary: darkBody,
      surface: darkAppBar,
      onSurface: darkText,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkAppBar,
      foregroundColor: darkText,
      iconTheme: IconThemeData(color: darkIcon),
      elevation: 0,
      centerTitle: false,
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: darkBody,
    ),

    cardTheme: CardThemeData(
      color: darkAppBar,
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: darkButton,
      foregroundColor: darkText,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkButton,
        foregroundColor: darkText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: darkButton,
        foregroundColor: darkText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkAppBar,
      hintStyle: const TextStyle(color: darkIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: darkIcon,
          width: 2,
        ),
      ),
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkText),
      bodyMedium: TextStyle(color: darkText),
      titleLarge: TextStyle(
        color: darkText,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: darkText),
      headlineMedium: TextStyle(
        color: darkText,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
