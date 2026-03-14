import 'package:field_service_app/core/theme/app_color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  /// Creates TextTheme for light mode
  static TextTheme lightTextTheme() {
    return _buildTextTheme(AppColors.light);
  }

  /// Creates TextTheme for dark mode
  static TextTheme darkTextTheme() {
    return _buildTextTheme(AppColors.dark);
  }

  static TextTheme _buildTextTheme(AppColorSet colors) {
    return TextTheme(
      // Display Styles - Inter Tight, Semi Bold, Primary Text
      displayLarge: GoogleFonts.interTight(
        fontSize: 64.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      displayMedium: GoogleFonts.interTight(
        fontSize: 44.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      displaySmall: GoogleFonts.interTight(
        fontSize: 36.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),

      // Headline Styles - Inter Tight, Semi Bold, Primary Text
      headlineLarge: GoogleFonts.interTight(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      headlineMedium: GoogleFonts.interTight(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      headlineSmall: GoogleFonts.interTight(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),

      // Title Styles - Inter Tight, Semi Bold, Primary Text
      titleLarge: GoogleFonts.interTight(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.interTight(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      titleSmall: GoogleFonts.interTight(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: colors.primaryText,
        letterSpacing: 0,
      ),

      // Label Styles - Inter, Normal, Secondary Text
      labelLarge: GoogleFonts.inter(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: colors.secondaryText,
        letterSpacing: 0,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: colors.secondaryText,
        letterSpacing: 0,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: colors.secondaryText,
        letterSpacing: 0,
      ),

      // Body Styles - Inter, Normal, Primary Text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: colors.primaryText,
        letterSpacing: 0,
      ),
    );
  }
}
