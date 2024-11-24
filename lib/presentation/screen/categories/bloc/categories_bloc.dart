import 'package:kheticonnect/data/model/GetCategoriesResModel.dart';
import 'package:kheticonnect/presentation/screen/categories/categories_repo.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../base/api_render_state.dart';
import '../../../base/base_bloc.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends BaseBloc<CategoriesEvent, ApiRenderState> {
  final _repo = CategoriesRepo();
  List<Categories> _categories = [];
  String _searchText = "";

  List<Categories> _filterCategories() {
    if (_searchText.isEmpty) {
      return _categories;
    }
    return _categories
        .where((e) =>
            e.name.orEmpty.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  CategoriesBloc() : super(InitialState()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<ReLoadCategoriesEvent>(_onLoadCategories);
    on<SearchCategoriesEvent>(_onSearchCategories);
  }

  _onLoadCategories(event, emit) async {
    emit(Loading());
    var response = await _repo.getCategories(onApiError: onApiError);
    if (response != null) {
      _categories = response.data?.categories ?? [];
      emit(CategoriesRetrievedState(_filterCategories()));
    }
  }

  _onSearchCategories(event, emit) async {
    _searchText = event.searchText;
    emit(CategoriesRetrievedState(_filterCategories()));
  }
}
