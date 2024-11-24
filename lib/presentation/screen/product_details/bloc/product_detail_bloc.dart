import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_bloc.dart';
import 'package:kheticonnect/presentation/screen/product_details/bloc/product_detail_state.dart';
import 'package:kheticonnect/presentation/screen/product_list/product_repo.dart';

import 'product_detail_event.dart';

class ProductDetailBloc extends BaseBloc<ProductDetailEvent, ApiRenderState> {
  final _repo = ProductRepo();
  bool? isSeller;
  Product? productDetail;

  ProductDetailBloc({this.productDetail}) : super(Ideal()) {
    on<LoadProductDetailEvent>(_onLoadProductDetail);
    on<FavoriteClickEvent>(_onFavoriteClick);
    isSeller = (storage.userInfo.id == productDetail?.sellerDetails?.id);
  }

  _onLoadProductDetail(event, emit) async {
    emit(Loading());
    var response = await _repo.getProductDetail(
      productId: productDetail?.id.toString(),
      onApiError: onApiError,
    );
    if (response != null) {
      if (response.data != null) {
        productDetail = response.data;
        isSeller = (storage.userInfo.id == productDetail?.sellerDetails?.id);
      }
      emit(ProductDetailRetrievedState());
    }
  }

  _onFavoriteClick(event, emit) async {
    emit(Loading());
    var response = await _repo.addOrRemoveFavorite(
        productId: productDetail?.id, onApiError: onApiError);
    if (response?.data != null) {
      productDetail?.toggleFavorite();
      emit(ApiSuccess(response));
    }
  }
}
