import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

import '../../../../resources/styles/app_decoration.dart';
import '../../../../util/text_styles.dart'; // ignore: must_be_immutable

class RowProductInfo extends StatelessWidget {
  final String title;
  final String desc;

  const RowProductInfo({Key? key, required this.title, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      padding: EdgeInsets.all(8.h),
      decoration: AppDecoration.getBoxDecoration(Colors.white).copyWith(
        borderRadius: BorderRadiusStyle.getRoundedBorder(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.jakarta.medium.of(
              12,
              color: ColorName.gray500,
            ),
          ),
          const Spacer(),
          Text(
            desc,
            style: TextStyles.jakarta.semiBold.of(
              14,
              color: ColorName.gray800,
            ),
          )
        ],
      ),
    );
  }
}
