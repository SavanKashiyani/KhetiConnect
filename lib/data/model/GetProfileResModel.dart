import 'package:kheticonnect/data/model/user.dart';

import 'meta.dart';

class GetProfileResModel {
  GetProfileResModel({
    User? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  GetProfileResModel.fromJson(dynamic json) {
    _data = json['data'] != null ? User.fromJson(json['data']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  User? _data;
  Meta? _meta;

  User? get data => _data;

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
