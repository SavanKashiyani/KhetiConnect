
import '../../resources/strings.dart';

enum ArrivalProgressEnum {
  LeftForPickup("left_for_pickup"),
  ArrivedAtLocation("arrived_at_location"),
  ProductInspection("product_inspection"),
  ProductReturnSuccessful("product_return_successful"),
  AwaitingReturnAcceptance("awaiting_return_acceptance"),
  ReturnAcceptance("return_acceptance"),
  LeftForReturn("left_for_return");

  final String value;
  String get type => _keyStringMap[value];
  String get type_BuyerSide => _keyStringMap_BuyreSide[value];
  const ArrivalProgressEnum(this.value);
}

extension ArrivalProgressUtil on String? {
  ArrivalProgressEnum toArrivalProgress() {
    return ArrivalProgressEnum.values.firstWhere(
            (element) => element.value == this);
  }
}

final Map _keyStringMap = {
  "left_for_pickup": Strings.buyerLeftForPickup() ,
  "arrived_at_location": Strings.buyerArrivedAtLocation(),
  "product_inspection": Strings.productInspection(),
  "product_return_successful": Strings.productReturnSuccessful(),
  "awaiting_return_acceptance": Strings.awaitingReturnAcceptance(),
  "return_acceptance": Strings.returnAcceptance(),
  "left_for_return": Strings.buyerLeftForReturn(),
};

final Map _keyStringMap_BuyreSide = {
  "left_for_pickup": Strings.leftForPickup(),
  "arrived_at_location": Strings.arrivedAtLocation(),
  "product_inspection": Strings.productInspection(),
  "product_return_successful": Strings.productReturnSuccessful(),
  "awaiting_return_acceptance": Strings.awaitingReturnAcceptance(),
  "return_acceptance": Strings.returnAcceptance(),
  "left_for_return": Strings.leftForReturn(),
};

