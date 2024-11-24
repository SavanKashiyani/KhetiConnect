/// key : "available"
/// value : "Available For Rent"
/// count : "1 Request Received"
/// data : ""

class ProductStatus {
  ProductStatus({
      String? key, 
      String? value, 
      int? count,
      String? data,}){
    _key = key;
    _value = value;
    _count = count;
    _data = data;
}

  ProductStatus.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
    _count = json['count'];
    _data = json['data'];
  }
  String? _key;
  String? _value;
  int? _count;
  String? _data;
ProductStatus copyWith({  String? key,
  String? value,
  int? count,
  String? data,
}) => ProductStatus(  key: key ?? _key,
  value: value ?? _value,
  count: count ?? _count,
  data: data ?? _data,
);
  String? get key => _key;
  String? get value => _value;
  int? get count => _count;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    map['count'] = _count;
    map['data'] = _data;
    return map;
  }

}