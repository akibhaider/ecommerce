import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color brandPrimary = Color(0xFF6C63FF); // Vibrant Purple
  static const Color brandSecondary = Color(0xFFFF6584); // Coral Pink
  static const Color brandAccent = Color(0xFF4CAF50); // Green for success
  
  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF6C63FF);
  static const Color lightSecondary = Color(0xFFFF6584);
  static const Color lightBackground = Color(0xFFF8F9FE);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightCardBackground = Colors.white;
  static const Color lightSearchBar = Color(0xFFF3F4F6);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightSuccess = Color(0xFF10B981);
  
  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF8B85FF);
  static const Color darkSecondary = Color(0xFFFF7B98);
  static const Color darkBackground = Color(0xFF0F0F1E);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkTextPrimary = Color(0xFFF3F4F6);
  static const Color darkTextSecondary = Color(0xFFD1D5DB);
  static const Color darkCardBackground = Color(0xFF1E1E32);
  static const Color darkSearchBar = Color(0xFF252540);
  static const Color darkBorder = Color(0xFF374151);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkSuccess = Color(0xFF34D399);

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
      tertiary: lightSuccess,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: lightTextPrimary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: lightTextPrimary),
      titleTextStyle: TextStyle(
        color: lightTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: lightCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black.withOpacity(0.05),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSearchBar,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: lightBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: lightPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: lightError, width: 1),
      ),
      hintStyle: const TextStyle(color: lightTextSecondary),
      labelStyle: const TextStyle(color: lightTextSecondary),
      prefixIconColor: lightTextSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: lightTextSecondary, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: lightTextPrimary),
      bodyMedium: TextStyle(color: lightTextPrimary),
      bodySmall: TextStyle(color: lightTextSecondary),
      labelLarge: TextStyle(color: lightTextPrimary, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: lightTextSecondary),
      labelSmall: TextStyle(color: lightTextSecondary),
    ),
    iconTheme: const IconThemeData(color: lightTextSecondary),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightSurface,
      selectedItemColor: lightPrimary,
      unselectedItemColor: lightTextSecondary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: lightSearchBar,
      selectedColor: lightPrimary,
      labelStyle: const TextStyle(color: lightTextPrimary),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
      tertiary: darkSuccess,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: darkTextPrimary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkTextPrimary),
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      color: darkCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.black.withOpacity(0.3),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSearchBar,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: darkBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: darkPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: darkError, width: 1),
      ),
      hintStyle: const TextStyle(color: darkTextSecondary),
      labelStyle: const TextStyle(color: darkTextSecondary),
      prefixIconColor: darkTextSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: darkBackground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
      titleSmall: TextStyle(color: darkTextSecondary, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: darkTextPrimary),
      bodyMedium: TextStyle(color: darkTextPrimary),
      bodySmall: TextStyle(color: darkTextSecondary),
      labelLarge: TextStyle(color: darkTextPrimary, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: darkTextSecondary),
      labelSmall: TextStyle(color: darkTextSecondary),
    ),
    iconTheme: const IconThemeData(color: darkTextSecondary),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: darkPrimary,
      unselectedItemColor: darkTextSecondary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: darkSearchBar,
      selectedColor: darkPrimary,
      labelStyle: const TextStyle(color: darkTextPrimary),
      secondaryLabelStyle: const TextStyle(color: darkBackground),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
