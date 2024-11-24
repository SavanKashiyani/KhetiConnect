import 'package:localization/localization.dart';

class _LocaleDelegate {
  final String _str;

  _LocaleDelegate(this._str);

  @override
  call([dynamic args]) {
    List<String> mArgs = [];
    if (args != null) {
      if (args is String) {
        mArgs.add(args);
      } else {
        mArgs.addAll(args);
      }
    }
    return _str.i18n(mArgs);
  }
}

// First define a new string inside assets/language/en.json file
class Strings {
  static var appName = _LocaleDelegate("appName");

//signIn
  static var welcome = _LocaleDelegate("welcome");
  static var phoneNumber = _LocaleDelegate("phoneNumber");
  static var enterPhoneNumber = _LocaleDelegate("enterPhoneNumber");
  static var sendOtp = _LocaleDelegate("sendOtp");
  static var verifyOtp = _LocaleDelegate("verifyOtp");

  //verification
  static var msgOtpVerification = _LocaleDelegate("msgOtpVerification");
  static var resendOtp = _LocaleDelegate("resendOtp");

  //my account
  static var termsAndConditions = _LocaleDelegate("termsAndConditions");
  //Product details
  static var minimumRentalPeriod = _LocaleDelegate("minimumRentalPeriod");
  static var aboutProduct = _LocaleDelegate("aboutProduct");
  static var average = _LocaleDelegate("average");
  static var userGuidelines = _LocaleDelegate("userGuidelines");

  // filter
  static var excellent = _LocaleDelegate("excellent");
  static var good = _LocaleDelegate("good");

  static var home = _LocaleDelegate("home");
  static var account = _LocaleDelegate("account");
  static var myRentals = _LocaleDelegate("myRentals");
  static var greetingTitle = _LocaleDelegate("greetingTitle");
  static var goodMorning = _LocaleDelegate("goodMorning");
  static var goodAfternoon = _LocaleDelegate("goodAfternoon");
  static var goodEvening = _LocaleDelegate("goodEvening");
  static var searchHint = _LocaleDelegate("searchHint");
  static var browseCategories = _LocaleDelegate("browseCategories");
  static var seeAll = _LocaleDelegate("seeAll");
  static var newlyAdded = _LocaleDelegate("newlyAdded");
  static var mostRented = _LocaleDelegate("mostRented");
  static var currencyAmount = _LocaleDelegate("currencyAmount");
  static var perDay = _LocaleDelegate("perDay");
  static var myAccount = _LocaleDelegate("myAccount");
  static var productDetails = _LocaleDelegate("productDetails");
  static var gallery = _LocaleDelegate("gallery");
  static var cancel = _LocaleDelegate("cancel");
  static var submit = _LocaleDelegate("submit");
  static var strPerDay = _LocaleDelegate("strPerDay");
  static var myFavourites = _LocaleDelegate("myFavourites");
  static var myClaims = _LocaleDelegate("myClaims");
  static var faqs = _LocaleDelegate("faqs");
  static var contactUs = _LocaleDelegate("contactUs");
  static var aboutUS = _LocaleDelegate("aboutUS");
  static var privacyPolicy = _LocaleDelegate("privacyPolicy");
  static var logout = _LocaleDelegate("logout");
  static var comebackSoon = _LocaleDelegate("comebackSoon");
  static var msgLogout = _LocaleDelegate("msgLogout");
  static var callUs = _LocaleDelegate("callUs");
  static var mailUs = _LocaleDelegate("mailUs");
  static var visitUs = _LocaleDelegate("visitUs");
  static var search = _LocaleDelegate("search");
  static var filter = _LocaleDelegate("filter");
  static var productCondition = _LocaleDelegate("productCondition");
  static var productType = _LocaleDelegate("productType");
  static var productTypeNew = _LocaleDelegate("productTypeNew");
  static var productTypeOld = _LocaleDelegate("productTypeOld");
  static var productTypeVeryOld = _LocaleDelegate("productTypeVeryOld");
  static var reset = _LocaleDelegate("reset");
  static var apply = _LocaleDelegate("apply");
  static var validPhoneNumber = _LocaleDelegate("validPhoneNumber");
  static var invalidOTP = _LocaleDelegate("invalidOTP");
  static var categories = _LocaleDelegate("categories");
  static var noDataFound = _LocaleDelegate("noDataFound");
  static var noCategoriesTitle = _LocaleDelegate("noCategoriesTitle");
  static var noCategoriesDesc = _LocaleDelegate("noCategoriesDesc");
  static var noProductsTitle = _LocaleDelegate("noProductsTitle");
  static var noProductsDesc = _LocaleDelegate("noProductsDesc");

  static noOfYears(num years) => years > 1
      ? _LocaleDelegate("noOfYears")([years.toString()])
      : _LocaleDelegate("noOfYear")([years.toString()]);

  static noOfDays(num days) => days > 1
      ? _LocaleDelegate("noOfDays")([days.toString()])
      : _LocaleDelegate("noOfDay")([days.toString()]);

  static var yearsOld = _LocaleDelegate("yearsOld");
  static var allListing = _LocaleDelegate("allListing");
  static var requestReceived = _LocaleDelegate("requestReceived");
  static var buyerDetails = _LocaleDelegate("buyerDetails");
  static var buyer = _LocaleDelegate("buyer");
  static var buyerLeftForPickup = _LocaleDelegate("buyerLeftForPickup");
  static var buyerArrivedAtLocation = _LocaleDelegate("buyerArrivedAtLocation");
  static var productInspection = _LocaleDelegate("productInspection");
  static var sellerDetails = _LocaleDelegate("sellerDetails");
  static var seller = _LocaleDelegate("seller");
  static var productReviews = _LocaleDelegate("productReviews");

  static numberInBraces(num? value) =>
      _LocaleDelegate("numberInBraces")([value?.toString() ?? '']);
  static var sellerReviews = _LocaleDelegate("sellerReviews");
  static var noOfReviewsInBraces = _LocaleDelegate("noOfReviewsInBraces");
  static var checkAvailability = _LocaleDelegate("checkAvailability");
  static var reportProduct = _LocaleDelegate("reportProduct");
  static var reportedProduct = _LocaleDelegate("reportedProduct");
  static  chooseReportReason(String type) => _LocaleDelegate("chooseReportReason")(type);
  static var writeYourReason = _LocaleDelegate("writeYourReason");
  static var submitReport = _LocaleDelegate("submitReport");
  static var reportReasonQualityIssues = _LocaleDelegate("reportReason_QualityIssues");
  static var reportReasonSafetyConcerns = _LocaleDelegate("reportReason_SafetyConcerns");
  static var reportReasonMisleadingClaims = _LocaleDelegate("reportReason_MisleadingClaims");
  static var reportReasonLackOfTransparency = _LocaleDelegate("reportReason_LackOfTransparency");
  static var reportReasonFakeReviews = _LocaleDelegate("reportReason_FakeReviews");
  static var reportReasonOther = _LocaleDelegate("reportReason_Other");
  static var availableForRent = _LocaleDelegate("availableForRent");
  static var booked = _LocaleDelegate("booked");
  static var occupied = _LocaleDelegate("occupied");
  static var notAvailable = _LocaleDelegate("notAvailable");
  static var productImages = _LocaleDelegate("productImages");
  static var inApproval = _LocaleDelegate("inApproval");
  static var arrivedAtLocation = _LocaleDelegate("arrivedAtLocation");
  static var leftForPickup = _LocaleDelegate("leftForPickup");
  static var products = _LocaleDelegate("products");
  static var pending = _LocaleDelegate("pending");
  static var withdrawn = _LocaleDelegate("withdrawn");
  static var rejected = _LocaleDelegate("rejected");
  static var cancelled = _LocaleDelegate("cancelled");
  static var bankDetails = _LocaleDelegate("bankDetails");
  static var all = _LocaleDelegate("all");
  static var leftForReturn = _LocaleDelegate("leftForReturn");
  static var productReturnSuccessful = _LocaleDelegate("productReturnSuccessful");
  static var awaitingReturnAcceptance = _LocaleDelegate("awaitingReturnAcceptance");
  static var approved = _LocaleDelegate("approved");
  static var completed = _LocaleDelegate("completed");
  static var returnAcceptance = _LocaleDelegate("returnAcceptance");
  static var reportSeller = _LocaleDelegate("reportSeller");
  static var reportBuyer = _LocaleDelegate("reportBuyer");
  static var itemNotAsDescribed = _LocaleDelegate("itemNotAsDescribed");
  static var delayedShipping = _LocaleDelegate("delayedShipping");
  static var poorCommunication = _LocaleDelegate("poorCommunication");
  static var inAppropriateBehavior = _LocaleDelegate("inAppropriateBehavior");
  static var fraudulentActivity = _LocaleDelegate("fraudulentActivity");
  static var buyerLeftForReturn = _LocaleDelegate("buyerLeftForReturn");
  static var noProductsFound = _LocaleDelegate("noProductsFound");
  static var requestCancelledByBuyer = _LocaleDelegate("requestCancelledByBuyer");
  static var sold = _LocaleDelegate("sold");
}