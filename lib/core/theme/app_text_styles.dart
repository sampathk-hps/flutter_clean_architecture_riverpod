import 'package:field_service_app/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Semantic text helpers for repeated UI styles.
extension AppTextStyles on TextTheme {
  TextStyle? dialogTitle(Color color) =>
      titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color);

  TextStyle? pageTitle(Color color) =>
      headlineLarge?.copyWith(fontWeight: FontWeight.bold, color: color);

  TextStyle? pinnedHeaderTitle(Color color) =>
      titleMedium?.copyWith(color: color);

  TextStyle? sectionHeader(Color color) =>
      bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w500);

  TextStyle? feedbackTitle([Color? color]) =>
      color == null ? titleMedium : titleMedium?.copyWith(color: color);

  TextStyle? feedbackBody([Color? color]) =>
      color == null ? bodySmall : bodySmall?.copyWith(color: color);

  TextStyle? emptyStateTitle([Color? color]) =>
      color == null ? headlineSmall : headlineSmall?.copyWith(color: color);

  TextStyle? emptyStateBody([Color? color]) =>
      color == null ? bodyLarge : bodyLarge?.copyWith(color: color);

  TextStyle? supportingLabel([Color? color]) =>
      color == null ? labelLarge : labelLarge?.copyWith(color: color);

  TextStyle? emptyStateSubtitle(Color color) =>
      bodyMedium?.copyWith(color: color);

  TextStyle? fieldLabel(Color color) => bodyMedium?.copyWith(color: color);

  TextStyle? fieldValue(Color color) => bodyLarge?.copyWith(color: color);

  TextStyle? fieldInput(Color color) => bodyMedium?.copyWith(color: color);

  TextStyle? fieldHint(Color color) => bodyMedium?.copyWith(color: color);

  TextStyle? counter(Color color) => bodySmall?.copyWith(color: color);

  TextStyle? errorText(Color color) => bodySmall?.copyWith(color: color);

  TextStyle? chipOption(Color color) => bodyMedium?.copyWith(color: color);

  TextStyle? cardTitle(Color color) =>
      titleSmall?.copyWith(fontWeight: FontWeight.w700, color: color);

  TextStyle? chipLabel(Color color) =>
      labelSmall?.copyWith(fontWeight: FontWeight.w600, color: color);

  TextStyle? mutedMeta(Color color) => labelSmall?.copyWith(
    fontWeight: FontWeight.w500,
    color: ColorUtils.withAlpha(color, 0.8),
  );

  TextStyle? cardNote(Color color) =>
      bodySmall?.copyWith(color: color, height: 1.25);

  TextStyle? cardPlaceholder(Color color) =>
      bodySmall?.copyWith(color: ColorUtils.withAlpha(color, 0.75));

  TextStyle? menuItemLabel(Color color) => bodyLarge?.copyWith(color: color);

  TextStyle? themeOptionLabel(Color color, {required bool isSelected}) =>
      bodyMedium?.copyWith(
        color: color,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      );

  TextStyle? buttonLabel(Color color) =>
      labelLarge?.copyWith(color: color, fontWeight: FontWeight.w600);

  TextStyle? navItemLabel(Color color, {required bool isSelected}) =>
      labelSmall?.copyWith(
        color: color,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
      );

  TextStyle? monthHeader(Color color) =>
      bodyLarge?.copyWith(color: color, fontWeight: FontWeight.w500);

  TextStyle? dateDay(Color color) =>
      headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: color);

  TextStyle? dateMeta(Color color) => bodyMedium?.copyWith(color: color);

  TextStyle? dateAmount(Color color) =>
      bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w500);

  TextStyle? amountBadge(Color color) =>
      labelLarge?.copyWith(color: color, fontWeight: FontWeight.w700);

  TextStyle? dashboardRangeTitle(Color color) => titleLarge?.copyWith(
    color: color,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  );

  TextStyle? dashboardSectionTitle(Color color) => titleLarge?.copyWith(
    color: color,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.1,
  );

  TextStyle? dashboardStatLabel(Color color) => bodyMedium?.copyWith(
    color: color,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  TextStyle? dashboardStatValue(Color color) => titleLarge?.copyWith(
    color: color,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );

  TextStyle? dashboardLegend(Color color) =>
      bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w500);

  TextStyle? dashboardAxisLabel(Color color) =>
      bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w500);
}
