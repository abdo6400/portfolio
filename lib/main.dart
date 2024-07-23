import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/theme_controller.dart';
import 'controllers/views_controller.dart';
import 'views/splash/splash_view.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: Consumer<ThemeController>(
        builder: (context, state, child) {
          return MaterialApp(
              theme: FlexThemeData.light(scheme: FlexScheme.damask),
              darkTheme: FlexThemeData.dark(scheme: FlexScheme.damask),
              themeMode: state.themeMode,
              debugShowCheckedModeBanner: false,
              home: const SplashView());
        },
      ),
    );
  }
}
