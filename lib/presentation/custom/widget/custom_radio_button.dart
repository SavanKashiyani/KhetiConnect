import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

import '../../../util/text_styles.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomRadioButton<T> extends StatelessWidget {
  CustomRadioButton(
      {Key? key,
      required this.onChange,
      this.decoration,
      this.alignment,
      this.isRightCheck,
      this.iconSize,
      this.value,
      this.groupValue,
      this.text,
      this.width,
      this.padding,
      this.textStyle,
      this.textAlignment,
      this.gradient,
      this.backgroundColor})
      : super(
          key: key,
        );

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  T? value;

  final T? groupValue;

  final Function(T) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final Gradient? gradient;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildRadioButtonWidget)
        : buildRadioButtonWidget;
  }

  bool get isGradient => gradient != null;
  BoxDecoration get gradientDecoration => BoxDecoration(gradient: gradient);
  Widget get buildRadioButtonWidget => GestureDetector(
        onTap: () {
          onChange(value!);
        },
        child: Container(
          decoration: decoration,
          width: width,
          padding: padding ?? EdgeInsets.zero,
          child: (isRightCheck ?? false)
              ? rightSideRadioButton
              : leftSideRadioButton,
        ),
      );
  Widget get leftSideRadioButton => Row(
        children: [
          Padding(
            child: radioButtonWidget,
            padding: EdgeInsets.only(right: 8),
          ),
          textWidget
        ],
      );
  Widget get rightSideRadioButton => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget,
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: radioButtonWidget,
          )
        ],
      );
  Widget get textWidget => Flexible(
    child: CustomText(
          text: text ?? "",
          textAlign: textAlignment ?? TextAlign.start,
          style: textStyle ?? TextStyles.jakarta.medium.of(14,color: ColorName.gray500,fontWeight: FontWeight.w500,),
      maxLines: 1,
      maxFontSize: 14,
        ),
  );
  Widget get radioButtonWidget => SizedBox(
        height: iconSize,
        width: iconSize,
        child: Radio<T?>(
          value: value,
          groupValue: groupValue,
          onChanged: (value) {
            onChange(value!);
          },
        ),
      );
  BoxDecoration get radioButtonDecoration =>
      BoxDecoration(color: backgroundColor);
}
