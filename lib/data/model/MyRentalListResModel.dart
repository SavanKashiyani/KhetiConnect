import 'meta.dart';

class MyRentalListResModel {
  MyRentalListResModel({
    List<MyRentalProduct>? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  MyRentalListResModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MyRentalProduct.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<MyRentalProduct>? _data;
  Meta? _meta;

  List<MyRentalProduct>? get data => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

class MyRentalProduct {
  MyRentalProduct({
    num? id,
    num? productId,
    String? productName,
    String? productImage,
    String? status,
    String? sellerStatus,
    String? statusToShow,
  }) {
    _id = id;
    _productId = productId;
    _productName = productName;
    _productImage = productImage;
    _status = status;
    _sellerStatus = sellerStatus;
    _statusToShow = statusToShow;
  }

  MyRentalProduct.fromJson(dynamic json) {
    _id = json['id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _status = json['status'];
    _sellerStatus = json['seller_status'];
    _statusToShow = json['status_to_show'];
  }

  num? _id;
  num? _productId;
  String? _productName;
  String? _productImage;
  String? _status;
  String? _sellerStatus;
  String? _statusToShow;

  num? get id => _id;

  num? get productId => _productId;

  String? get productName => _productName;

  String? get productImage => _productImage;

  String? get status => _status;

  String? get sellerStatus => _sellerStatus;

  String? get statusToShow => _statusToShow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['product_image'] = _productImage;
    map['status'] = _status;
    map['seller_status'] = _sellerStatus;
    map['status_to_show'] = _statusToShow;
    return map;
  }
}
