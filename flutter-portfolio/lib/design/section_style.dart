import 'package:flutter/material.dart';

import 'theme.dart';

/// Coordinated section surfaces. Endpoints stay opaque for stacked painting.
abstract final class SectionStyle {
  static const count = 7;
  static const _darkStarts = [
    Color(0xFF10243A),
    Color(0xFF271C3C),
    Color(0xFF102E29),
    Color(0xFF17233D),
    Color(0xFF302619),
    Color(0xFF241D3B),
    Color(0xFF321E2B),
  ];
  static const _darkEnds = [
    Color(0xFF0C131E),
    Color(0xFF13101D),
    Color(0xFF0B1715),
    Color(0xFF0C1423),
    Color(0xFF18140E),
    Color(0xFF12101D),
    Color(0xFF1A1017),
  ];
  static const _lightStarts = [
    Color(0xFFEAF3FF),
    Color(0xFFEEE7FC),
    Color(0xFFE2F4EE),
    Color(0xFFE8EEFB),
    Color(0xFFFAF0DF),
    Color(0xFFECE9FC),
    Color(0xFFF9E8EE),
  ];
  static const _lightEnds = [
    Color(0xFFF6FAFF),
    Color(0xFFF8F5FF),
    Color(0xFFF4FCF8),
    Color(0xFFF5F8FF),
    Color(0xFFFFFBF3),
    Color(0xFFF7F5FF),
    Color(0xFFFFF7FA),
  ];
  static const _darkAccents = [
    Color(0xFF9BCAFF),
    Color(0xFFC5AFFF),
    Color(0xFF86DDC2),
    Color(0xFF9BBDFF),
    Color(0xFFEDC182),
    Color(0xFFBEADFF),
    Color(0xFFF2AEBF),
  ];
  static const _lightAccents = [
    Color(0xFF186599),
    Color(0xFF69449F),
    Color(0xFF126F64),
    Color(0xFF2759AD),
    Color(0xFF865612),
    Color(0xFF6247A5),
    Color(0xFF9D365B),
  ];
  static List<Color> colors(int index, Brightness brightness) =>
      brightness == Brightness.dark
      ? [_darkStarts[index], _darkEnds[index]]
      : [_lightStarts[index], _lightEnds[index]];

  static Palette palette(int index, Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final base = dark ? Palette.dark : Palette.light;
    final start = colors(index, brightness).first;
    final accent = (dark ? _darkAccents : _lightAccents)[index];
    return base.copyWith(
      background: start,
      panel: Color.lerp(start, dark ? Colors.black : Colors.white, .22)!,
      raised: Color.lerp(start, Colors.white, .06)!,
      border: Color.lerp(start, accent, .30)!,
      accent: accent,
      violet: accent,
    );
  }

  // Reused across scroll updates; themes change only with the app's mode.
  static final _darkThemes = List.generate(
    count,
    (i) => BrandTheme.create(palette(i, Brightness.dark), Brightness.dark),
  );
  static final _lightThemes = List.generate(
    count,
    (i) => BrandTheme.create(palette(i, Brightness.light), Brightness.light),
  );
  static ThemeData theme(int index, Brightness brightness) =>
      (brightness == Brightness.dark ? _darkThemes : _lightThemes)[index];
}
