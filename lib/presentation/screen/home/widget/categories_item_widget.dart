import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/model/GetCategoriesResModel.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../../resources/styles/app_decoration.dart';
import '../../../../util/text_styles.dart';

class CategoriesItemWidget extends StatelessWidget {
  final Categories category;
  final int maxLines;
  final Function(Categories)? onCategoryClick;

  const CategoriesItemWidget({
    Key? key,
    required this.category,
    this.onCategoryClick,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomImageView(
            imagePath: category.icon ?? "",
            height: 36.adaptSize,
            width: 36.adaptSize,
          ),
          SizedBox(height: 8.v),
          Center(
            child: Text(
              category.name ?? "",
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyles.jakarta.semiBold.of(12, color: ColorName.primary),
            ),
          )
        ],
      ),
    ).addOnTap(() {
      onCategoryClick?.call(category);
    });
  }
}
