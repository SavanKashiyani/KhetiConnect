import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';
import '../gen/fonts.gen.dart';


abstract class TextStyles {
  static const TextStyle exo =
      TextStyle(fontFamily: FontFamily.exo, fontWeight: FontWeight.normal);
  static const TextStyle jakarta =
      TextStyle(fontFamily: FontFamily.plusJakartaSans, fontWeight: FontWeight.normal);
}

extension TextSize on TextStyle {
  TextStyle of(
    double size, {
    Color color = ColorName.black,
    bool strikeThrough = false,
    bool underline = false,
        FontWeight fontWeight = FontWeight.normal,
  }) {
    return copyWith(
      fontSize: size,
      color: color,
      decorationColor: color,
      decorationThickness: 1,
      decoration:
          strikeThrough ? TextDecoration.lineThrough : underline ?TextDecoration.underline  : TextDecoration.none,
    );
  }
}

extension TextWeight on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  TextStyle get black => copyWith(fontWeight: FontWeight.w900);
}
