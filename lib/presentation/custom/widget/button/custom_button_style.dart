import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

import '../../../../util/text_styles.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillBlueGray => ElevatedButton.styleFrom(
        backgroundColor: ColorName.gray50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      );

  static ButtonStyle get squareButton => ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(48, 48),
        padding: EdgeInsets.zero,
        backgroundColor: ColorName.gray50,
        disabledBackgroundColor: ColorName.primary100,
        foregroundColor: ColorName.gray700,
        disabledForegroundColor: ColorName.primary300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      );

  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: ColorName.primary,
        disabledBackgroundColor: ColorName.primary100,
        foregroundColor: ColorName.white,
        disabledForegroundColor: ColorName.primary300,
        textStyle: TextStyles.jakarta.semiBold.of(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      );

// Outline button style
  static ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: const BorderSide(
          color: ColorName.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.h),
        ),
      );

// text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
