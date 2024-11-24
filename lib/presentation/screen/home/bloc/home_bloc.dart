import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/screen/product_list/product_repo.dart';

import '../../../../data/model/BannerInfo.dart';
import '../../../../data/model/GetCategoriesResModel.dart';
import '../../../base/api_render_state.dart';
import '../../../base/base_bloc.dart';
import '../home_repo.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, ApiRenderState> {
  final _repo = HomeRepo();
  final _productRepo = ProductRepo();
  List<Categories> categories = [];
  List<Product> newlyAddedProducts = [];
  List<Product> mostRentedProducts = [];
  List<BannerInfo> bannerList = [];

  HomeBloc() : super(Ideal()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
    on<ReloadDashboardEvent>(_onLoadDashboard);
    on<FavoriteClickEvent>(_onFavoriteClick);
    on<FavoriteToggleEvent>(_onFavoriteToggled);
  }

  _onLoadDashboard(event, emit) async {
    emit(Loading());
    var response = await _repo.getDashboard(onApiError: onApiError);
    if (response != null) {
      categories = response.categories ?? [];
      newlyAddedProducts = response.newProducts ?? [];
      mostRentedProducts = response.mostRentedProducts ?? [];
      bannerList = response.banners ?? [];
      emit(DashboardDataRetrievedState());
    }
  }

  _onFavoriteClick(FavoriteClickEvent event, emit) async {
    // emit(Loading());
    var response = await _productRepo.addOrRemoveFavorite(
      productId: event.product.id,
      onApiError: onApiError,
    );
    if (response?.data != null) {
      emit(ApiSuccess(response));
    }
  }

  _onFavoriteToggled(event, emit) async {
    emit(OnChangeState());
  }
}
