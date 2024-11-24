import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/resources/styles/app_decoration.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../data/model/product.dart';
import '../../../util/text_styles.dart';

class ImagesGridTitleDescriptionWidget extends StatelessWidget {
  final List<Images> imageList;
  final String? title;
  final String? descriptionHeader;
  final String? descriptionText;

  const ImagesGridTitleDescriptionWidget({
    super.key,
    required this.imageList,
    this.title,
    this.descriptionHeader,
    this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: TextStyles.exo.semiBold.of(18, color: ColorName.primary),
            ).addPaddingOnly(bottom: 12),
          GridView.builder(
            shrinkWrap: true,
            itemCount: imageList.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return CustomImageView(
                imagePath: imageList[index].url,
                radius: BorderRadius.circular(8),
              );
            },
          ),
          if (descriptionHeader != null)
            Text(
              descriptionHeader!,
              style: TextStyles.exo.semiBold.of(18, color: ColorName.primary),
            ).addPaddingOnly(top: 20),
          if (descriptionText != null)
            Text(
              descriptionText!,
              style: TextStyles.jakarta.medium.of(14, color: ColorName.gray500),
            ).addPaddingOnly(top: 12),
        ],
      ),
    );
  }
}
