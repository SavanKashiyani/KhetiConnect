import 'package:flutter/material.dart';

Color? stringToColor(String? colorStr) {
  if (colorStr == null) {
    return null;
  }
  try {
    colorStr = colorStr.toUpperCase();
    int colorValue = int.parse(colorStr.substring(1), radix: 16) + 0xFF000000;
    return Color(colorValue);
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
