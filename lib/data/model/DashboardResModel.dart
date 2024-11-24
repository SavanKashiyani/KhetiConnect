import 'BannerInfo.dart';
import 'GetCategoriesResModel.dart';
import 'product.dart';

class DashboardResModel {
  DashboardResModel({
    List<Categories>? categories,
    List<Product>? newProducts,
    List<Product>? mostRentedProducts,
    List<BannerInfo>? banners,
  }) {
    _categories = categories;
    _newProducts = newProducts;
    _mostRentedProducts = mostRentedProducts;
    _banners = banners;
  }

  DashboardResModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(Categories.fromJson(v));
      });
    }
    if (json['new_products'] != null) {
      _newProducts = [];
      json['new_products'].forEach((v) {
        _newProducts?.add(Product.fromJson(v));
      });
    }
    if (json['most_rented_products'] != null) {
      _mostRentedProducts = [];
      json['most_rented_products'].forEach((v) {
        _mostRentedProducts?.add(Product.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners?.add(BannerInfo.fromJson(v));
      });
    }
  }

  List<Categories>? _categories;
  List<Product>? _newProducts;
  List<Product>? _mostRentedProducts;
  List<BannerInfo>? _banners;

  List<Categories>? get categories => _categories;

  List<Product>? get newProducts => _newProducts;

  List<Product>? get mostRentedProducts => _mostRentedProducts;

  List<BannerInfo>? get banners => _banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    if (_newProducts != null) {
      map['new_products'] = _newProducts?.map((v) => v.toJson()).toList();
    }
    if (_mostRentedProducts != null) {
      map['most_rented_products'] =
          _mostRentedProducts?.map((v) => v.toJson()).toList();
    }
    if (_banners != null) {
      map['banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
