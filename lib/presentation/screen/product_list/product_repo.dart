import 'package:dio/dio.dart';
import 'package:kheticonnect/data/enums/buyer_seller_report_reason_enum.dart';
import 'package:kheticonnect/data/model/ProductListResModel.dart';
import 'package:kheticonnect/presentation/screen/product_list/list_type.dart';
import 'package:kheticonnect/util/app_const.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../data/api/api_caller.dart';
import '../../../data/api/api_constants.dart';
import '../../../data/enums/condition_type_enum.dart';
import '../../../data/enums/product_report_reason_enum.dart';
import '../../../data/enums/product_type_enum.dart';
import '../../../data/model/AddOrRemoveFavoriteResModel.dart';
import '../../../data/model/FavoriteListResModel.dart';
import '../../../data/model/ProductDetailResModel.dart';
import '../../../data/model/ReportProductResModel.dart';

class ProductRepo extends ApiCaller {
  Future<ProductListResModel?> getProductList({
    String? categoryId,
    ListType? listType,
    String? searchText,
    List<ProductType>? selectedProductTypes,
    List<ConditionType>? selectedConditionTypes,
    required int currentPage,
    Function(dynamic errorRes)? onApiError,
  }) async {
    Map<String, dynamic> data = {};
    if (categoryId != null) {
      data['list_type'] = "category";
      data['category_id'] = categoryId;
    } else if (listType != null) {
      data['list_type'] = listType.name;
    }
    if (!searchText.isNullOrEmpty) {
      data['search'] = searchText;
    }
    if (selectedProductTypes != null) {
      data['product_type[]'] =
          selectedProductTypes.map((pt) => pt.type).toList();
    }
    if (selectedConditionTypes != null) {
      data['product_condition[]'] =
          selectedConditionTypes.map((ct) => ct.value).toList();
    }
    data['page_no'] = currentPage;
    var formData = FormData();
    data.forEach((key, value) {
      if (value is List) {
        for (var item in value) {
          formData.fields.add(MapEntry(key, item.toString()));
        }
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });
    return await execute(
        apiCaller.post(url: ApiConstants.productList, data: formData),
        onApiError: onApiError,
        then: (res) => ProductListResModel.fromJson(res));
  }

  Future<ProductDetailResModel?> getProductDetail({
    String? productId,
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(url: ApiConstants.getProductDetail(productId)),
      onApiError: onApiError,
      then: (res) => ProductDetailResModel.fromJson(res),
    );
  }

  // Future<ProductReportReasonsResModel?> getProductReportReasons({
  //   Function(dynamic errorRes)? onApiError,
  // }) async {
  //   var res = await execute(
  //       apiCaller.get(url: ApiConstants.productReportReasons),
  //       onApiError: onApiError);
  //   if (res != null) {
  //     return ProductReportReasonsResModel.fromJson(res);
  //   }
  //   return null;
  // }

  Future<ReportProductResModel?> submitProductReportReason({
    required num? productId,
    required num? userId,
    required String type,
    String? otherReason,
    Function(dynamic errorRes)? onApiError,
  }) async {
    Map<String, dynamic> data = {};
    if (userId != null) {
      data['user_id'] = userId;
    }
    if(productId!=null) {
      data['product_id'] = productId;
    }
    data['type'] = type;
    if (type == ProductReportReasonType.Other.apiIdentifier || type == BuyerSellerReportReasonType.Other.apiIdentifier) {
      data['description'] = otherReason;
    }
    return await execute(
      apiCaller.post(url: productId!=null ? ApiConstants.reportProduct : ApiConstants.reportUser, data: data),
      onApiError: onApiError,
      then: (res) => ReportProductResModel.fromJson(res),
    );
  }

  Future<AddOrRemoveFavoriteResModel?> addOrRemoveFavorite({
    required num? productId,
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.post(url: ApiConstants.addOrRemoveFavorite(productId)),
      onApiError: onApiError,
      then: (res) {
        var resModel = AddOrRemoveFavoriteResModel.fromJson(res);
        return resModel;
      },
    );
  }

  Future<FavoriteListResModel?> getFavorites({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(url: ApiConstants.getFavorites),
      onApiError: onApiError,
      then: (res) => FavoriteListResModel.fromJson(res),
    );
  }
}
