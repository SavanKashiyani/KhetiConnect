/// mobile_number : "1234567890"
/// email : "support@test.com"
/// address : "4525 Saints Alley, Plant City, FL 33564"

class ModelContactUs {
  ModelContactUs({
    String? mobileNumber,
    String? email,
    String? address,
  }) {
    _mobileNumber = mobileNumber;
    _email = email;
    _address = address;
  }

  ModelContactUs.fromJson(dynamic json) {
    _mobileNumber = json['mobile_number'];
    _email = json['email'];
    _address = json['address'];
  }

  String? _mobileNumber;
  String? _email;
  String? _address;

  ModelContactUs copyWith({
    String? mobileNumber,
    String? email,
    String? address,
  }) =>
      ModelContactUs(
        mobileNumber: mobileNumber ?? _mobileNumber,
        email: email ?? _email,
        address: address ?? _address,
      );

  String? get mobileNumber => _mobileNumber;

  String? get email => _email;

  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = _mobileNumber;
    map['email'] = _email;
    map['address'] = _address;
    return map;
  }
}
