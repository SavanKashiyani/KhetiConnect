import 'package:flutter/material.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_text.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../util/text_styles.dart';
import '../../../../util/widget_util.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onClick;
  final bool isEnabled;
  final String? disabledMessage;
  final double? height;
  final bool? showMargin;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? showIconOnly;
  final bool? isLoading;
  final bool? isFilled;
  final Color? fillColor;
  final TextStyle? style;

  const CustomButton(
      {super.key,
      required this.onClick,
      required this.buttonText,
      this.isEnabled = true,
      this.disabledMessage,
      this.suffixIcon,
      this.showIconOnly,
      this.showMargin,
      this.height,
      this.prefixIcon,
      this.isLoading,
      this.isFilled = true,
      this.fillColor = ColorName.primary,
      this.style});

  @override
  Widget build(BuildContext context) {
    return _renderMobileButton(context);
  }

  Widget _renderMobileButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEnabled ?? true) {
          onClick();
        } else {
          if (disabledMessage != null) {}
        }
      },
      child: Container(
        height: height ?? 56,
        margin: showMargin ?? true ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: isEnabled
                ? (isFilled != null && isFilled == true)
                    ? fillColor
                    : ColorName.white
                : (isFilled != null && isFilled == true) ? ColorName.primary100 : Colors.white,
            border: (isFilled != null && isFilled == true) ?
            Border.all(color: fillColor!, width: 0, style: BorderStyle.none) :
            Border.all(color: isEnabled ? ColorName.primary : ColorName.primary100, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            showIconOnly ?? false
                ? isLoading ?? false
                    ? SizedBox(
                        height: 56,
                        width: 56,
                        child: Transform.scale(
                          scale: 0.7,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorName.white,
                          ),
                        ),
                      )
                    : suffixIcon!
                : Row(
                    children: [
                      prefixIcon != null ? prefixIcon! : Container(),
                      prefixIcon != null ? addWidth(12) : const SizedBox.shrink(),
                      CustomText(
                        key: key,
                        text: buttonText,
                        style: style ??
                            TextStyles.jakarta.semiBold.of(16,
                                color: isFilled == true ? (isEnabled == true ? ColorName.white : ColorName.primary300) : (isEnabled==true ? ColorName.primary : ColorName.primary300),fontWeight: FontWeight.w600),
                        // textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
// isEnabled ?? true
// ? isFilled!
// ? ColorName.white
//     : ColorName.primary300
//     : ColorName.black