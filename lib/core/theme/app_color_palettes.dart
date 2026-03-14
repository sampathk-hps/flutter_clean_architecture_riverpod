import 'package:flutter/material.dart';

/// Abstract base class for app theme colors.
abstract class AppColorSet {
  Color get primary;
  Color get secondary;
  Color get scaffoldBackground;
  Color get success;
  Color get warning;

  Color get primaryText;
  Color get secondaryText;
}

/// App color constants for light and dark themes.
class AppColors {
  AppColors._();

  static const AppColorSet light = _LightMode();
  static const AppColorSet dark = _DarkMode();

  static AppColorSet of(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }

  static AppColorSet fromContext(BuildContext context) {
    return of(Theme.of(context).brightness);
  }
}

class _LightMode implements AppColorSet {
  const _LightMode();

  @override
  Color get primary => const Color(0xFF0D47A1);

  @override
  Color get secondary => const Color(0xFF4FC3F7);

  @override
  Color get scaffoldBackground => const Color(0xFFF8FAFC);

  @override
  Color get success => const Color(0xFF2E7D32);

  @override
  Color get warning => const Color(0xFFEF6C00);

  @override
  Color get primaryText => const Color(0xFF121212);

  @override
  Color get secondaryText => const Color(0xFF777777);
}

class _DarkMode implements AppColorSet {
  const _DarkMode();

  @override
  Color get primary => const Color(0xFF90CAF9);

  @override
  Color get secondary => const Color(0xFF4FC3F7);

  @override
  Color get scaffoldBackground => const Color(0xFF0F172A);

  @override
  Color get success => const Color(0xFF81C784);

  @override
  Color get warning => const Color(0xFFFFB74D);

  @override
  Color get primaryText => const Color(0xFFFAFAFA);

  @override
  Color get secondaryText => const Color(0xFFAAAAAA);
}
