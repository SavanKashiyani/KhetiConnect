import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_bloc.dart';
import 'package:kheticonnect/presentation/screen/product_list/bloc/product_list_state.dart';
import 'package:kheticonnect/presentation/screen/product_list/list_type.dart';
import 'package:kheticonnect/presentation/screen/product_list/product_repo.dart';

import '../../../../data/enums/condition_type_enum.dart';
import '../../../../data/enums/product_type_enum.dart';
import 'product_list_event.dart';

class ProductListBloc extends BaseBloc<ProductListEvent, ApiRenderState> {
  final _repo = ProductRepo();

  List<Product> productList = [];

  String? categoryId;
  final ListType? _listType;

  String? _searchText;
  Timer? _searchDebounceTimer;

  List<ProductType>? selectedProductTypes;
  List<ConditionType>? selectedConditionTypes;

  int _currentPage = 1;
  num _totalPage = 1;

  bool isFilterApplied() {
    if (selectedConditionTypes?.isNotEmpty ?? false) {
      return true;
    } else if (selectedProductTypes?.isNotEmpty ?? false) {
      return true;
    } else {
      return false;
    }
  }

  ProductListBloc({this.categoryId, ListType? listType})
      : _listType = listType,
        super(InitialState()) {
    on<LoadProductListEvent>(_onLoadProductList);
    on<ReLoadProductListEvent>(_onReLoadProductList);
    on<LoadMoreProductListEvent>(_onLoadMoreProductList);
    on<SearchChangeEvent>(_onSearchTextChanged);
    on<FilterChangeEvent>(_onFilterChanged);
  }

  _onLoadProductList(event, emit) async {
    if (_currentPage == 1) {
      emit(Loading());
    } else {
      emit(LoadMore());
    }
    var response = await _repo.getProductList(
      categoryId: categoryId,
      listType: _listType,
      searchText: _searchText,
      selectedConditionTypes: selectedConditionTypes,
      selectedProductTypes: selectedProductTypes,
      currentPage: _currentPage,
      onApiError: onApiError,
    );
    if (response != null) {
      if (_currentPage == 1) {
        productList.clear();
      }
      productList.addAll(response.data?.products ?? []);
      _totalPage = response.data?.totalPages ?? 1;
      emit(ProductsRetrievedState());
    }
  }

  _onReLoadProductList(event, emit) async {
    _currentPage = 1;
    add(LoadProductListEvent());
  }

  _onLoadMoreProductList(event, emit) async {
    if (state is! Loading && state is! LoadMore && _currentPage < _totalPage) {
      ++_currentPage;
      add(LoadProductListEvent());
    }
  }

  _onSearchTextChanged(SearchChangeEvent event, emit) async {
    _searchText = event.text;
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(const Duration(seconds: 1), () {
      if (!isClosed) {
        _currentPage = 1;
        add(LoadProductListEvent());
      }
    });
  }

  _onFilterChanged(FilterChangeEvent event, emit) async {
    selectedConditionTypes = event.selectedConditionTypes;
    selectedProductTypes = event.selectedProductTypes;
    debugPrint("Filters = ${event.selectedConditionTypes}");
    _currentPage = 1;
    add(LoadProductListEvent());
  }
}
