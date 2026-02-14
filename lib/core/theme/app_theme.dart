import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fx_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: FxColors.primary,
        background: FxColors.mainBackground,
      ),
      textTheme: GoogleFonts.outfitTextTheme(),
      scaffoldBackgroundColor: FxColors.mainBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: FxColors.textHeading,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
