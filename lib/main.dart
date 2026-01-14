import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'controllers/information_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/views_controller.dart';
import 'views/splash/splash_view.dart';

Future<void> main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeController()..getThemeMode()),
        ChangeNotifierProvider(create: (_) => ViewsController()),
        ChangeNotifierProvider(create: (_) => InformationController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, state, child) {
          // Cohesive color scheme - Modern Blue to Purple gradient
          const primaryColor = Color(0xFF6366F1); // Indigo
          const secondaryColor = Color(0xFF8B5CF6); // Purple
          const tertiaryColor = Color(0xFFEC4899); // Pink

          // Create proper light theme
          final lightColorScheme = ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: secondaryColor,
            tertiary: tertiaryColor,
            brightness: Brightness.light,
          );

          // Create proper dark theme
          final darkColorScheme = ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: secondaryColor,
            tertiary: tertiaryColor,
            brightness: Brightness.dark,
          );

          return MaterialApp(
              theme: FlexThemeData.light(
                  scheme: FlexScheme.custom,
                  primary: primaryColor,
                  secondary: secondaryColor,
                  tertiary: tertiaryColor,
                  appBarStyle: FlexAppBarStyle.material,
                  textTheme: GoogleFonts.cairoTextTheme(),
                  colorScheme: lightColorScheme,
                  useMaterial3: true),
              darkTheme: FlexThemeData.dark(
                  scheme: FlexScheme.custom,
                  primary: primaryColor,
                  secondary: secondaryColor,
                  tertiary: tertiaryColor,
                  appBarStyle: FlexAppBarStyle.material,
                  textTheme: GoogleFonts.cairoTextTheme(),
                  colorScheme: darkColorScheme,
                  useMaterial3: true),
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              home: const SplashView());
        },
      ),
    );
  }
}
