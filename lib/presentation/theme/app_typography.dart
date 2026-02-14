import 'package:flutter/material.dart';

class AppTypography {
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: null, // Default font
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.5, // 24/16
    letterSpacing: 0.5,
  );

}

const TextTheme appTextTheme = TextTheme(
  bodyLarge: AppTypography.bodyLarge,
  // Add more mappings as needed
);

