import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF); // Modern purple
  static const Color secondaryColor = Color(0xFF2A2A50); // Dark blue-gray
  static const Color accentColor = Color(0xFFFFA726); // Orange accent
  static const Color backgroundColor = Color(0xFFF8F9FC); // Light gray-blue
  static const Color textPrimaryColor = Color(0xFF2D3142); // Dark text
  static const Color textSecondaryColor = Color(0xFF9093A3); // Light text

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: textPrimaryColor),
      headline6: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: textPrimaryColor),
      bodyText1: TextStyle(fontSize: 16, color: textPrimaryColor),
      bodyText2: TextStyle(fontSize: 14, color: textSecondaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      labelStyle: const TextStyle(color: textSecondaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor, // Button background color
        onPrimary: Colors.white, // Text color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: primaryColor, // Text color for TextButton
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
