import 'package:flutter/material.dart';

/// Utility class for color-related operations
///
/// Provides centralized methods for color conversions, manipulations, and transformations
/// used throughout the application.
class ColorUtils {
  ColorUtils._();

  /// Converts a Color to an ARGB32 integer value for database storage
  ///
  /// [color] - The Color object to convert
  /// Returns the ARGB32 integer representation of the color
  ///
  /// Example:
  /// ```dart
  /// final color = Colors.blue;
  /// final intValue = ColorUtils.toARGB32(color);
  /// ```
  static int toARGB32(Color color) {
    return color.toARGB32();
  }

  /// Converts an ARGB32 integer value to a Color object
  ///
  /// [value] - The ARGB32 integer value from database
  /// Returns a Color object representing the color
  ///
  /// Example:
  /// ```dart
  /// final intValue = 0xFF2196F3; // Blue color
  /// final color = ColorUtils.fromARGB32(intValue);
  /// ```
  static Color fromARGB32(int value) {
    return Color(value);
  }

  /// Creates a new Color with the specified alpha value
  ///
  /// [color] - The base color
  /// [alpha] - The alpha value between 0.0 and 1.0
  /// Returns a new Color with the specified alpha
  ///
  /// Example:
  /// ```dart
  /// final baseColor = Colors.blue;
  /// final transparentColor = ColorUtils.withAlpha(baseColor, 0.5);
  /// ```
  static Color withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }

  /// Creates a new Color with the specified opacity
  ///
  /// [color] - The base color
  /// [opacity] - The opacity value between 0.0 and 1.0
  /// Returns a new Color with the specified opacity
  ///
  /// Example:
  /// ```dart
  /// final baseColor = Colors.blue;
  /// final semiTransparentColor = ColorUtils.withOpacity(baseColor, 0.5);
  /// ```
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Gets the integer value of a Color (ARGB32 format)
  ///
  /// [color] - The Color object
  /// Returns the integer value of the color
  ///
  /// Example:
  /// ```dart
  /// final color = Colors.blue;
  /// final value = ColorUtils.getValue(color);
  /// ```
  static int getValue(Color color) {
    return color.toARGB32();
  }

  /// Creates a Color from RGB values
  ///
  /// [r] - Red component (0-255)
  /// [g] - Green component (0-255)
  /// [b] - Blue component (0-255)
  /// [a] - Alpha component (0-255), defaults to 255 (fully opaque)
  /// Returns a Color object
  ///
  /// Example:
  /// ```dart
  /// final color = ColorUtils.fromRGB(33, 150, 243); // Blue color
  /// ```
  static Color fromRGB(int r, int g, int b, [int a = 255]) {
    return Color.fromARGB(a, r, g, b);
  }

  /// Creates a Color from ARGB values
  ///
  /// [a] - Alpha component (0-255)
  /// [r] - Red component (0-255)
  /// [g] - Green component (0-255)
  /// [b] - Blue component (0-255)
  /// Returns a Color object
  ///
  /// Example:
  /// ```dart
  /// final color = ColorUtils.fromARGB(255, 33, 150, 243); // Blue color
  /// ```
  static Color fromARGB(int a, int r, int g, int b) {
    return Color.fromARGB(a, r, g, b);
  }

  /// Parses a hex color string to a Color object
  ///
  /// [hexString] - Hex color string (e.g., "#FF2196F3" or "FF2196F3")
  /// Returns a Color object, or throws FormatException if invalid
  ///
  /// Example:
  /// ```dart
  /// final color = ColorUtils.fromHex("#FF2196F3");
  /// final color2 = ColorUtils.fromHex("FF2196F3");
  /// ```
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff'); // Add alpha if missing
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Converts a Color to a hex string
  ///
  /// [color] - The Color object to convert
  /// [includeAlpha] - Whether to include alpha in the hex string, defaults to true
  /// Returns a hex string representation (e.g., "#FF2196F3")
  ///
  /// Example:
  /// ```dart
  /// final color = Colors.blue;
  /// final hex = ColorUtils.toHex(color); // "#FF2196F3"
  /// ```
  static String toHex(Color color, {bool includeAlpha = true}) {
    final argb = color.toARGB32();
    if (includeAlpha) {
      return '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    } else {
      return '#${argb.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    }
  }
}
