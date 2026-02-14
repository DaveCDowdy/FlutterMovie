import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: kPrimary,
  onPrimary: kOnPrimary,
  primaryContainer: kPrimaryContainer,
  onPrimaryContainer: kOnPrimaryContainer,
  secondary: kSecondary,
  onSecondary: kOnSecondary,
  tertiary: kTertiary,
  onTertiary: kOnTertiary,
  surface: kSurface,
  onSurface: kOnSurface,
  surfaceContainerHighest: kSurfaceVariant,
  outline: kOutline,
  error: Colors.red,
  onError: Colors.white,
  errorContainer: Colors.redAccent,
  onErrorContainer: Colors.white,
  shadow: Colors.black,
  inverseSurface: kOnSurface,
  onInverseSurface: kSurface,
  inversePrimary: kPrimary,
  scrim: Colors.black54,
);

ThemeData movieDroidTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
  textTheme: appTextTheme,
  scaffoldBackgroundColor: kBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: kSurface,
    foregroundColor: kOnSurface,
    elevation: 0,
  ),
  // Add more theme customizations as needed
);
