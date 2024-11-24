import 'meta.dart';

class GetCategoriesResModel {
  GetCategoriesResModel({
    Data? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  GetCategoriesResModel.fromJson(dynamic json) {
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
    List<Categories>? categories,
    num? maxProductOld,
    num? maxRentalPeriod,
  }) {
    _categories = categories;
    _maxProductOld = maxProductOld;
    _maxRentalPeriod = maxRentalPeriod;
  }

  Data.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    _maxProductOld = json['max_product_old'];
    _maxRentalPeriod = json['max_rental_period'];
  }

  List<Categories>? _categories;
  num? _maxProductOld;
  num? _maxRentalPeriod;

  List<Categories>? get categories => _categories;

  num? get maxProductOld => _maxProductOld;

  num? get maxRentalPeriod => _maxRentalPeriod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    map['max_product_old'] = _maxProductOld;
    map['max_rental_period'] = _maxRentalPeriod;
    return map;
  }
}

class Categories {
  Categories({
    num? id,
    String? name,
    String? icon,
  }) {
    _id = id;
    _name = name;
    _icon = icon;
  }

  Categories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
  }

  num? _id;
  String? _name;
  String? _icon;

  num? get id => _id;

  String? get name => _name;

  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    return map;
  }
}
