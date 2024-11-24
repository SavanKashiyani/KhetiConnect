import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/button/custom_bottom_button_buyer.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_refresh_indicator.dart';
import 'package:kheticonnect/presentation/screen/product_details/bloc/product_detail_bloc.dart';
import 'package:kheticonnect/presentation/screen/product_details/bloc/product_detail_event.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../resources/styles/app_decoration.dart';
import '../../../util/text_styles.dart';
import '../../base/api_render_state.dart';
import '../../custom/widget/app_bar/custom_app_bar.dart';
import '../../custom/widget/button/custom_icon_button.dart';
import '../../custom/widget/buyer_Seller_detail_widget.dart';
import '../../custom/widget/loader.dart';
import '../../service/navigation.dart';
import '../add_product/widget/row_product_info.dart';

class ProductDetailScreen extends BaseWidget {
  late final ProductDetailBloc _bloc;
  final Product product;

  ProductDetailScreen({Key? key, required this.product}) : super(key: key) {
    _bloc = ProductDetailBloc(productDetail: product);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, ApiRenderState state) {
        if (state is ApiFailure) {
          showError(state.data);
        }
      },
      builder: (context, ApiRenderState state) {
        return StackLoader(
          state: state,
          child: Scaffold(
            backgroundColor: ColorName.whiteBg,
            appBar: CustomAppBar(
              title: Strings.productDetails(),
              actions: [
                _renderPopupMenuIcon(),
                const SizedBox(width: 16),
              ],
            ),
            body: SafeArea(child: _renderBody()),
          ),
        );
      },
    );
  }

  Widget _renderPopupMenuIcon() {
    if (_bloc.productDetail == null) {
      return const SizedBox.shrink();
    }
    return PopupMenuButton<int>(
      icon: Assets.drawables.icMore.svg(height: 20, width: 20),
      color: ColorName.white,
      position: PopupMenuPosition.under,
      onSelected: (item) {
        navigation.push(Routes.reportProduct(product: _bloc.productDetail!));
      },
      itemBuilder: (context) => [
        PopupMenuItem<int>(
            value: 1,
            child: Text(
              Strings.reportProduct(),
              style:
                  TextStyles.jakarta.semiBold.of(14, color: ColorName.gray800),
            )),
      ],
    );
  }

  Widget _renderBody() {
    return Column(
      children: [
        Expanded(
          child: CustomProgressIndicator(
            onRefresh: () async {
              _bloc.add(LoadProductDetailEvent());
            },
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                    addHeight(16.v),
                    _buildProductImage(),
                    addHeight(16.v),
                    _buildGallerySection(),
                    addHeight(16.v),
                    _buildRentalInfo(),
                    addHeight(16.v),
                    _buildUserGuidelines(
                      guidelinesTitle: Strings.aboutProduct(),
                      guidelinesDescription:
                          _bloc.productDetail?.description ?? '',
                    ),
                    addHeight(16.v),
                    _buildUserGuidelines(
                      guidelinesTitle: Strings.userGuidelines(),
                      guidelinesDescription:
                          _bloc.productDetail?.userGuidelines ?? '',
                    ),
                    addHeight(16.v),
                    if (_bloc.isSeller != null &&
                        !_bloc.isSeller!) // Add this line
                      _buildSellerWidget(),
                    if (_bloc.isSeller != null && !_bloc.isSeller!)
                      addHeight(24.v),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildBottomButtonBar()
      ],
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        CustomImageView(
          imagePath: _bloc.productDetail?.images?.firstOrNull?.url ?? '',
          height: 184.v,
          fit: BoxFit.cover,
          width: double.maxFinite,
          radius: BorderRadius.circular(
            8.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10.v,
            right: 10.h,
          ),
          child: CustomIconButton(
            height: 28,
            width: 28,
            onTap: () => onFavoriteClick(),
            padding: const EdgeInsets.all(6),
            alignment: Alignment.topRight,
            decoration: AppDecoration.getBoxDecoration(
                ColorName.white.withOpacity(0.8),
                radius: 28),
            child: CustomImageView(
              imagePath: _bloc.productDetail?.isFavorite == true
                  ? Assets.drawables.icFavoriteRed.path
                  : Assets.drawables.icFavoriteGray.path,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGallerySection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.getBoxDecoration(Colors.white).copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: _bloc.productDetail?.name ?? '',
                      style: TextStyles.exo.semiBold.of(
                        20,
                        color: ColorName.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    addHeight(6.v),
                    Row(
                      children: [
                        Assets.images.icCategory.svg(width: 16.h, height: 16.h),
                        Padding(
                          padding: EdgeInsets.only(left: 6.h),
                          child: CustomText(
                            text: _bloc.productDetail?.category ?? '',
                            style: TextStyles.jakarta.medium.of(
                              14,
                              color: ColorName.gray500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: [
                    Assets.drawables.icStar.svg(height: 18, width: 18),
                    addWidth(4.v),
                    CustomText(
                      text:
                          _bloc.productDetail?.productRating?.toString() ?? '',
                      style: TextStyles.jakarta.semiBold.of(
                        16,
                        color: ColorName.gray500,
                      ),
                    )
                  ],
                ).visibility(
                    isVisible: _bloc.productDetail?.productRating != null),
              )
            ],
          ),
          _getGalleryWidget(),
        ],
      ),
    );
  }

  Widget _getGalleryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(20.v),
        CustomText(
          text: Strings.gallery(),
          style: TextStyles.exo.semiBold.of(
            18,
            color: ColorName.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        addHeight(10.v),
        SizedBox(
          height: 70.v,
          width: double.maxFinite,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 12.h,
              );
            },
            itemCount: (_bloc.productDetail?.images?.length ?? 0) - 1,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  navigation.push(Routes.productImageZoom(
                      _bloc.productDetail?.images?.map((e) => e.url).toList() ??
                          [],
                      index));
                },
                child: Container(
                  decoration: AppDecoration.getBoxDecoration(ColorName.gray50,
                      radius: 8, borderColor: ColorName.primary50),
                  child: CustomImageView(
                    imagePath: _bloc.productDetail?.images
                            ?.elementAtOrNull(++index)
                            ?.url ??
                        '',
                    height: 70.v,
                    width: 70.h,
                    radius: BorderRadius.circular(
                      4.h,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ).visibility(isVisible: (_bloc.productDetail?.images?.length ?? 0) > 1);
  }

  Widget _buildRentalInfo() {
    return SizedBox(
      height: 84,
      width: double.maxFinite,
      child: Row(
        children: [
          Flexible(
              child: RowProductInfo(
            title: Strings.minimumRentalPeriod(),
            desc:
                Strings.noOfDays(_bloc.productDetail?.minimumRentalPeriod ?? 0),
          )),
          addWidth(8),
          Flexible(
              child: RowProductInfo(
            title: Strings.productCondition(),
            desc: _bloc.productDetail!.productCondition.name,
          )),
          addWidth(8),
          Flexible(
              child: RowProductInfo(
            title: Strings.yearsOld(),
            desc: Strings.noOfYears(_bloc.productDetail?.yearsOld ?? 0),
          )),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildUserGuidelines({
    required String guidelinesTitle,
    required String guidelinesDescription,
  }) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: 8,
      ),
      decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addHeight(2),
          CustomText(
            text: guidelinesTitle,
            style: TextStyles.exo.semiBold.of(
              18,
              color: ColorName.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          addHeight(12),
          CustomText(
            text: guidelinesDescription,
            maxLines: 9,
            style: TextStyles.jakarta.medium.of(
              14,
              color: ColorName.gray500,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSellerWidget() {
    if (_bloc.productDetail?.sellerDetails == null) {
      return const SizedBox.shrink();
    }
    return BuyerSellerDetailsWidget.seller(
      product: _bloc.productDetail!,
      showReviews: true,
      showArrowIcon:
          storage.userInfo.id != _bloc.productDetail?.sellerDetails?.id,
      onTap: () {
      },
    );
  }

  _buildBottomButtonBar() {
    return CustomBottomButtonBuyer(
      isButtonEnabled:
          storage.userInfo.id != _bloc.productDetail?.sellerDetails?.id,
      pricePerDay: _bloc.productDetail?.pricePerDay ?? '',
      buttonText: Strings.checkAvailability(),
      onTap: () {},
    );
  }

  onFavoriteClick() {
    _bloc.add(FavoriteClickEvent());
  }
}
