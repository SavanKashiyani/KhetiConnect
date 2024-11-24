class Meta {
  Meta({
    String? message,
    String? url,
  }) {
    _message = message;
    _url = url;
  }

  Meta.fromJson(dynamic json) {
    _message = json['message'];
    _url = json['url'];
  }

  String? _message;
  String? _url;

  String? get message => _message;

  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['url'] = _url;
    return map;
  }
}
