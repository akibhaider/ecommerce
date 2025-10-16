import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF2196F3);
  static const Color lightSecondary = Color(0xFF03A9F4);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightCardBackground = Colors.white;
  static const Color lightSearchBar = Color(0xFFF0F0F0);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightError = Color(0xFFD32F2F);
  static const Color lightSuccess = Color(0xFF388E3C);
  
  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkSecondary = Color(0xFF81D4FA);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkCardBackground = Color(0xFF2C2C2C);
  static const Color darkSearchBar = Color(0xFF2C2C2C);
  static const Color darkBorder = Color(0xFF3C3C3C);
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkSuccess = Color(0xFF66BB6A);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: lightSurface,
      error: lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: lightTextPrimary,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightTextPrimary,
      elevation: 2,
      iconTheme: IconThemeData(color: lightTextPrimary),
    ),
    cardTheme: CardThemeData(
      color: lightCardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSearchBar,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: lightTextSecondary),
      prefixIconColor: lightTextSecondary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightTextPrimary),
      bodyMedium: TextStyle(color: lightTextPrimary),
      bodySmall: TextStyle(color: lightTextSecondary),
      titleLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: lightTextPrimary),
      titleSmall: TextStyle(color: lightTextSecondary),
    ),
    iconTheme: const IconThemeData(color: lightTextSecondary),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: lightPrimary,
      unselectedItemColor: lightTextSecondary,
      elevation: 8,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: lightSearchBar,
      selectedColor: lightPrimary,
      labelStyle: const TextStyle(color: lightTextPrimary),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      error: darkError,
      onPrimary: darkBackground,
      onSecondary: darkBackground,
      onSurface: darkTextPrimary,
      onError: darkBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkTextPrimary,
      elevation: 2,
      iconTheme: IconThemeData(color: darkTextPrimary),
    ),
    cardTheme: CardThemeData(
      color: darkCardBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSearchBar,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: darkTextSecondary),
      prefixIconColor: darkTextSecondary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkTextPrimary),
      bodyMedium: TextStyle(color: darkTextPrimary),
      bodySmall: TextStyle(color: darkTextSecondary),
      titleLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: darkTextPrimary),
      titleSmall: TextStyle(color: darkTextSecondary),
    ),
    iconTheme: const IconThemeData(color: darkTextSecondary),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: darkPrimary,
      unselectedItemColor: darkTextSecondary,
      elevation: 8,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: darkSearchBar,
      selectedColor: darkPrimary,
      labelStyle: const TextStyle(color: darkTextPrimary),
      secondaryLabelStyle: const TextStyle(color: darkBackground),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
