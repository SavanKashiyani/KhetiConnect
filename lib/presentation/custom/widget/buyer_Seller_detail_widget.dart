import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../resources/strings.dart';
import '../../../resources/styles/app_decoration.dart';
import '../../../util/text_styles.dart';
import '../../../util/widget_util.dart';
import 'custom_image_view.dart';
import 'custom_text.dart';

//ignore: must_be_immutable
class BuyerSellerDetailsWidget extends BaseWidget {
   Product? product;
  late String title;
  late String subTitle;
  late BuyerSellerDetails? personDetails;
  late bool showArrowIcon;
  final bool showReviews;
  late bool showBuyerReviews;
  Function()? onTap;

  BuyerSellerDetailsWidget.buyer(
      {super.key, required this.showReviews,required this.personDetails,this.onTap, this.showBuyerReviews = true}) {
    title = Strings.buyerDetails();
    subTitle = Strings.buyer();
    showArrowIcon = false;
    // showBuyerReviews = true;
  }

  BuyerSellerDetailsWidget.seller(
      {super.key, required this.product, required this.showReviews, this.showArrowIcon = true, this.onTap, this.personDetails}) {
    title = Strings.sellerDetails();
    subTitle = Strings.seller();
    personDetails = product?.sellerDetails ?? personDetails;
    showBuyerReviews = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleWidget(),
          _buildPersonWidget(),
          _buildRatingAndReviewWidgets()
        ],
      ),
    );
  }

  _buildTitleWidget() {
    return Text(
      title,
      style: TextStyles.exo.semiBold.of(18, color: ColorName.primary),
    );
  }

  _buildPersonWidget() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorName.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomImageView(
              imagePath: personDetails?.profileImage,
              height: 56,
              width: 56,
              radius: const BorderRadius.all(Radius.circular(8)),
            ),
            addWidth(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle,
                  style: TextStyles.jakarta.medium.of(14, color: ColorName.gray500),
                ),
                addHeight(6),
                Text(
                  personDetails?.name ?? '',
                  style:
                      TextStyles.jakarta.semiBold.of(16, color: ColorName.gray800),
                ),
              ],
            ).expanded,
            _buildBuyerRatingReviewWidget(),
            _buildArrowIconWidget(),
          ],
        ).addPadding(padding: const EdgeInsets.only(top: 12)),
      ),
    );
  }

  _buildArrowIconWidget() {
    if (!showArrowIcon) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: AppDecoration.getBoxDecoration(ColorName.gray50, radius: 4),
      child: Assets.drawables.icArrowRight
          .svg(height: 24, width: 24, fit: BoxFit.contain),
    );
  }

  _buildRatingAndReviewWidgets() {
    if (!showReviews) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: (){
        // navigation.push(Routes.rateReviewList(product : product ,user : personDetails, isSeller : true),);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _getRatingAndReviewWidget(
              title: Strings.productReviews(),
              rating: product?.productRating,
              reviewCount: product?.productReviews,
            onTap: (){
            }
          ),
          addWidth(12),
          _getRatingAndReviewWidget(
              title: Strings.sellerReviews(),
              rating: personDetails?.ratings,
              reviewCount: personDetails?.reviews,
            onTap: (){
            }
          ),
        ],
      ).addPadding(padding: const EdgeInsets.only(top: 12)),
    );
  }

  _getRatingAndReviewWidget({
    required String title,
    required num? rating,
    required num? reviewCount,
    required Function()? onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: AppDecoration.getBoxDecoration(ColorName.gray50, radius: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.jakarta.medium.of(12, color: ColorName.gray500),
            ),
            addHeight(12),
            Row(
              children: [
                RatingBarIndicator(
                  rating: rating?.toDouble() ?? 0,
                  itemBuilder: (context, index) => Assets.drawables.icStar.svg(
                    height: 14,
                    width: 14,
                    fit: BoxFit.fitHeight,
                  ),
                  itemCount: 5,
                  itemSize: 16,
                  unratedColor: ColorName.gray300,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                ),
                addWidth(4),
                Flexible(
                  child: CustomText(
                    text: Strings.numberInBraces(rating),
                    style:
                        TextStyles.jakarta.medium.of(12, color: ColorName.gray600),
                    maxLines: 1,
                    maxFontSize: 12,
                  ),
                ),
              ],
            ),
            addHeight(4),
            CustomText(
              text: Strings.noOfReviewsInBraces(reviewCount?.toString() ?? ''),
              style: TextStyles.jakarta.medium.of(12, color: ColorName.gray600, underline: true),
            ),
          ],
        ),
      ),
    ).expanded;
  }

  Widget _buildBuyerRatingReviewWidget() {
    if(!showBuyerReviews) {
      return const SizedBox.shrink();
    }
    return Column(
        children: [
          Row(
            children: [
              RatingBarIndicator(
                // rating: product.buyerDetails?.sellerRating?.toDouble() ?? 0,
                rating: 1,
                itemBuilder: (context, index) => Assets.drawables.icStar.svg(
                  height: 14,
                  width: 14,
                  fit: BoxFit.fitHeight,
                ),
                itemCount: 1,
                itemSize: 16,
                unratedColor: ColorName.gray300,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
              ),
              addWidth(4),
              CustomText(
                text: Strings.numberInBraces(product?.buyerDetails?.ratings ?? personDetails?.ratings),
                style:
                TextStyles.jakarta.medium.of(12, color: ColorName.gray600),
              ),
            ],
          ),
          addHeight(4),
          CustomText(
            text: Strings.noOfReviewsInBraces((product?.buyerDetails?.reviews ?? personDetails?.reviews)?.toString() ?? ''),
            style: TextStyles.jakarta.medium.of(12, color: ColorName.gray600, underline: true),
          ),
        ],
      ).addPaddingOnly(left: 20,bottom: 10,top: 20);
  }
}
