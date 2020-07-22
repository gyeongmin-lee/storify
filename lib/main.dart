import 'package:flutter/material.dart';
import 'package:storify/constants/style.dart';
import 'package:storify/widgets/landing_page/landing_page.dart';
import 'package:storify/widgets/player_page/player_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Storify',
        themeMode: ThemeMode.dark,
        initialRoute: LandingPage.routeName,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF191414),
          cursorColor: Colors.green[700],
          textSelectionColor: Colors.green[100].withOpacity(0.1),
          textSelectionHandleColor: Colors.green[700],
          textTheme: Theme.of(context)
              .textTheme
              .apply(displayColor: Colors.white70, bodyColor: Colors.white54),
        ),
        builder: (context, child) => ScrollConfiguration(
              behavior: DisableGlowScrollBehaviour(),
              child: child,
            ),
        routes: {
          LandingPage.routeName: (context) => LandingPage(),
          PlayerPage.routeName: (context) => PlayerPage(),
        });
  }
}
