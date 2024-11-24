import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/di/locator.dart';
import 'package:kheticonnect/resources/styles/padding.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../../util/text_styles.dart';

void getBottomSheet({required String title, required List<Widget> children,bool addPadding = true}) {
  showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 1,
    context: appContext,
    useSafeArea: true,
    backgroundColor: ColorName.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) {
      return Container(
        padding : EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: ColorName.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Padding(
          padding:  addPadding ? AppPadding.screensPadding : const EdgeInsets.only(top:16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  child: Container(
                height: 4,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorName.gray600,
                ),
              )),
              addHeight(16),
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style:
                      TextStyles.exo.semiBold.of(18, color: ColorName.primary),
                ),
              ).addPaddingOnly(left: 16, right: 16),
              addHeight(16),
              const Divider(height: 1, color: ColorName.primary100).addPaddingOnly(left: 16, right: 16),
              addHeight(16),
              ...children,
            ],
          ),
        ),
      );
    },
  );
}
