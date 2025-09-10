import 'package:flutter/material.dart';

mixin ColorHelper {
  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.parse(hex, radix: 16));
  }

  Color getContrastColor(String hexColor) {
    Color color = hexToColor(hexColor);

    double luminance = color.computeLuminance();

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
