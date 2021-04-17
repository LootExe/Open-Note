import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData get lightTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.light(),
      textTheme: GoogleFonts.nunitoSansTextTheme(ThemeData.light().textTheme),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData.from(
      colorScheme: ColorScheme.dark(
        onPrimary: Colors.white,
      ),
      textTheme: GoogleFonts.nunitoSansTextTheme(ThemeData.dark().textTheme),
    );
  }
}
