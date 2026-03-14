import 'package:flutter/widgets.dart';

/// Global radius tokens for consistent shape language.
class AppRadius {
  AppRadius._();

  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;

  static const double full = 999.0;

  static const BorderRadius general = BorderRadius.all(Radius.circular(lg));
}
