import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.system;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;
    await _loadTheme();
    _isInitialized = true;
    notifyListeners();
  }

  ThemeProvider() {
    // We will call initialize() explicitly in main()
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString(_themeKey);
    if (themeStr == 'light') {
      _themeMode = ThemeMode.light;
    } else if (themeStr == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeMode.name);
  }
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
}

class AppRadius {
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double full = 9999.0;
}

extension TextStyleContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
}

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

class AppColors {
  // Light mode colors
  static const lightPrimary = Color(0xFF000000);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightSecondary = Color(0xFF4B5563);
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightAccent = Color(0xFF0891B2);
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF9FAFB);
  static const lightOnSurface = Color(0xFF111827);
  static const lightPrimaryText = Color(0xFF111827);
  static const lightSecondaryText = Color(0xFF6B7280);
  static const lightHint = Color(0xFF9CA3AF);
  static const lightError = Color(0xFFDC2626);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightSuccess = Color(0xFF16A34A);
  static const lightDivider = Color(0xFFE5E7EB);

  // Dark mode colors
  static const darkPrimary = Color(0xFFFFFFFF);
  static const darkOnPrimary = Color(0xFF000000);
  static const darkSecondary = Color(0xFFA1A1AA);
  static const darkOnSecondary = Color(0xFF000000);
  static const darkAccent = Color(0xFF22D3EE);
  static const darkBackground = Color(0xFF000000);
  static const darkSurface = Color(0xFF111111);
  static const darkOnSurface = Color(0xFFF9FAFB);
  static const darkPrimaryText = Color(0xFFF9FAFB);
  static const darkSecondaryText = Color(0xFFA1A1AA);
  static const darkHint = Color(0xFF52525B);
  static const darkError = Color(0xFFF87171);
  static const darkOnError = Color(0xFF000000);
  static const darkSuccess = Color(0xFF4ADE80);
  static const darkDivider = Color(0xFF262626);
}

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightOnPrimary,
        secondary: AppColors.lightSecondary,
        onSecondary: AppColors.lightOnSecondary,
        tertiary: AppColors.lightAccent,
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        outline: AppColors.lightDivider,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.lightPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: AppColors.lightPrimary.withOpacity(0.06),
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => GoogleFonts.inter(
            fontSize: 12,
            fontWeight: states.contains(MaterialState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: AppColors.lightPrimaryText,
          ),
        ),
        iconTheme: MaterialStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? AppColors.lightPrimary
                : AppColors.lightSecondaryText,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: AppColors.lightOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightPrimary,
          side: const BorderSide(color: AppColors.lightDivider),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.lightPrimaryText),
      textTheme: _buildTextTheme(Brightness.light),
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnPrimary,
        secondary: AppColors.darkSecondary,
        onSecondary: AppColors.darkOnSecondary,
        tertiary: AppColors.darkAccent,
        error: AppColors.darkError,
        onError: AppColors.darkOnError,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        outline: AppColors.darkDivider,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.darkPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: AppColors.darkPrimary.withOpacity(0.08),
        labelTextStyle: MaterialStateProperty.resolveWith(
          (states) => GoogleFonts.inter(
            fontSize: 12,
            fontWeight: states.contains(MaterialState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: AppColors.darkPrimaryText,
          ),
        ),
        iconTheme: MaterialStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(MaterialState.selected)
                ? AppColors.darkPrimary
                : AppColors.darkSecondaryText,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkPrimary,
          side: const BorderSide(color: AppColors.darkDivider),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.darkPrimaryText),
      textTheme: _buildTextTheme(Brightness.dark),
    );

TextTheme _buildTextTheme(Brightness brightness) {
  final primaryFont = GoogleFonts.inter();
  final secondaryFont = GoogleFonts.spaceGrotesk();
  final monoFont = GoogleFonts.jetBrainsMono();

  final primaryColor = brightness == Brightness.light
      ? AppColors.lightPrimaryText
      : AppColors.darkPrimaryText;
  final secondaryColor = brightness == Brightness.light
      ? AppColors.lightSecondaryText
      : AppColors.darkSecondaryText;

  return TextTheme(
    headlineLarge: secondaryFont.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.1,
      color: primaryColor,
    ),
    headlineMedium: secondaryFont.copyWith(
      fontSize: 26,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: primaryColor,
    ),
    headlineSmall: secondaryFont.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: primaryColor,
    ),
    titleLarge: primaryFont.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: primaryColor,
    ),
    titleMedium: primaryFont.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: primaryColor,
    ),
    titleSmall: primaryFont.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.4,
      color: primaryColor,
    ),
    bodyLarge: primaryFont.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: primaryColor,
    ),
    bodyMedium: primaryFont.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: primaryColor,
    ),
    bodySmall: primaryFont.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: secondaryColor,
    ),
    labelLarge: secondaryFont.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: primaryColor,
    ),
    labelMedium: secondaryFont.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: secondaryColor,
    ),
    labelSmall: secondaryFont.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: secondaryColor,
    ),
  );
}
