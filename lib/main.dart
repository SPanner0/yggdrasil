import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yggdrasil',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

/// The theming for the Yggdrasil app
///
/// Try to use this to set element themes instead of inlining them
final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF7CB342), // Green
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7CB342), brightness: Brightness.dark),
  splashColor: const Color(0xFFF07167), // Light pink
  scaffoldBackgroundColor: Colors.teal, // Light gray

  textTheme: TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 32.0,
      color: Colors.white70, // Dark gray
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 24.0,
      color: Colors.white70, // Dark gray
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 20.0,
      color: Colors.white70, // Dark gray
    ),
    bodyLarge: GoogleFonts.openSans(
      fontSize: 16.0,
      color: Colors.white70, // Dark gray
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 14.0,
      color: Colors.white70, // Dark gray
    ),
    bodySmall: GoogleFonts.openSans(
      fontSize: 12.0,
      color: Colors.white70, // Dark gray
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF7CB342), // Green
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 20.0,
      color: Colors.white, // White
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF07167), // Light pink
      foregroundColor: Colors.white, // White
      textStyle: GoogleFonts.montserrat(
        color: Colors.white, // White
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: const Color(0xFF7CB342), // Green
      foregroundColor: Colors.white, // White
      textStyle: GoogleFonts.montserrat(
        color: const Color(0xFF7CB342), // Green
      ),
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFFF5F5F5), // Light gray
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF7CB342), width: 2.0), // Green
    ),
  ),
);
