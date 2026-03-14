import 'package:flutter/widgets.dart';

/// Global spacing tokens for consistent layout rhythm.
class AppSpacing {
  AppSpacing._();

  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xxl = 20.0;
  static const double xl = 24.0;

  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingRightMd = EdgeInsets.only(right: md);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(
    horizontal: lg,
  );
  static const EdgeInsets paddingHorizontalLgVerticalLg = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: lg,
  );
  static const EdgeInsets paddingHorizontalLgVerticalMd = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets paddingHorizontalXlVerticalMd = EdgeInsets.symmetric(
    horizontal: xl,
    vertical: md,
  );
  static const EdgeInsets paddingTopSm = EdgeInsets.only(top: sm);
  static const EdgeInsets paddingBottomMd = EdgeInsets.only(bottom: md);
  static const EdgeInsets paddingTitle = EdgeInsets.only(
    left: lg,
    right: lg,
    bottom: lg,
  );
  static const EdgeInsets paddingDialogBottomSection = EdgeInsets.fromLTRB(
    lg,
    0,
    lg,
    lg,
  );
  static const EdgeInsets paddingNavBarHorizontal = EdgeInsets.symmetric(
    horizontal: md + xxs,
  );

  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  static const EdgeInsets dialogInset = EdgeInsets.symmetric(horizontal: lg);
}
