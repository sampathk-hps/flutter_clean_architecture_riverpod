import 'package:field_service_app/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Reusable elevation presets for modern card surfaces.
class AppShadows {
  AppShadows._();

  static const double actionButtonElevation = 5.0;

  static List<BoxShadow> card(Color baseTextColor) {
    return [
      BoxShadow(
        color: ColorUtils.withAlpha(baseTextColor, 0.04),
        blurRadius: 14.0,
        offset: const Offset(0, 6),
      ),
      BoxShadow(
        color: ColorUtils.withAlpha(baseTextColor, 0.02),
        blurRadius: 3.0,
        offset: const Offset(0, 1),
      ),
    ];
  }

  static List<BoxShadow> actionButton(Color baseColor) {
    return [
      BoxShadow(
        blurRadius: 12.0,
        color: ColorUtils.withOpacity(baseColor, 0.5),
        offset: const Offset(0, 4),
      ),
    ];
  }
}
