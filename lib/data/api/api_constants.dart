library api;



class ApiConstants {
  static const String mainURL = 'https://www.google.com/';
  static const String baseUrl = '${mainURL}api/v1/';

  static const sendOTP = 'send-otp';
  static const verifyOTP = 'verify-otp';
  static const getCategories = 'get-categories';
  static const dashboard = 'dashboard';
  static const productList = 'product/list';
  static const getProfile = 'get-profile';
  static const logout = 'logout';
  static const contactUs = 'contact-us';
  static getProductDetail(String? productId) => 'product/get/$productId';
  static const reportProduct = "report/product";
  static const reportUser = "report/user";
  static addOrRemoveFavorite(num? productId) => "product/add-remove-favorite/$productId";
  static const getFavorites = "get-favorites";
  static receivedRequests(int? productId) => "booking/list-booking-requests/$productId";
  static viewBookingRequest(num? requestId) => "booking/view-booking-request/$requestId";
  static const actionOnBooking = "booking/action-on-booking";
  static const addPickupDetail = "booking/add-pickup-details";
  static const bookingSummary = "booking/booking-summary";
  static const sendBookingRequest = "booking/send-booking-request";
  static const acceptRejectInspection = "booking/accept-reject-inspection";
  static const addInspectionReportClaim = "booking/add-inspection-details";
  static const getMyRentals = "booking/my-rentals";
  static manageProductAvailability(int productId) => "product/manage-available-status/$productId";
  static const updatePickupHistory = "booking/update-pickup-history";
  static const getStates = "get-states";
  static getCities(String state) => "get-cities?state=$state";
  static const getSellerDetails = "product/get-seller-details";
  static const makePayment = "transaction/make-payment";
  static const sendExtendRequest = "booking/send-extend-request";
  static const sendBuyingRequest = "booking/send-buying-request";
  static const bookingAcceptRejectRequest = "booking/accept-reject-request";
  static const addReview = "review/add";
  static const claimList = "claim/list";
  static getClaimDetail(num claimID) => "claim/get/$claimID";
  static const cancelClaimReq = "claim/cancel-request";
  static const addBankDetails = "add-bank-details";
  static const getBankDetails = "bank-details";
  static const getReviewsList = "review/list";
  static const getNotificationList = "get-notification";
  static const updateDeviceToken = "update-device-token";
  static const readAllNotifications = "notifications/read-all";
  static const stripeSetupIntent = "stripe/setup-intent";
  static const stripeStorePaymentMethod = "stripe/store-payment-method";
  static const stripeGetPaymentMethod = "stripe/get-payment-method";
  static const stripeCreatePaymentMethod = "stripe/create-payment-intent";
  static const createPlaidLinkToken = "plaid/create-link-token";
  static const exchangePlaidPublicToken = "plaid/exchange-public-token";
  static const storePaymentDetails = "stripe/store-payment-details";
  static const sendWithdrawRequest = "payment/send-withdraw-request";
  static const listPaymentHistory = "payment/list-payment-history";
  static const paymentFromWallet = "payment/deduct-from-wallet";
  static readNotification(num notiId) => "notifications/read/$notiId";
  static const stripeSuccessURL = "${mainURL}stripe/redirect-url";
}
