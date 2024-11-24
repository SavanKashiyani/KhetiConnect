import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../util/text_styles.dart';
import '../../service/navigation.dart';
import 'button/custom_button.dart';

class BaseAlertDialog {
  final navigation = GetIt.I<NavigationService>();
  Future<dynamic> alertDialog(BuildContext context,
      {String? title,
      String? imagePath,
      String? description,
        Widget? imageWidget,
        bool showButtons = true,
        String? positiveButtonText, Function? onPositiveButtonClick, bool dismissible = true, String? negativeButtonText}) {
    return showDialog(
        context: context,
        // barrierColor: Colors.white.withOpacity(0.1),
        builder: (BuildContext dialogContext) {
          return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
            child: Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0,horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    imageWidget ?? CustomImageView(
                      imagePath: imagePath ?? Assets.images.imgGroup33622.path,
                      height: 116.v,
                      width: 170.h,
                    ),
                    addHeight(22.v),
                    CustomText(
                      text: title ?? Strings.appName(),
                      style: TextStyles.exo.semiBold.of(20, color: ColorName.gray800,fontWeight: FontWeight.w600),
                    ),
                    addHeight(14.v),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(
                        text: description ?? Strings.appName(),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        style: TextStyles.jakarta.medium.of(12, color: ColorName.gray500,fontWeight: FontWeight.w500),
                      ),
                    ),
                    addHeight(20.v),
                    Row(
                      children: [
                        if (negativeButtonText != null)
                          CustomButton(
                            isFilled: false,
                            isEnabled: true,
                            fillColor: ColorName.white,
                            buttonText: negativeButtonText,
                            showMargin: false,
                            onClick: () {
                              // pop
                              navigation.pop();
                            },
                          ).expanded,
                        addWidth(20.h),
                        CustomButton(
                          showMargin: false,
                          isEnabled: true,
                          buttonText: positiveButtonText ?? Strings.submit(),
                          onClick: onPositiveButtonClick ??
                              () {
                                navigation.pop();
                              },
                        ).expanded,
                      ],
                    ).visibility(isVisible: showButtons)
                  ],
                ),
              ),
            ),
          );
        },
        barrierDismissible: dismissible);
  }

  Future<dynamic> alertListDialog(
    BuildContext context,
    Function(int) onItemClick, {
    List<String>? mList,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Theme(
            data: ThemeData(dialogBackgroundColor: Colors.white),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              content: SizedBox(
                // height: 300.0,
                width: 300.0, // Change as per your requirement
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        onItemClick(index);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomText(
                            text: mList![index],
                            style: TextStyles.exo.semiBold.of(
                              18,
                              color: ColorName.primary,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  _renderTitleWithImage(Widget titleWidget, Widget imageWidget) {
    return Column(
      children: [
        imageWidget,
        addHeight(24.v),
        titleWidget,
      ],
    );
  }
}
