import 'package:kheticonnect/data/model/product.dart';

import 'meta.dart';

class FavoriteListResModel {
  FavoriteListResModel({
    Data? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  FavoriteListResModel.fromJson(dynamic json) {
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
    List<Product>? products,
    num? totalCount,
  }) {
    _products = products;
    _totalCount = totalCount;
  }

  Data.fromJson(dynamic json) {
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Product.fromJson(v));
      });
    }
    _totalCount = json['total_count'];
  }

  List<Product>? _products;
  num? _totalCount;

  List<Product>? get products => _products;

  num? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['total_count'] = _totalCount;
    return map;
  }
}
