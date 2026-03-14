import 'package:flutter/material.dart';

import 'app_color_palettes.dart';
import 'app_radius.dart';
import 'app_shadows.dart';
import 'app_sizes.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    final colors = AppColors.light;
    final colorScheme = ColorScheme.light(
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.scaffoldBackground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: AppTypography.lightTextTheme(),
      scaffoldBackgroundColor: colors.scaffoldBackground,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colors.primaryText,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: AppRadius.controlShape),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          elevation: AppShadows.actionButtonElevation,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.controlShape),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colors = AppColors.dark;
    final colorScheme = ColorScheme.dark(
      primary: colors.primary,
      secondary: colors.secondary,
      surface: colors.scaffoldBackground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: AppTypography.darkTextTheme(),
      scaffoldBackgroundColor: colors.scaffoldBackground,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colors.primaryText,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: AppRadius.controlShape),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          elevation: AppShadows.actionButtonElevation,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.controlShape),
        ),
      ),
    );
  }
}
