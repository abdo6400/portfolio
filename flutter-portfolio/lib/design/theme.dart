import 'package:flutter/material.dart';

abstract final class Brand {
  static const ink = Color(0xFF101D35);
  static const paper = Color(0xFFF6F8FC);
  static const white = Color(0xFFFFFFFF);
  static const accent = Color(0xFF7C9CFF);
  static const violet = Color(0xFFA794FF);
  static const muted = Color(0xFFA6B0C6);
  static const line = Color(0xFF273148);
  static const lime = Color(0xFFC2B5FF);
  static const mist = Color(0xFF141B2D);
  static const space = 24.0;
  static const radius = 22.0;
  static const contentWidth = 1160.0;
  static const desktop = 850.0;
  static const navDesktop = 1020.0;
  static const stackMinWidth = 1000.0;
  static const stackMinHeight = 640.0;
  static const mobileSectionSpace = 40.0;
  static const mobileHeaderSpace = 10.0;
  static const mobileIntroGap = 18.0;
  static const motion = Duration(milliseconds: 280);
  static const entrance = Duration(milliseconds: 440);
}

@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.background,
    required this.panel,
    required this.raised,
    required this.text,
    required this.muted,
    required this.border,
    required this.accent,
    required this.violet,
  });
  final Color background, panel, raised, text, muted, border, accent, violet;
  static const dark = Palette(
    background: Color(0xFF090C14),
    panel: Color(0xFF111725),
    raised: Color(0xFF182136),
    text: Color(0xFFF1F3FC),
    muted: Color(0xFFA6B0C6),
    border: Color(0xFF2B3550),
    accent: Color(0xFF93ACFF),
    violet: Color(0xFFBAA9FF),
  );
  static const light = Palette(
    background: Color(0xFFF7F8FD),
    panel: Colors.white,
    raised: Color(0xFFEDF0FA),
    text: Color(0xFF141D34),
    muted: Color(0xFF53617A),
    border: Color(0xFFD4DBEC),
    accent: Color(0xFF3458D3),
    violet: Color(0xFF7353CF),
  );
  static Palette of(BuildContext context) =>
      Theme.of(context).extension<Palette>() ??
      (Theme.of(context).brightness == Brightness.dark ? dark : light);
  @override
  Palette copyWith({
    Color? background,
    Color? panel,
    Color? raised,
    Color? text,
    Color? muted,
    Color? border,
    Color? accent,
    Color? violet,
  }) => Palette(
    background: background ?? this.background,
    panel: panel ?? this.panel,
    raised: raised ?? this.raised,
    text: text ?? this.text,
    muted: muted ?? this.muted,
    border: border ?? this.border,
    accent: accent ?? this.accent,
    violet: violet ?? this.violet,
  );
  @override
  Palette lerp(covariant Palette? other, double t) => other == null
      ? this
      : Palette(
          background: Color.lerp(background, other.background, t)!,
          panel: Color.lerp(panel, other.panel, t)!,
          raised: Color.lerp(raised, other.raised, t)!,
          text: Color.lerp(text, other.text, t)!,
          muted: Color.lerp(muted, other.muted, t)!,
          border: Color.lerp(border, other.border, t)!,
          accent: Color.lerp(accent, other.accent, t)!,
          violet: Color.lerp(violet, other.violet, t)!,
        );
}

abstract final class BrandTheme {
  static final dark = create(Palette.dark, Brightness.dark);
  static final light = create(Palette.light, Brightness.light);
  static ThemeData create(Palette p, Brightness brightness) => ThemeData(
    useMaterial3: true,
    brightness: brightness,
    extensions: [p],
    scaffoldBackgroundColor: p.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: p.accent,
      brightness: brightness,
      surface: p.panel,
      primary: p.accent,
      onSurface: p.text,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 66,
        height: 1.06,
        fontWeight: FontWeight.w800,
        letterSpacing: -2.5,
        color: p.text,
      ),
      displaySmall: TextStyle(
        fontSize: 38,
        height: 1.16,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.2,
        color: p.text,
      ),
      headlineMedium: TextStyle(
        fontSize: 30,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: p.text,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: p.text,
      ),
      bodyLarge: TextStyle(fontSize: 18, height: 1.65, color: p.muted),
      bodyMedium: TextStyle(fontSize: 15, height: 1.6, color: p.muted),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: p.text,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: p.background,
      foregroundColor: p.text,
      scrolledUnderElevation: 0,
    ),
    dialogTheme: DialogThemeData(backgroundColor: p.panel),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: p.accent,
        foregroundColor: brightness == Brightness.dark
            ? Palette.dark.background
            : Colors.white,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: p.text,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        side: BorderSide(color: p.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: p.background,
      contentPadding: const EdgeInsets.all(18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: p.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: p.border),
      ),
    ),
    dividerTheme: DividerThemeData(color: p.border),
    focusColor: p.accent.withValues(alpha: .22),
    hoverColor: p.accent.withValues(alpha: .08),
  );
}
