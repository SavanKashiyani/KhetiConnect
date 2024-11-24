import 'package:kheticonnect/resources/strings.dart';

enum ProductReportReasonType {
  QualityIssues("quality_issues"),
  SafetyConcerns("safety_concerns"),
  MisleadingClaims("misleading_claims"),
  LackOfTransparency("lake_of_transparency"),
  FakeReviews("fake_review"),
  Other("other");

  String get type => _keyStringMap[apiIdentifier];
  final String apiIdentifier;

  const ProductReportReasonType(this.apiIdentifier);
}

extension ProductReportReasonTypeUtil on String? {
  ProductReportReasonType toProductReportReasonType() {
    return ProductReportReasonType.values.firstWhere(
        (element) => element.type == this,
        orElse: () => ProductReportReasonType.Other);
  }
}

final Map _keyStringMap = {
  "quality_issues": Strings.reportReasonQualityIssues(),
  "safety_concerns": Strings.reportReasonSafetyConcerns(),
  "misleading_claims": Strings.reportReasonMisleadingClaims(),
  "lake_of_transparency": Strings.reportReasonLackOfTransparency(),
  "fake_review": Strings.reportReasonFakeReviews(),
  "other": Strings.reportReasonOther(),
};
