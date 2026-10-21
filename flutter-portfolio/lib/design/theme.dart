import 'package:flutter/material.dart';

abstract final class Brand {
  static const ink = Color(0xFF101D35);
  static const paper = Color(0xFFF6F8FC);
  static const white = Color(0xFFFFFFFF);
  static const accent = Color(0xFF2563EB);
  static const muted = Color(0xFF54647E);
  static const line = Color(0xFFDCE4F0);
  static const lime = Color(0xFFA7D8FF);
  static const mist = Color(0xFFECF1FA);
  static const space = 24.0;
  static const radius = 24.0;
  static const contentWidth = 1160.0;
  static const desktop = 850.0;
}

abstract final class BrandTheme {
  static final light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Brand.paper,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Brand.accent,
      surface: Brand.paper,
      primary: Brand.accent,
      onSurface: Brand.ink,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64,
        height: 1.1,
        fontWeight: FontWeight.w700,
        letterSpacing: -2.4,
        color: Brand.ink,
      ),
      displaySmall: TextStyle(
        fontSize: 40,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        color: Brand.ink,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Brand.ink,
      ),
      bodyLarge: TextStyle(fontSize: 18, height: 1.65, color: Brand.muted),
      bodyMedium: TextStyle(fontSize: 15, height: 1.6, color: Brand.muted),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        side: const BorderSide(color: Brand.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    dividerTheme: const DividerThemeData(color: Brand.line),
  );
}
