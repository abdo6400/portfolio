import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'nav.dart';
import 'package:portfolio/utils/app_scroll_behavior.dart';
import 'package:portfolio/services/localization_service.dart';
import 'package:portfolio/services/portfolio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  final localeProvider = LocaleProvider();

  await themeProvider.initialize();
  await localeProvider.initialize();
  await PortfolioService().initializeData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, child) {
        return MaterialApp.router(
          title: 'ProtoFolio',
          debugShowCheckedModeBanner: false,

          // Theme configuration
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,

          // Localization
          locale: localeProvider.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          scrollBehavior: const AppScrollBehavior(),

          // Use context.go() or context.push() to navigate to the routes.
          routerConfig: AppRouter.router,

          // Set text direction based on locale
          builder: (context, child) {
            return Directionality(
              textDirection: localeProvider.isAr
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child!,
            );
          },
        );
      },
    );
  }
}
