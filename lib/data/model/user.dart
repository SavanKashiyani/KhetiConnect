class User {
  User({
    num? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    num? countryCode,
    String? profilePhoto,
    String? dob,
    num? gender,
    String? latitude,
    String? longitude,
    String? country,
    String? state,
    String? city,
    String? address,
    num? pincode,
    num? walletBalance,
    num? unreadNotifications,
  }) {
    _id = id;
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _countryCode = countryCode;
    _profilePhoto = profilePhoto;
    _dob = dob;
    _gender = gender;
    _latitude = latitude;
    _longitude = longitude;
    _country = country;
    _state = state;
    _city = city;
    _address = address;
    _pincode = pincode;
    _walletBalance = walletBalance;
    _unreadNotifications = unreadNotifications;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _email = json['email'];
    _phoneNumber = json['phone_number'];
    _countryCode = json['country_code'];
    _profilePhoto = json['profile_photo'];
    _dob = json['dob'];
    _gender = int.tryParse(json['gender'].toString());
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _address = json['address'];
    _pincode = int.tryParse(json['pincode'].toString());
    _unreadNotifications = json['unread_notifications'];
    _walletBalance = json['wallet_balance'];
  }

  num? _id;
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  num? _countryCode;
  String? _profilePhoto;
  String? _dob;
  num? _gender;
  String? _latitude;
  String? _longitude;
  String? _country;
  String? _state;
  String? _city;
  String? _address;
  num? _pincode;
  num? _unreadNotifications;
  num? _walletBalance;

  num? get id => _id;

  String? get fullName => _fullName;

  String? get email => _email;

  String? get phoneNumber => _phoneNumber;

  num? get countryCode => _countryCode;

  String? get profilePhoto => _profilePhoto;

  String? get dob => _dob;

  num? get gender => _gender;

  String? get latitude => _latitude;

  String? get longitude => _longitude;

  String? get country => _country;

  String? get state => _state;

  String? get city => _city;

  String? get address => _address;

  num? get pincode => _pincode;
  num? get unreadNotifications => _unreadNotifications;
  num? get walletBalance => _walletBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['email'] = _email;
    map['phone_number'] = _phoneNumber;
    map['country_code'] = _countryCode;
    map['profile_photo'] = _profilePhoto;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['address'] = _address;
    map['pincode'] = _pincode;
    map['unread_notifications'] = _unreadNotifications;
    map['wallet_balance'] = _walletBalance;
    return map;
  }
}
