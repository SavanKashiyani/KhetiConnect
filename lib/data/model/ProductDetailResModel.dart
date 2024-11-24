import 'package:kheticonnect/data/model/product.dart';

import 'meta.dart';

class ProductDetailResModel {
  ProductDetailResModel({
    Product? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  ProductDetailResModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Product.fromJson(json['data']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Product? _data;
  Meta? _meta;

  Product? get data => _data;

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
