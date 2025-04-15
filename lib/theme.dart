import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonTheme {
  static const MaterialColor color =
      MaterialColor(_pokemonPrimaryValue, <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color.fromARGB(255, 187, 199, 248),
        200: Color.fromARGB(255, 143, 148, 244),
        300: Color.fromARGB(255, 98, 193, 240),
        400: Color.fromARGB(255, 64, 84, 236),
        500: Color(_pokemonPrimaryValue),
        600: Color.fromARGB(255, 27, 77, 216),
        700: Color.fromARGB(255, 24, 67, 194),
        800: Color.fromARGB(255, 20, 23, 173),
        900: Color.fromARGB(255, 26, 14, 136),
      });

  static const int _pokemonPrimaryValue = 0xFF1D43FF;
  static const Color background = Color(0XFF121212);

  static ButtonStyle outlineButtonStyle({
    Color color = Colors.white,
    double padding = 24,
  }) {
    return OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: padding),
      side: BorderSide(color: color),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }

  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primarySwatch: color,
    primaryColor: color,
    textTheme: GoogleFonts.wendyOneTextTheme(ThemeData.dark().textTheme),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle()),
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.amber,
      titleTextStyle: GoogleFonts.wendyOne(fontSize: 25),
    ),
  );
}
