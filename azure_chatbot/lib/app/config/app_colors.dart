import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00E5FF); // Cyan/Teal from images
  static const Color secondary = Color(0xFF2979FF); // Blueish
  static const Color background = Color(0xFF050505); // Deep darker black
  static const Color surface = Color(0xFF101010); // Slightly lighter for cards
  static const Color surfaceLight = Color(0xFF1E1E1E);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);

  static const Color correct = Color(0xFF00E676);
  static const Color error = Color(0xFFFF5252);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFF2979FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
