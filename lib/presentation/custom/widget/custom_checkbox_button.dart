import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

import '../../../util/text_styles.dart';

// ignore_for_file: must_be_immutable
class CustomCheckboxButton extends StatefulWidget {
  CustomCheckboxButton(
      {Key? key,
      required this.onChange,
      this.decoration,
      this.alignment,
      this.isRightCheck,
      this.iconSize,
      this.value,
      this.text,
      this.width,
      this.padding,
      this.textStyle,
      this.textAlignment,
      this.isExpandedText = false})
      : super(
          key: key,
        );

  final BoxDecoration? decoration;

  final Alignment? alignment;

  final bool? isRightCheck;

  final double? iconSize;

  bool? value;

  final Function(bool) onChange;

  final String? text;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final TextAlign? textAlignment;

  final bool isExpandedText;

  @override
  State<CustomCheckboxButton> createState() => _CustomCheckboxButtonState();
}

class _CustomCheckboxButtonState extends State<CustomCheckboxButton> {
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: buildCheckBoxWidget)
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => GestureDetector(
        onTap: () {
          widget.value = !(widget.value!);
          setState(() {
            widget.onChange(widget.value!);
          });
        },
        child: AbsorbPointer(
          child: Container(
            decoration: widget.decoration,
            width: widget.width,
            child: (widget.isRightCheck ?? false)
                ? rightSideCheckbox
                : leftSideCheckbox,
          ),
        ),
      );

  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            child: checkboxWidget,
            padding: widget.padding ?? EdgeInsets.only(right: 8),
          ),
          widget.isExpandedText ? Expanded(child: textWidget) : textWidget
        ],
      );

  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: widget.padding ?? EdgeInsets.only(left: 8),
            child: checkboxWidget,
          )
        ],
      );

  Widget get textWidget => CustomText(
        text: widget.text ?? "",
        textAlign: widget.textAlignment ?? TextAlign.start,
        style: widget.textStyle ??
            TextStyles.jakarta.medium.of(14, color: ColorName.gray500),
      );

  Widget get checkboxWidget => SizedBox(
        height: widget.iconSize,
        width: widget.iconSize,
        child: Checkbox(
          value: widget.value ?? false,
          onChanged: (value) {
            setState(() {
              widget.onChange(value!);
            });
          },
        ),
      );
}
