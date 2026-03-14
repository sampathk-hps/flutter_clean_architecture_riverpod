import 'package:flutter/widgets.dart';

/// Global radius tokens for consistent shape language.
class AppRadius {
  AppRadius._();

  static const double xxs = 2.0;
  static const double sm = 8.0;
  static const double base = 10.0;
  static const double md = 12.0;
  static const double xxl = 16.0;
  static const double lg = 18.0;
  static const double xl = 20.0;
  static const double xxxl = 32.0;
  static const double full = 999.0;

  static const BorderRadius tiny = BorderRadius.all(Radius.circular(xxs));
  static const BorderRadius controlShape = BorderRadius.all(
    Radius.circular(base),
  );
  static const BorderRadius button = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius field = BorderRadius.all(Radius.circular(md));
  static const BorderRadius dialogContainer = BorderRadius.all(
    Radius.circular(xxl),
  );
  static const BorderRadius sheetTop = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
  static const BorderRadius sheetBottom = BorderRadius.only(
    bottomLeft: Radius.circular(xxl),
    bottomRight: Radius.circular(xxl),
  );
  static const BorderRadius headerAction = BorderRadius.all(
    Radius.circular(xl),
  );
  static const BorderRadius actionCircle = BorderRadius.all(
    Radius.circular(xxxl),
  );

  static const BorderRadius card = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius iconTile = BorderRadius.all(
    Radius.circular(md + 1),
  );
  static const BorderRadius chip = BorderRadius.all(Radius.circular(full));
}
