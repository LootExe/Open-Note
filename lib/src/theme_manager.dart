import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static FlexScheme get _scheme => FlexScheme.blue;
  static double get _appBarElevation => 4.0;
  static VisualDensity get _visualDensity =>
      VisualDensity.adaptivePlatformDensity;
  static String? get _fontFamily => GoogleFonts.nunitoSans().fontFamily;

  static ThemeData get lightTheme {
    return FlexColorScheme.light(
      scheme: _scheme,
      appBarElevation: _appBarElevation,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
    ).toTheme;
  }

  static ThemeData get darkTheme {
    return FlexColorScheme.dark(
      scheme: _scheme,
      appBarElevation: _appBarElevation,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
    ).toTheme;
  }
}
