import '../../resources/strings.dart';

enum ConditionType {
  Excellent("excellent"),
  Good("good"),
  Average("average"),
  Unknown("");

  final String value;
  String get type => _keyStringMap[value];
  const ConditionType(this.value);
}

extension ConditionTypeUtil on String? {
  ConditionType toConditionType() {
    return ConditionType.values.firstWhere(
        (element) => element.value == this?.toLowerCase(),
        orElse: () => ConditionType.Unknown);
  }
}

final Map _keyStringMap = {
  "excellent": Strings.excellent(),
  "good": Strings.good(),
  "average": Strings.average(),
  "unknown": ConditionType.Unknown
};
