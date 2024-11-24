class ReceivedRequests {
  ReceivedRequests({
    num? id,
    num? bookedDays,
    String? pickupDate,
    String? date,
    Buyer? buyer,
    String? statusToShow,
    String? status,
    String? sellerStatus,}){
    _id = id;
    _bookedDays = bookedDays;
    _pickupDate = pickupDate;
    _date = date;
    _buyer = buyer;
    _statusToShow = statusToShow;
    _status = status;
    _sellerStatus = sellerStatus;
  }

  ReceivedRequests.fromJson(dynamic json) {
    _id = json['id'];
    _bookedDays = json['booked_days'];
    _pickupDate = json['pickup_date'];
    _date = json['date'];
    _buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    _statusToShow = json['status_to_show'];
    _status = json['status'];
    _sellerStatus = json['seller_status'];
  }
  num? _id;
  num? _bookedDays;
  String? _pickupDate;
  String? _date;
  Buyer? _buyer;
  String? _statusToShow;
  String? _status;
  String? _sellerStatus;
  ReceivedRequests copyWith({  num? id,
    num? bookedDays,
    String? pickupDate,
    String? date,
    Buyer? buyer,
    String? statusToShow,
    String? status,
    String? sellerStatus,
  }) => ReceivedRequests(  id: id ?? _id,
    bookedDays: bookedDays ?? _bookedDays,
    pickupDate: pickupDate ?? _pickupDate,
    date: date ?? _date,
    buyer: buyer ?? _buyer,
    statusToShow: statusToShow ?? _statusToShow,
    status: status ?? _status,
    sellerStatus: sellerStatus ?? _sellerStatus,
  );
  num? get id => _id;
  num? get bookedDays => _bookedDays;
  String? get pickupDate => _pickupDate;
  String? get date => _date;
  Buyer? get buyer => _buyer;
  String? get statusToShow => _statusToShow;
  String? get status => _status;
  String? get sellerStatus => _sellerStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booked_days'] = _bookedDays;
    map['pickup_date'] = _pickupDate;
    map['date'] = _date;
    if (_buyer != null) {
      map['buyer'] = _buyer?.toJson();
    }
    map['status_to_show'] = _statusToShow;
    map['status'] = _status;
    map['seller_status'] = _sellerStatus;
    return map;
  }

}

class Buyer {
  Buyer({
    num? id,
    String? fullName,
    String? profilePhoto,}){
    _id = id;
    _fullName = fullName;
    _profilePhoto = profilePhoto;
  }

  Buyer.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _profilePhoto = json['profile_photo'];
  }
  num? _id;
  String? _fullName;
  String? _profilePhoto;
  Buyer copyWith({  num? id,
    String? fullName,
    String? profilePhoto,
  }) => Buyer(  id: id ?? _id,
    fullName: fullName ?? _fullName,
    profilePhoto: profilePhoto ?? _profilePhoto,
  );
  num? get id => _id;
  String? get fullName => _fullName;
  String? get profilePhoto => _profilePhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['profile_photo'] = _profilePhoto;
    return map;
  }

}