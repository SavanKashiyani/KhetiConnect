import 'package:kheticonnect/data/model/product.dart';

class ModelSellerDetails {
  ModelSellerDetails({
      BuyerSellerDetails? seller,
      List<Product>? products,}){
    _seller = seller;
    _products = products;
}

  ModelSellerDetails.fromJson(dynamic json) {
    _seller = json['seller'] != null ? BuyerSellerDetails.fromJson(json['seller'], true) : null;
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Product.fromJson(v));
      });
    }
  }
  BuyerSellerDetails? _seller;
  List<Product>? _products;
ModelSellerDetails copyWith({  BuyerSellerDetails? seller,
  List<Product>? products,
}) => ModelSellerDetails(  seller: seller ?? _seller,
  products: products ?? _products,
);
  BuyerSellerDetails? get seller => _seller;
  List<Product>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_seller != null) {
      map['seller'] = _seller?.toJson();
    }
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

