import 'package:kheticonnect/resources/strings.dart';

enum BuyerSellerReportReasonType {
  NotAsDescribed("not_as_described"),
  DelayedShipping("delayed_shipping"),
  Poorcommunication("poor_communication"),
  InAppropriateBehavior("inappropriate_behavior"),
  FraudulentActivity("fraudulent_activity"),
  Other("other");

  String get type => _keyStringMap[apiIdentifier];
  final String apiIdentifier;

  const BuyerSellerReportReasonType(this.apiIdentifier);
}

extension BuyerSellerReportReasonTypeUtil on String? {
  BuyerSellerReportReasonType toBuyerSellerReportReasonType() {
    return BuyerSellerReportReasonType.values.firstWhere(
        (element) => element.type == this,
        orElse: () => BuyerSellerReportReasonType.Other);
  }
}

final Map _keyStringMap = {
  "not_as_described": Strings.itemNotAsDescribed(),
  "delayed_shipping": Strings.delayedShipping(),
  "poor_communication": Strings.poorCommunication(),
  "inappropriate_behavior": Strings.inAppropriateBehavior(),
  "fraudulent_activity": Strings.fraudulentActivity(),
  "other": Strings.reportReasonOther(),
};
