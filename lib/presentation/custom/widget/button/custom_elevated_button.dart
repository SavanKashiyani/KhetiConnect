import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/util/extensions.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../util/text_styles.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  CustomElevatedButton(
      {Key? key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      EdgeInsets? margin,
      VoidCallback? onPressed,
      ButtonStyle? buttonStyle,
      Alignment? alignment,
      TextStyle? buttonTextStyle,
      bool? isDisabled,
      double? height,
      double? width,
      required String text})
      : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;

  final SvgGenImage? leftIcon;

  final SvgGenImage? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget)
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: this.height ?? 48.v,
        width: this.width,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon?.svg(
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                  ) ??
                  const SizedBox.shrink(),
              Text(text),
              rightIcon?.svg(
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    colorFilter: ColorFilter.mode(
                        isDisabled == true
                            ? ColorName.primary300
                            : Colors.white,
                        BlendMode.srcIn),
                  ).addPaddingOnly(left: 8) ??
                  const SizedBox.shrink()
            ],
          ),
        ),
      );
}
