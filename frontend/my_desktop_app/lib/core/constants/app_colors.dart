import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  // static const Color primary = Color(0xFF5B2EFF); // Modern Indigo
  static const Color primary = Color(0xFF2E2E48); // Modern Indigo
  static const Color primaryVariant = Color(0xFF3A1C94); // Deeper Indigo

  // Secondary Colors
  static const Color secondary = Color(0xFF00BFA5); // Teal
  static const Color secondaryVariant = Color(0xFF00796B); // Dark Teal

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF9FAFB); // Soft Gray
  static const Color surface = Color(0xFFFFFFFF); // Pure white for cards, etc.

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  // Error
  static const Color error = Color(0xFFEF5350); // Soft red

  // Text
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onBackground = Color(0xFF1C1C1E); // Very dark gray
  // static const Color onSurface = Color(0xFF2E2E2E);
  static const Color onSurface = Color.fromARGB(255, 203, 203, 203);
  static const Color onError = Colors.white;

  // Extra States
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Neutral
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF0F0F0);
  static const Color darkGrey = Color(0xFF424242);
}
