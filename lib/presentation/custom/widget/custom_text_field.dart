import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_text.dart';
import 'package:kheticonnect/util/input_formatter.dart';

import '../../../util/text_styles.dart';

class CustomTextField extends StatelessWidget {


  CustomTextField(
      {Key? key,
      this.isDisabled = false,
      this.alignment,
      this.width,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.title,
      this.validator,
      this.inputFormatters,
      this.onChanged,
      })
      : super(
          key: key,
        );

  final bool isDisabled;

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final String? hintText;
  final String? title;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context))
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ..._renderTitle(title!),
          SizedBox(
            width: width ?? double.maxFinite,
            child: TextFormField(
              scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              controller: controller,
              focusNode: focusNode,
              maxLength: maxLength,
              onTapOutside: (event) {
                if (focusNode != null) {
                  focusNode?.unfocus();
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              autofocus: autofocus!,
              onChanged: onChanged,
              style: textStyle ?? TextStyles.jakarta.medium.of(16, color: ColorName.black),
              obscureText: obscureText!,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              keyboardType: textInputType,
              maxLines: maxLines ?? 1,
              minLines: minLines ?? 1,
              decoration: decoration,
              validator: validator,
              enabled: !isDisabled,
            ),
          ),
        ],
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? TextStyles.jakarta.medium.of(14,color : ColorName.gray400),
        prefixIcon: prefix!=null ? Container(
          width: 25.h,
          height: 25.v,
          margin: EdgeInsets.fromLTRB(10.h, 12.v, 5.h, 12.v),
          child: prefix,
        ) : null,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix!=null ? Container(
          width: 25.h,
          height: 25.v,
          margin: EdgeInsets.fromLTRB(0.h, 12.v, 5.h, 12.v),
          child: suffix,
        ) : null,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 14.v,
              right: 14.h,
              left: 14.h,
              bottom: 14.v,
            ),
        fillColor: fillColor ?? ColorName.white,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: ColorName.primary50,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: ColorName.primary50,
                width: 1,
              ),
            ),
        disabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: ColorName.primary50,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: ColorName.primary,
                width: 1,
              ),
            ),
      );

  _renderTitle(String title) {
    return [
      CustomText(text: title, style: TextStyles.jakarta.medium.of(14, color: ColorName.gray700,fontWeight: FontWeight.w500,)),
      SizedBox(height: 8.v),
    ];
  }
}
