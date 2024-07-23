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
          return MaterialApp(
              theme: FlexThemeData.light(
                  scheme: FlexScheme.damask,
                  appBarStyle: FlexAppBarStyle.material,
                  textTheme: GoogleFonts.cairoTextTheme()),
              darkTheme: FlexThemeData.dark(
                  scheme: FlexScheme.damask,
                  appBarStyle: FlexAppBarStyle.material,
                  textTheme: GoogleFonts.cairoTextTheme()),
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              home: const SplashView());
        },
      ),
    );
  }
}
