import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage({Key? key, this.leadingImage, this.margin, this.onTap})
      : super(
          key: key,
        );

  Widget? leadingImage;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.only(
          left: 14.h,
          top: 14.v,
          bottom: 14.v,
        ),
        child: leadingImage,
      ),
    );
  }
}
