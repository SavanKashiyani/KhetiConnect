import 'meta.dart';

class AddOrRemoveFavoriteResModel {
  AddOrRemoveFavoriteResModel({
    bool? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  AddOrRemoveFavoriteResModel.fromJson(dynamic json) {
    _data = json['data'];
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  bool? _data;
  Meta? _meta;

  bool? get data => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}
