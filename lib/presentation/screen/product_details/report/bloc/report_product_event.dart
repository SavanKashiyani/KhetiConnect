import 'package:kheticonnect/data/enums/buyer_seller_report_reason_enum.dart';

import '../../../../../data/enums/product_report_reason_enum.dart';

abstract class ReportProductEvent {}

class LoadReportReasonsEvent extends ReportProductEvent {
  final bool isProduct;
  LoadReportReasonsEvent({required this.isProduct});
}

class ReportReasonsChangeEvent extends ReportProductEvent {
  final ProductReportReasonType? value;
  final BuyerSellerReportReasonType? buyerSellerValue;
  final bool isProduct ;

  ReportReasonsChangeEvent(this.isProduct,{this.value,   this.buyerSellerValue,});
}

class SubmitReportReasonEvent extends ReportProductEvent {
  final num? productId;
  final num? userId;
  SubmitReportReasonEvent({ this.productId, this.userId});
}

class OtherReasonTextChangeEvent extends ReportProductEvent {
  final String? text;

  OtherReasonTextChangeEvent(this.text);
}
