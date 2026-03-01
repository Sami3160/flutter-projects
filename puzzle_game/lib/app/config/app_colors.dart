import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF9C27B0);
  static const Color background = Color(0xFFf2f9fe);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFF1E1E1E);

  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);

  static const Color correct = Color(0xFF00E676);
  static const Color error = Color(0xFFFF5252);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFF2979FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
