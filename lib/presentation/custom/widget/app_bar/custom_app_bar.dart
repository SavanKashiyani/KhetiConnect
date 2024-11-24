import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/util/size_utils.dart';

import 'appbar_leading_image.dart';
import 'appbar_title.dart';

enum Style { bgFill }

// ignore: must_be_immutable
class CustomAppBar extends BaseWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      this.height,
      this.styleType,
      this.leadingWidth,
      this.title,
      this.centerTitle,
        this.onBackPress,
        this.allowBack = true,
      this.actions})
      : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final String? title;

  final bool? centerTitle;
  final bool allowBack;

  final List<Widget>? actions;

  final Function? onBackPress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 56.v,
      automaticallyImplyLeading: false,
      backgroundColor: ColorName.white,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 40.h,
      leading: allowBack ? AppbarLeadingImage(
        leadingImage: Assets.images.imgArrowLeft.svg(
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
        onTap: () {
          onBackPress != null
              ? onBackPress!()
              :
          navigation.pop();
        },
      ) : null,
      title: AppbarTitle(
        text: title ?? '-',
      ),
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 56.v,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFill:
        return Container(
          height: 56.v,
          width: 374.h,
          decoration: const BoxDecoration(
            color:ColorName.white,
          ),
        );
      default:
        return null;
    }
  }
}
