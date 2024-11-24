enum ProductProcessStatusEnum {
  Pending("pending"),
  RequestAcceptedBySeller("request_accepted_by_seller"),
  RequestRejectedBySeller("request_rejected_by_seller"),
  InspectionPending("inspection_pending"),
  InspectionRejected("inspection_rejected"),
  InspectionApproved("inspection_approved"),
  RequestCancelledByUser("request_cancelled_by_buyer"),
  Completed("completed"),
  Returned("returned"),
  Occupied("occupied"),
  Booked("booked"),
  ExtendRequestRejected("extend_request_rejected"),
  ExtendRequestAccepted("extend_request_accepted"),
  BuyingRequestPending("buying_request_pending"),
  BuyingRequestAccepted("buying_request_accepted"),
  BuyingRequestRejected("buying_request_rejected"),
  Approved("approved"),
  Rejected("rejected"),
  Withdraw("withdrawn");

  final String value;

  const ProductProcessStatusEnum(this.value);
}

extension ProductProcessStatusEnumUtil on String? {
  ProductProcessStatusEnum toProductProcessStatusEnum() {
    return ProductProcessStatusEnum.values.firstWhere(
        (element) => element.value == this?.toLowerCase(),
        orElse: () => ProductProcessStatusEnum.Pending);
  }
}
