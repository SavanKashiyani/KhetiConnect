import '../../resources/strings.dart';

enum ProductStatusEnum {
  AllListing("all_type"),
  AvailableForRent("available"),
  Booked("booked"),
  RequestReceived("requests_received"),
  Occupied("occupied"),
  NotAvailable("not_available"),
  InApproval("in_approval"),
  Cancelled("cancelled"),
  Completed("completed"),
  Approved("approved"),
  Withdrawn("withdrawn"),
  RequestCancelledByBuyer("request_cancelled_by_buyer"),
  Rejected("rejected"),
  Sold("sold"),
  Pending("pending");

  final String value;

  String get type => keyStringMap[value];

  String get key =>
      keyStringMap.keys.firstWhere((element) => keyStringMap[element] == type);

  const ProductStatusEnum(this.value);
}

extension ProductStatusUtil on String? {
  String getEnumKey() {
    return keyStringMap.entries
        .firstWhere((element) => element.value == this)
        .key;
  }

  ProductStatusEnum toProductStatusEnum() {
    return ProductStatusEnum.values.firstWhere(
      (element) => element.value == this,
      orElse: () => ProductStatusEnum.NotAvailable,
    );
  }
}

final Map keyStringMap = {
  "all_type": Strings.allListing(),
  "available": Strings.availableForRent(),
  "booked": Strings.booked(),
  "requests_received": Strings.requestReceived(),
  "occupied": Strings.occupied(),
  "not_available": Strings.notAvailable(),
  "in_approval": Strings.inApproval(),
  "cancelled": Strings.cancelled(),
  "completed": Strings.completed(),
  "approved": Strings.approved(),
  "pending": Strings.pending(),
  "request_cancelled_by_buyer": Strings.requestCancelledByBuyer(),
  "withdrawn": Strings.withdrawn(),
  "sold": Strings.sold(),
  "rejected": Strings.rejected(),
};
