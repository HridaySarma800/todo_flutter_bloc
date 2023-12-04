import 'dart:ui';

/// A utility class for managing colors in the application.
class ColorManager {
  /// The primary color used in the application, represented as a Color object.
  static final Color primary = HexColor.fromHex("#006666");
  static final Color secondary = HexColor.fromHex("#FFAC33");
}

/// An extension on the Color class to convert hexadecimal color codes to Color objects.
extension HexColor on Color {
  /// Converts a hexadecimal color code to a Color object.
  ///
  /// Parameters:
  ///   - [hexColorCode]: The hexadecimal color code to be converted.
  ///
  /// Returns:
  ///   - A Color object representing the specified hexadecimal color code.
  ///
  /// Example:
  ///   ```dart
  ///   Color color = HexColor.fromHex("#RRGGBB");
  ///   ```
  static Color fromHex(String hexColorCode) {
    hexColorCode = hexColorCode.replaceAll("#", "");
    if (hexColorCode.length == 6) {
      hexColorCode = "FF$hexColorCode";
    }
    // Parse the hexadecimal color code and return the corresponding Color object.
    return Color(int.parse(hexColorCode, radix: 16));
  }
}
