
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
 // static ThemeData get defaultAppTheme => defaultTheme;

  static var darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.lato(
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.lato(
        fontWeight: FontWeight.w500
      ),
      headlineSmall: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.lato(
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.lato(
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: GoogleFonts.lato(
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.lato(
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.lato(
        fontWeight: FontWeight.w300,
      ),
    )
  );
}