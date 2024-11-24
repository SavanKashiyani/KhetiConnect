import 'package:flutter/material.dart';

import '/gen/colors.gen.dart';
import '../../util/text_styles.dart';

ThemeData get appTheme => ThemeData(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ColorName.white,
  colorScheme: ColorScheme.dark(
    onPrimary: ColorName.primary,
    onSurface: ColorName.primary,

  ),
      // sliderTheme: SliderThemeData(
      //     allowedInteraction: SliderInteraction.slideOnly,
      //     activeTrackColor: ColorName.color7,
      //     inactiveTrackColor: ColorName.color4,
      //     trackHeight: 3,
      //     thumbColor: ColorName.color7,
      //     overlayColor: ColorName.color7.withOpacity(0.1),
      //     overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
      //     rangeThumbShape: const RoundRangeSliderThumbShape(
      //       enabledThumbRadius: 6,
      //     )),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: ColorName.primary,
        color: ColorName.white,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: ColorName.primary,
          selectionColor: ColorName.primary.withOpacity(0.2),
          cursorColor: ColorName.primary),
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          vertical: -2,
          horizontal: -2,
        ),
        checkColor: MaterialStateProperty.all(ColorName.white),
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return ColorName.primary;
            } else {
              return ColorName.white;
            }
          },
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: ColorName.white,
        headerForegroundColor: ColorName.primary,

        // dayForegroundColor: ,
        //u need to match the text color also
        dayBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorName.primary;
          }
          return Colors.white;
        }),
        dayForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorName.white;
          } else if (states.contains(MaterialState.disabled)) {
            return ColorName.gray400;
          }
          return ColorName.primary;
        }),
        todayBorder: BorderSide(
          color: ColorName.white,
          width: 1,
        ),
        todayForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorName.white;
          }
          return ColorName.primary;
        }),
        todayBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorName.primary;
          }
          return ColorName.white;
        }),
        yearForegroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorName.white;
          }
          return ColorName.primary;
        }),
        yearBackgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorName.primary;
          }
          return ColorName.white;
        }),
        weekdayStyle: TextStyles.jakarta.semiBold.of(16, color: ColorName.primary),
        cancelButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(ColorName.primary), textStyle: MaterialStateProperty.all(TextStyles.exo.semiBold.of(18))),
        confirmButtonStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(ColorName.primary), textStyle: MaterialStateProperty.all(TextStyles.exo.semiBold.of(18))),
        headerHeadlineStyle: TextStyles.jakarta.semiBold.of(22, color: ColorName.primary),
        dividerColor: ColorName.primary
      ),
      radioTheme: RadioThemeData(
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return ColorName.primary;
            } else {
              return ColorName.gray400;
            }
          },
        ),
      ),
    );
