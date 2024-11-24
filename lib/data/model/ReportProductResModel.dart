import 'meta.dart';

class ReportProductResModel {
  ReportProductResModel({
    Data? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  ReportProductResModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Data? _data;
  Meta? _meta;

  Data? get data => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    num? id,
    String? reportingUser,
    num? productId,
    String? productName,
    String? description,
    Type? type,
    Status? status,
  }) {
    _id = id;
    _reportingUser = reportingUser;
    _productId = productId;
    _productName = productName;
    _description = description;
    _type = type;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _reportingUser = json['reporting_user'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _description = json['description'];
    _type = json['type'] != null ? Type.fromJson(json['type']) : null;
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  num? _id;
  String? _reportingUser;
  num? _productId;
  String? _productName;
  String? _description;
  Type? _type;
  Status? _status;

  num? get id => _id;

  String? get reportingUser => _reportingUser;

  num? get productId => _productId;

  String? get productName => _productName;

  String? get description => _description;

  Type? get type => _type;

  Status? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reporting_user'] = _reportingUser;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['description'] = _description;
    if (_type != null) {
      map['type'] = _type?.toJson();
    }
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    return map;
  }
}

class Status {
  Status({
    String? value,
    String? label,
  }) {
    _value = value;
    _label = label;
  }

  Status.fromJson(dynamic json) {
    _value = json['value'];
    _label = json['label'];
  }

  String? _value;
  String? _label;

  String? get value => _value;

  String? get label => _label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['label'] = _label;
    return map;
  }
}

class Type {
  Type({
    String? value,
    String? label,
  }) {
    _value = value;
    _label = label;
  }

  Type.fromJson(dynamic json) {
    _value = json['value'];
    _label = json['label'];
  }

  String? _value;
  String? _label;

  String? get value => _value;

  String? get label => _label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['label'] = _label;
    return map;
  }
}
