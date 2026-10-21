import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'design/theme.dart';
import 'pages/portfolio_page.dart';
import 'services/link_service.dart';

void main() {
  const wasm = bool.fromEnvironment('dart.tool.dart2wasm');
  debugPrint(
    'Portfolio runtime: ${wasm ? "WebAssembly" : "JavaScript fallback"}',
  );
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key, this.openLink = LinkService.open});
  final Future<bool> Function(Uri) openLink;
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool dark = true;
  late bool arabic = Uri.base.queryParameters['lang'] == 'ar';
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Abdelrahman Amr | Flutter Developer',
    debugShowCheckedModeBanner: false,
    theme: BrandTheme.light,
    darkTheme: BrandTheme.dark,
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    locale: Locale(arabic ? 'ar' : 'en'),
    supportedLocales: const [Locale('en'), Locale('ar')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: PortfolioPage(
      arabic: arabic,
      dark: dark,
      onThemeChange: () => setState(() => dark = !dark),
      onLanguageChange: () => setState(() => arabic = !arabic),
      openLink: widget.openLink,
      initialProject: Uri.base.queryParameters['project'],
    ),
  );
}
