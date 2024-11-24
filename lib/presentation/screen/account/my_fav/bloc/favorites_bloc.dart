import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_bloc.dart';

import '../../../product_list/product_repo.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends BaseBloc<FavoritesEvent, ApiRenderState> {
  final _repo = ProductRepo();

  List<Product> favoriteList = [];

  FavoritesBloc() : super(Ideal()) {
    on<LoadFavoriteListEvent>(_onLoadFavoriteList);
    on<ReLoadFavoriteListEvent>(_onLoadFavoriteList);
    on<UnFavoriteEvent>(_onUnFavorite);
  }

  _onLoadFavoriteList(event, emit) async {
    emit(Loading());
    var response = await _repo.getFavorites(onApiError: onApiError);
    if (response != null) {
      favoriteList.clear();
      favoriteList.addAll(response.data?.products ?? []);
      for (var element in favoriteList) {
        element.toggleFavorite();
      }
      emit(FavoriteListRetrievedState());
    }
  }

  _onUnFavorite(UnFavoriteEvent event, emit) async {
    emit(Loading());
    var response = await _repo.addOrRemoveFavorite(
      productId: event.product.id,
      onApiError: onApiError,
    );
    if (response?.data != null) {
      favoriteList.remove(event.product);
      emit(OnChangeState(data : event.product));
    }
  }
}
