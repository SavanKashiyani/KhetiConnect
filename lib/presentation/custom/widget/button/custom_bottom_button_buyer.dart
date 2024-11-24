import 'package:flutter/material.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../resources/strings.dart';
import '../../../../util/text_styles.dart';
import '../custom_text.dart';
import 'custom_button_style.dart';
import 'custom_elevated_button.dart';

class CustomBottomButtonBuyer extends StatelessWidget {
  final String pricePerDay;
  final String buttonText;
  final Function onTap;
  final bool isButtonEnabled;

  const CustomBottomButtonBuyer({
    super.key,
    required this.pricePerDay,
    required this.buttonText,
    required this.onTap,
    this.isButtonEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(24, 12, 20, 24),
      decoration: const BoxDecoration(
          color: ColorName.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: Strings.currencyAmount(pricePerDay),
                style: TextStyles.exo.semiBold
                    .of(24, color: ColorName.primary)
                    .copyWith(),
              ),
              CustomText(
                text: Strings.strPerDay(),
                style:
                    TextStyles.jakarta.medium.of(12, color: ColorName.gray600),
              ),
            ],
          ).expanded,
          CustomElevatedButton(
            text: buttonText,
            isDisabled: !isButtonEnabled,
            rightIcon: Assets.drawables.icArrowRight,
            buttonStyle: CustomButtonStyles.fillPrimary,
            onPressed: () {
              onTap();
            },
          )
        ],
      ),
    );
  }
}
