import 'package:get_it/get_it.dart';
import 'package:kheticonnect/data/enums/condition_type_enum.dart';
import 'package:kheticonnect/data/model/model_received_requests.dart';
import 'package:kheticonnect/data/model/product_status.dart';

import '../../presentation/service/date_time.dart';
import '../../util/app_const.dart';

//add ongoing_requests : true in the json to get the ongoing requests

class Product {
  Product({
    num? id,
    String? name,
    String? category,
    String? description,
    num? yearsOld,
    num? minimumRentalPeriod,
    String? productCondition,
    String? userGuidelines,
    String? pricePerDay,
    String? buyingAmount,
    num? productRating,
    num? productReviews,
    BuyerSellerDetails? sellerDetails,
    BuyerSellerDetails? buyerDetails,
    List<Images>? images,
    bool? isFavorite,
    String? availabilityStatus,
    ProductStatus? status,
    bool? isOngoingRequest,
    List<ReceivedRequests>? receivedRequest,
    num? avgRating,
  }) {
    _id = id;
    _name = name;
    _category = category;
    _description = description;
    _yearsOld = yearsOld;
    _minimumRentalPeriod = minimumRentalPeriod;
    _productCondition = productCondition;
    _userGuidelines = userGuidelines;
    _pricePerDay = pricePerDay;
    _buyingAmount = buyingAmount;
    _productRating = productRating;
    _productReviews = productReviews;
    _sellerDetails = sellerDetails;
    _buyerDetails = buyerDetails;
    _images = images;
    _isFavorite = isFavorite;
    _availabilityStatus = availabilityStatus;
    _status = status;
    _isOngoingRequest = isOngoingRequest;
    _receivedRequest = receivedRequest;
    _avgRating = avgRating;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _category = json['category'];
    _description = json['description'];
    _yearsOld = json['years_old'];
    _minimumRentalPeriod = json['minimum_rental_period'];
    _productCondition = json['product_condition'];
    _userGuidelines = json['user_guidelines'];
    _pricePerDay = json['price_per_day'];
    _buyingAmount = json['buying_amount'];
    _productRating = json['product_rating'];
    _productReviews = json['product_reviews'];
    _sellerDetails = json['seller_details'] != null
        ? BuyerSellerDetails.fromJson(json['seller_details'], true)
        : null;
    _buyerDetails = json['buyer_details'] != null
        ? BuyerSellerDetails.fromJson(json['buyer_details'], false)
        : json['buyer'] != null ? BuyerSellerDetails.fromJson(json['buyer'], false) :null;
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    if (json['image'] != null) {
      _images = [];
      _images?.add(Images(url: json['image']));
    }
    _isFavorite = json['is_favorite'];
    _isOngoingRequest = json['ongoing_requests'];
    _availabilityStatus = json['availability_status'];
    _status = json['status'] != null ? json['status'] is String ? ProductStatus.fromJson({"value" : json['status']}) :ProductStatus.fromJson(json['status']) : null;
    if(json['received_requests'] != null){
      _receivedRequest = [];
      json['received_requests'].forEach((v) {
        _receivedRequest?.add(ReceivedRequests.fromJson(v));
      });
    }
    _avgRating = json['avg_rating'];
  }

  num? _id;
  String? _name;
  String? _category;
  num? categoryId;
  DateTime? productPurchaseDate;
  String? _description;
  num? _yearsOld;
  num? _minimumRentalPeriod;
  String? _productCondition;
  String? _userGuidelines;
  String? _pricePerDay;
  String? _buyingAmount;
  num? _productRating;
  num? _productReviews;
  BuyerSellerDetails? _sellerDetails;
  BuyerSellerDetails? _buyerDetails;
  List<Images>? _images;
  bool? _isFavorite;
  bool? _isOngoingRequest;
  String? _availabilityStatus;
  ProductStatus? _status;
  List<ReceivedRequests>? _receivedRequest;
  num? _avgRating;

  num? get id => _id;

  String? get name => _name;

  String? get category => _category;

  String? get description => _description;

  num get yearsOld => _yearsOld ?? 0;

  num get minimumRentalPeriod => _minimumRentalPeriod ?? 0;

  ConditionType get productCondition => _productCondition.toConditionType();

  String? get userGuidelines => _userGuidelines;

  String? get pricePerDay => _pricePerDay;

  String? get buyingAmount => _buyingAmount;

  num? get productRating => _productRating;

  num? get productReviews => _productReviews;
  num? get avgRating => _avgRating;

  BuyerSellerDetails? get sellerDetails => _sellerDetails;
  BuyerSellerDetails? get buyerDetails => _buyerDetails;

  List<Images>? get images => _images;

  bool? get isFavorite => _isFavorite;
  bool? get isOngoingRequest => _isOngoingRequest;
  String? get availabilityStatus => _availabilityStatus;
  toggleFavorite() => _isFavorite = !(_isFavorite ?? false);

  ProductStatus? get status => _status;

  List<ReceivedRequests>? get receivedRequest => _receivedRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['category'] = _category;
    map['description'] = _description;
    map['years_old'] = _yearsOld;
    map['minimum_rental_period'] = _minimumRentalPeriod;
    map['product_condition'] = _productCondition;
    map['user_guidelines'] = _userGuidelines;
    map['price_per_day'] = _pricePerDay;
    map['buying_amount'] = _buyingAmount;
    map['product_rating'] = _productRating;
    map['product_reviews'] = _productReviews;
    map['avg_rating'] = _avgRating;
    if (_sellerDetails != null) {
      map['seller_details'] = _sellerDetails?.toJson();
    }
    if (_buyerDetails != null) {
      map['buyer_details'] = _buyerDetails?.toJson();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['is_favorite'] = _isFavorite;
    map['ongoing_requests'] = _isOngoingRequest;
    map['availability_status'] = _availabilityStatus;
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    map['received_requests'] = _receivedRequest?.map((v) => v.toJson()).toList();
    return map;
  }
}

class Images {
  Images({
    num? id,
    String? url,
  }) {
    _id = id;
    _url = url;
  }

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _url = json['url'];
  }

  num? _id;
  String? _url;

  num? get id => _id;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['url'] = _url;
    return map;
  }
}

class BuyerSellerDetails {
  var dateTimeUtil = GetIt.I<DateTimeService>();
  BuyerSellerDetails({
    num? id,
    String? name,
    String? profileImage,
    num? rating,
    num? reviews,
    String? registeredOn
  }) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
    _ratings = rating;
    _reviews = reviews;
    _registeredOn = registeredOn;
  }

  BuyerSellerDetails.fromJson(dynamic json, bool isSeller) {
    _ratingsJsonKey = isSeller ? 'seller_rating' : 'rating';
    _reviewsJsonKey = isSeller ? 'seller_reviews' : 'reviews';
    _id = json['id'];
    _name = json['name'] ?? json['full_name'];
    _profileImage = json['profile_image'] ?? json['profile_photo'];
    _ratings = json[_ratingsJsonKey];
    _reviews = json[_reviewsJsonKey];
    _registeredOn = json['registered_on'];
  }

  String _ratingsJsonKey = 'seller_rating';
  String _reviewsJsonKey = 'seller_reviews';

  num? _id;
  String? _name;
  String? _profileImage;
  String? _registeredOn;
  num? _ratings;
  num? _reviews;

  num? get id => _id;

  String? get name => _name;

  String? get profileImage => _profileImage;

  num? get ratings => _ratings;

  num? get reviews => _reviews;
  String? get registeredOn {
    var date = _registeredOn;
    if(date!=null) {
      var dateForm = dateTimeUtil.getDateFromString(
          dateString: date, format: AppConst.dateDisplayFormat);
      date = dateTimeUtil.getStingFromDate(
        date: dateForm,
        pattern: AppConst.dateDisplayFormat2,
      );
    }
    return date;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['profile_image'] = _profileImage;
    map[_ratingsJsonKey] = _ratings;
    map[_reviewsJsonKey] = _reviews;
    map['registered_on'] = _registeredOn;
    return map;
  }
}
