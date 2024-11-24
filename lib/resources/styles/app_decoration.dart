import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

class AppDecoration {


  // Fill decorations
  static BoxDecoration get fillBlue => const BoxDecoration(
        color: ColorName.primary,
      );

// Outline decorations
  static BoxDecoration get outlineGray => BoxDecoration(
        color: ColorName.white,
        border: Border.all(
          color: ColorName.gray500,
          width: 11.71.h,
        ),
      );
  static BoxDecoration get outlineSecondaryContainer => BoxDecoration(
        border: Border.all(
          color: ColorName.gray500,
          width: 1.8.h,
        ),
      );
// Primary decorations
  static BoxDecoration get primary250 => BoxDecoration(
        color: ColorName.white,
        border: Border.all(
          color: ColorName.gray500,
          width: 1.h,
        ),
      );

  static BoxDecoration getBoxDecoration(Color? color, {double? radius,Color? borderColor}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius ?? 0,),
        border: borderColor != null ? Border.all(
          color: borderColor ?? ColorName.gray500,
          width: 1.h,
        ) : null,
    );
  }
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder60 => BorderRadius.circular(
        60.h,
      );
// Custom borders
  static BorderRadius get customBorderTL24 => BorderRadius.vertical(
        top: Radius.circular(24.h),
      );
  static BorderRadius get customBorderTL26 => BorderRadius.only(
        topLeft: Radius.circular(26.h),
        topRight: Radius.circular(26.h),
        bottomLeft: Radius.circular(26.h),
        bottomRight: Radius.circular(24.h),
      );
  static BorderRadius get customBorderTL8 => BorderRadius.vertical(
        top: Radius.circular(8.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder18 => BorderRadius.circular(
        18.h,
      );
  static BorderRadius get roundedBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get roundedBorder54 => BorderRadius.circular(
        54.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        4.h,
      );

  static BorderRadius getRoundedBorder(int radius) {
    return BorderRadius.circular(
      4.h,
    );
  }
}
