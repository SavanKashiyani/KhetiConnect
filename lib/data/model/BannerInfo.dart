class BannerInfo {
  BannerInfo({
    String? image,
  }) {
    _image = image;
  }

  BannerInfo.fromJson(dynamic json) {
    _image = json['image'];
  }

  String? _image;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }
}
