import 'package:kheticonnect/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import '/util/app_const.dart';
import '/util/text_styles.dart';

class ToastService {
  void errorToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorName.red,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyles.jakarta.medium.of(16, color: ColorName.white),
        ),
        duration: const Duration(milliseconds: AppConst.snackBarDuration),
      ),
    );
  }

  void successToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyles.jakarta.medium.of(16, color: ColorName.white),
        ),
        duration: const Duration(milliseconds: AppConst.snackBarDuration),
      ),
    );
  }
}
