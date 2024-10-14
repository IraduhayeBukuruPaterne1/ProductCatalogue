// lib/theme.dart
import 'package:flutter/material.dart';

// Class to define light and dark themes.
class AppThemes {
  // Light theme with blue as the primary color.
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
    ),
  );

  // Dark theme with black as the primary color.
  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
    ),
  );
}
