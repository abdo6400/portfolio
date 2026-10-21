import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'design/theme.dart';
import 'pages/portfolio_page.dart';
import 'services/link_service.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key, this.openLink = LinkService.open});
  final Future<bool> Function(Uri) openLink;
  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late bool arabic = Uri.base.queryParameters['lang'] == 'ar';
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Abdelrahman Amr | Flutter Developer',
    debugShowCheckedModeBanner: false,
    theme: BrandTheme.light,
    locale: Locale(arabic ? 'ar' : 'en'),
    supportedLocales: const [Locale('en'), Locale('ar')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: PortfolioPage(
      arabic: arabic,
      onLanguageChange: () => setState(() => arabic = !arabic),
      openLink: widget.openLink,
      initialProject: Uri.base.queryParameters['project'],
    ),
  );
}
