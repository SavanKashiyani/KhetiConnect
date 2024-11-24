import 'package:flutter/material.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/screen/my_rentals/widget/product_status_widget.dart';
import 'package:kheticonnect/util/extensions.dart';
import 'package:kheticonnect/util/size_utils.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../resources/styles/app_decoration.dart';
import '../../../../util/text_styles.dart';
import '../../../../util/widget_util.dart';
import '../../../custom/widget/button/custom_icon_button.dart';
import '../../../custom/widget/custom_image_view.dart';
import '../../../custom/widget/custom_text.dart';

class RowRentalProduct extends BaseWidget {
  final Function()? onFavoriteClick;
  final bool isFavoriteAllow;
  final Product product;
  final Function? onItemClick;

  RowRentalProduct({
    super.key,
    required this.product,
    this.onFavoriteClick,
    this.isFavoriteAllow = false,
    this.onItemClick
  });

  @override
  Widget build(BuildContext context) {
    return _renderRowRental();
  }

  _renderRowRental() {
    return GestureDetector(
      onTap: () {
        onItemClick?.call();
      },
      child: Container(
        width: double.maxFinite,
        decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
        child: Column(
          children: [_renderProductImage(), _buildProductInfo()],
        ),
      ),
    );
  }

  _renderProductImage() {
    return Stack(
      children: [
        CustomImageView(
          imagePath: product.images?.firstOrNull?.url,
          height: 140.v,
          width: double.infinity,
          fit: BoxFit.cover,
          radius: BorderRadius.only(
            topLeft: Radius.circular(8.h),
            topRight: Radius.circular(8.h),
          ),
        ),
        if (isFavoriteAllow) _renderFavIcon(),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: product.name ?? '',
            style: TextStyles.exo.semiBold.of(
              16,
              color: ColorName.gray800,
            ),
          ),
          addHeight(8),
          if (product.status?.value != null)
            ProductStatusWidget(productStatus: product.status!),
        ],
      ),
    );
  }

  _renderFavIcon() {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.v,
        right: 10.h,
      ),
      child: CustomIconButton(
        height: 28,
        width: 28,
        onTap: () {
          onFavoriteClick?.call();
        },
        padding: const EdgeInsets.all(6),
        alignment: Alignment.topRight,
        decoration: AppDecoration.getBoxDecoration(
            ColorName.white.withOpacity(0.8),
            radius: 28),
        child: CustomImageView(
          imagePath: product.isFavorite == true
              ? Assets.drawables.icFavoriteRed.path
              : Assets.drawables.icFavoriteGray.path,
        ),
      ),
    );
  }
}
