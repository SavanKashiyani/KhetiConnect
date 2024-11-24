import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/model/ReportProductResModel.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/app_bar/custom_app_bar.dart';
import 'package:kheticonnect/presentation/custom/widget/buyer_Seller_detail_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_radio_button.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/screen/product_details/report/bloc/report_product_bloc.dart';
import 'package:kheticonnect/presentation/screen/product_details/report/bloc/report_product_event.dart';
import 'package:kheticonnect/resources/styles/app_decoration.dart';
import 'package:kheticonnect/resources/styles/padding.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../../data/enums/buyer_seller_report_reason_enum.dart';
import '../../../../data/enums/product_report_reason_enum.dart';
import '../../../../data/model/model_seller_details.dart';
import '../../../../data/model/product.dart';
import '../../../../util/text_styles.dart';
import '../../../custom/widget/button/custom_button.dart';

//ignore: must_be_immutable
class ReportProductScreen extends BaseWidget {
  late ReportProductBloc _bloc;
  Product? product;
  ModelSellerDetails? sellerData;
  bool isSeller = true;
  ReportProductScreen({super.key, this.product,this.sellerData, this.isSeller = true}) {
      _bloc = ReportProductBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc..add(LoadReportReasonsEvent(isProduct : product !=null)),
      listener: (context, state) {
        if (state is ApiSuccess) {
          if (state.data is ReportProductResModel) {
            showSuccess((state.data as ReportProductResModel).meta?.message);
            navigation.pop();
          }
        } else if (state is ApiFailure) {
          showError(state.data);
        }
      },
      builder: (context, ApiRenderState state) {
        return StackLoader(
          state: state,
          child: Scaffold(
            backgroundColor: ColorName.whiteBg,
            appBar: CustomAppBar(
              title:product!=null ? Strings.reportProduct() :isSeller ? Strings.reportSeller() : Strings.reportBuyer(),
            ),
            body: _renderBody(),
          ),
        );
      },
    );
  }

  Widget _renderBody() {
    return Column(
      children: [
        SingleChildScrollView(
          padding: AppPadding.screensPadding,
          clipBehavior: Clip.antiAlias,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              product!=null ?
              _renderProductDetailWidget() : _renderSellerWidget(),
              _renderReasonListWidget(),
              _renderOtherReasonWidget(),
            ],
          ),
        ).expanded,
        _renderSubmitReportButton(),
      ],
    );
  }

  Widget _renderProductDetailWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
      child: Row(
        children: [
          CustomImageView(
            imagePath: product?.images?.firstOrNull?.url,
            fit: BoxFit.cover,
            height: 80,
            width: 80,
            radius: BorderRadius.circular(4),
          ),
          addWidth(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: Strings.reportedProduct(),
                style:
                    TextStyles.jakarta.medium.of(12, color: ColorName.gray500),
              ),
              addHeight(8),
              CustomText(
                text: product?.name ?? '',
                style: TextStyles.exo.semiBold.of(18, color: ColorName.gray800),
              ),
              Row(
                children: [
                  CustomImageView(
                    imagePath: Assets.drawables.icProductType.path,
                    height: 14.adaptSize,
                    width: 14.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: Text(
                      product?.category ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.jakarta.medium
                          .of(10, color: ColorName.gray500),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _renderReasonListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(15),
        Text(
          Strings.chooseReportReason(product!=null ? Strings.products() : isSeller ? Strings.seller() : Strings.buyer()),
          style: TextStyles.exo.semiBold.of(18, color: ColorName.primary),
        ),
        addHeight(12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration:
              AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: product!=null ? _bloc.reportReasonList.length : _bloc.buyerSellerReportReasonList.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: ColorName.primary50),
            itemBuilder: (context, index) =>
            product!=null ? _buildReportReasonWidget(_bloc.reportReasonList[index]) : _buildBuyerSellerReportReasonWidget(_bloc.buyerSellerReportReasonList[index]),
          ),
        )
      ],
    );
  }

  Widget _renderOtherReasonWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addHeight(16),
        // Text(
        //   Strings.otherReason(),
        //   style: TextStyles.exo.semiBold.of(18, color: ColorName.primary),
        // ),
        // addHeight(12),
        CustomTextField(
          hintText: Strings.writeYourReason(),
          controller: _bloc.reasonTextController,
          maxLines: 3,
          onChanged: (text) => _bloc.add(OtherReasonTextChangeEvent(text)),
        )
      ],
    ).visibility(
        isVisible:
            _bloc.selectedReportReasonType == ProductReportReasonType.Other || _bloc.selectedBuyerSellerReportReasonType == BuyerSellerReportReasonType.Other);
  }

  Widget _renderSubmitReportButton() {
    return SafeArea(
      child: CustomButton(
        buttonText: Strings.submitReport(),
        isEnabled: product !=null ? _bloc.isEnableSubmitButton : _bloc.isEnableSubmitButtonForBuyerSeller,
        onClick: () {
        if(product!=null && product!.id!=null) {
          _bloc.add(SubmitReportReasonEvent(productId : product!.id!));
        }else if(sellerData!=null && sellerData?.seller?.id!=null) {
          _bloc.add(SubmitReportReasonEvent(userId : sellerData?.seller?.id));
        }
        },
      ),
    );
  }

  _buildReportReasonWidget(ProductReportReasonType reportReasonType) {
    return CustomRadioButton(
      padding: const EdgeInsets.symmetric(vertical: 8),
      text: reportReasonType.type,
      value: reportReasonType,
      groupValue: _bloc.selectedReportReasonType,
      onChange: (value) {
        _bloc.add(ReportReasonsChangeEvent( product!=null, value : value));
      },
    );
  }

  _buildBuyerSellerReportReasonWidget(BuyerSellerReportReasonType buyerSellerReportReasonType) {
    return CustomRadioButton(
      padding: const EdgeInsets.symmetric(vertical: 8),
      text: buyerSellerReportReasonType.type,
      value: buyerSellerReportReasonType,
      groupValue: _bloc.selectedBuyerSellerReportReasonType,
      onChange: (value) {
        _bloc.add(ReportReasonsChangeEvent( product!=null, buyerSellerValue : value));
      },
    );
  }

  _renderSellerWidget() {
     return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppDecoration.getBoxDecoration(ColorName.white, radius: 8),
      child: Row(
        children: [
          CustomImageView(
            imagePath: sellerData?.seller?.profileImage,
            fit: BoxFit.cover,
            height: 80,
            width: 80,
            radius: BorderRadius.circular(4),
          ),
          addWidth(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: isSeller ? Strings.seller() : Strings.buyer(),
                style:
                TextStyles.jakarta.medium.of(12, color: ColorName.gray500),
              ),
              addHeight(8),
              CustomText(
                text: sellerData?.seller?.name ?? '',
                style: TextStyles.exo.semiBold.of(18, color: ColorName.gray800),
              ),
            ],
          )
        ],
      ),
    );
  }
}
