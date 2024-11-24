import 'package:flutter/cupertino.dart';
import 'package:kheticonnect/data/enums/buyer_seller_report_reason_enum.dart';
import 'package:kheticonnect/data/enums/product_report_reason_enum.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_bloc.dart';
import 'package:kheticonnect/presentation/screen/product_details/report/bloc/report_product_state.dart';

import '../../../product_list/product_repo.dart';
import 'report_product_event.dart';

class ReportProductBloc extends BaseBloc<ReportProductEvent, ApiRenderState> {
  final _repo = ProductRepo();

  // Product productDetail;

  List<ProductReportReasonType> reportReasonList = [];
  List<BuyerSellerReportReasonType> buyerSellerReportReasonList = [];
  ProductReportReasonType? selectedReportReasonType;
  BuyerSellerReportReasonType? selectedBuyerSellerReportReasonType;
  final reasonTextController = TextEditingController();

  bool get isEnableSubmitButton =>
      selectedReportReasonType != null &&
      (selectedReportReasonType != ProductReportReasonType.Other ||
          reasonTextController.text.isNotEmpty);

  bool get isEnableSubmitButtonForBuyerSeller =>
      selectedBuyerSellerReportReasonType != null &&
      (selectedBuyerSellerReportReasonType != BuyerSellerReportReasonType.Other ||
          reasonTextController.text.isNotEmpty);

  ReportProductBloc() : super(Ideal()) {
    on<LoadReportReasonsEvent>(_onLoadReportReasons);
    on<ReportReasonsChangeEvent>(_onReportReasonsChange);
    on<SubmitReportReasonEvent>(_onSubmitReportReason);
    on<OtherReasonTextChangeEvent>(_onOtherReasonTextChange);
  }

  _onLoadReportReasons(event, emit) async {
    emit(Loading());
    // var response = await _repo.getProductReportReasons(onApiError: onApiError);
    // if (response != null) {
    //   reportReasonList = response.data?.reasons ?? [];
    //   emit(ReportReasonsRetrievedState());
    // }
    reportReasonList = event.isProduct ? ProductReportReasonType.values : [];
    buyerSellerReportReasonList = event.isProduct ? [] : BuyerSellerReportReasonType.values;
    emit(ReportReasonsRetrievedState());
  }

  _onReportReasonsChange(ReportReasonsChangeEvent event, emit) async {
    event.isProduct
        ? selectedReportReasonType = event.value
        : selectedBuyerSellerReportReasonType = event.buyerSellerValue;
    emit(OnChangeState());
  }

  _onOtherReasonTextChange(OtherReasonTextChangeEvent event, emit) async {
    emit(OnChangeState());
  }

  _onSubmitReportReason(event, emit) async {
    emit(Loading());
    var response = await _repo.submitProductReportReason(
      productId: event.productId,
      userId: event.userId,
      type: event.productId !=null ?  selectedReportReasonType!.apiIdentifier : selectedBuyerSellerReportReasonType!.apiIdentifier,
      otherReason: reasonTextController.text,
      onApiError: onApiError,
    );
    if (response?.data != null) {
      emit(ApiSuccess(response));
    }
  }
}
