import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../../resources/styles/app_decoration.dart';
import '../../../../util/text_styles.dart';
import '../../../custom/widget/button/custom_icon_button.dart';

class ProductCardItemWidget extends StatelessWidget {
  final Product product;
  final double width;
  final double height;
  final Function(Product)? onFavoriteClick;
  final Function(Product)? onProductClick;

  const ProductCardItemWidget({
    Key? key,
    required this.product,
    required this.width,
    required this.height,
    this.onFavoriteClick,
    this.onProductClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isFavorite = product.isFavorite ?? false;
    return Container(
      decoration: AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CustomImageView(
                  imagePath: product.images?.firstOrNull?.url ?? '',
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.v,
                    right: 10.h,
                  ),
                  child: CustomIconButton(
                    height: 28,
                    width: 28,
                    onTap: () => onFavoriteClick?.call(product),
                    padding: const EdgeInsets.all(6),
                    alignment: Alignment.topRight,
                    decoration: AppDecoration.getBoxDecoration(
                        ColorName.white.withOpacity(0.8),
                        radius: 28),
                    child: CustomImageView(
                      imagePath: isFavorite
                          ? Assets.drawables.icFavoriteRed.path
                          : Assets.drawables.icFavoriteGray.path,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.exo.semiBold
                        .of(16, color: ColorName.primary),
                  ),
                  SizedBox(height: 2.v),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomImageView(
                        imagePath: Assets.drawables.icProductType.path,
                        height: 14.adaptSize,
                        width: 14.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          product.category ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.jakarta.medium
                              .of(10, color: ColorName.gray500),
                        ),
                      ).expanded
                    ],
                  ),
                  SizedBox(height: 6.v),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: Strings.currencyAmount(
                                  product.pricePerDay ?? ""),
                              style: TextStyles.jakarta.semiBold
                                  .of(16, color: ColorName.gray800),
                            ),
                            TextSpan(
                              text: Strings.perDay(),
                              style: TextStyles.jakarta.medium
                                  .of(10, color: ColorName.gray500),
                            )
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomImageView(
                            imagePath: Assets.drawables.icStar.path,
                            height: 14.adaptSize,
                            width: 14.adaptSize,
                            margin: EdgeInsets.only(bottom: 2.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.h,
                              bottom: 2.v,
                            ),
                            child: Text(
                              product.avgRating.toString(),
                              style: TextStyles.jakarta.medium
                                  .of(10, color: ColorName.gray500),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ).addOnTap(() {
      onProductClick?.call(product);
    });
  }
}
