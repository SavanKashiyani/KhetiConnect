import 'package:kheticonnect/data/model/product.dart';

import 'meta.dart';

class ProductListResModel {
  ProductListResModel({
    ProductListData? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  ProductListResModel.fromJson(dynamic json) {
    _data =
        json['data'] != null ? ProductListData.fromJson(json['data']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  ProductListData? _data;
  Meta? _meta;

  ProductListData? get data => _data;

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

class ProductListData {
  ProductListData({
    List<Product>? products,
    int? totalPages,
  }) {
    _products = products;
    _totalPages = totalPages;
  }

  ProductListData.fromJson(dynamic json) {
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Product.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
  }

  List<Product>? _products;
  int? _totalPages;

  List<Product>? get products => _products;

  int? get totalPages => _totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    if (_totalPages != null) {
      map['total_pages'] = _totalPages;
    }
    return map;
  }
}
