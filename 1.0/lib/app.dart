import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/splash_screen.dart';

class DiscoverJordanAppV1 extends StatelessWidget {
  const DiscoverJordanAppV1({super.key});

  ThemeData _theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFFB65E4D), brightness: brightness);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover Jordan v1.0',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
