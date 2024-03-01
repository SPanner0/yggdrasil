import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yggdrasil',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

final ThemeData appTheme = ThemeData(
  // primaryColor: const Color(0xFF7CB342), // Green
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7CB342)),
  // splashColor: const Color(0xFFF07167), // Light pink
  // scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray

  textTheme: TextTheme(
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 32.0,
      color: const Color(0xFF333333), // Dark gray
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 24.0,
      color: const Color(0xFF333333), // Dark gray
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 20.0,
      color: const Color(0xFF333333), // Dark gray
    ),
    bodyLarge: GoogleFonts.openSans(
      fontSize: 16.0,
      color: const Color(0xFF333333), // Dark gray
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 14.0,
      color: const Color(0xFF333333), // Dark gray
    ),
    bodySmall: GoogleFonts.openSans(
      fontSize: 12.0,
      color: const Color(0xFF333333), // Dark gray
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
