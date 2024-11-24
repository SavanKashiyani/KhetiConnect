import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:kheticonnect/core/app_export.dart';

import '../../../util/text_styles.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField(
      {Key? key,
      required this.context,
      required this.onChanged,
      this.alignment,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.validator})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  final Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget)
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 4,
        keyboardType: TextInputType.number,
        hintCharacter: '-',
        textStyle: textStyle ?? TextStyles.jakarta.semiBold.of(20, color: ColorName.primary,).copyWith(fontWeight: FontWeight.w600),
        hintStyle: hintStyle ??TextStyles.jakarta.semiBold.of(20, color: ColorName.gray100,).copyWith(fontWeight: FontWeight.w600),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        enableActiveFill: true,
        showCursor: false,
        animationType: AnimationType.fade,
        focusNode: FocusNode(),
        autoFocus: true,
        pinTheme: PinTheme(
          fieldHeight: 48.h,
          fieldWidth: 48.h,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(4.h),
          inactiveColor: ColorName.gray100,
          activeColor: ColorName.primary,
          inactiveFillColor: ColorName.white,
          activeFillColor: ColorName.white,
          selectedColor: ColorName.primary,
          selectedFillColor: ColorName.white,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
