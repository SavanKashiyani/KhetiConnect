import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/app_bar/custom_app_bar.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_refresh_indicator.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/custom/widget/no_data_widget.dart';
import 'package:kheticonnect/presentation/screen/product_list/bloc/product_list_event.dart';
import 'package:kheticonnect/presentation/screen/product_list/bloc/product_list_state.dart';
import 'package:kheticonnect/resources/styles/padding.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../custom/widget/bottom_sheet/filter_bottom_sheet.dart';
import '../../custom/widget/search_bar/search_bar.dart';
import '../../service/navigation.dart';
import '../account/my_fav/bloc/favorites_bloc.dart';
import '../account/my_fav/bloc/favorites_event.dart';
import '../home/widget/productcard_item_widget.dart';
import 'bloc/product_list_bloc.dart';
import 'list_type.dart';

class ProductListScreen extends BaseWidget {
  final String? title;
  final int columns;
  final bool isNavigatedFromSearch;
  final bool isNavigatedFromFilter;

  final searchController = TextEditingController();
  final focusNode = FocusNode();
  late final ProductListBloc productListBloc;
  final _blocFavList = FavoritesBloc();

  ProductListScreen({
    Key? key,
    this.title,
    required this.columns,
    required this.isNavigatedFromSearch,
    required this.isNavigatedFromFilter,
    String? categoryId,
    ListType? listType,
  }) : super(key: key) {
    productListBloc =
        ProductListBloc(categoryId: categoryId, listType: listType);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (isNavigatedFromFilter) {
        _showFilterBottomSheet();
      }
    });
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductListBloc>(
          create: (BuildContext context) => productListBloc..add(LoadProductListEvent()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (BuildContext context) => _blocFavList,
        ),
      ],

      child: MultiBlocListener(
        listeners: [
          BlocListener<FavoritesBloc, ApiRenderState>(
            listener: (context, state) {
              if (state is OnChangeState) {
                Product updatedProduct = state.data;
                updatedProduct.toggleFavorite();
                int index = productListBloc.productList.indexWhere((element) => element.id == updatedProduct.id);
                if (productListBloc.productList.isNotEmpty && productListBloc.productList.length > index) {
                  productListBloc.productList[index] = updatedProduct;
                }
              }
            },
          ),
          BlocListener<ProductListBloc, ApiRenderState>(listener: (BuildContext context, ApiRenderState state) {
            if (state is ApiFailure) {
              showError(state.data);
            }
          })
        ],
        child: StackLoader(
          state: productListBloc.state,
          child: Scaffold(
            backgroundColor: ColorName.whiteBg,
            extendBody: true,
            appBar: CustomAppBar(title: title ?? Strings.search()),
            body: Padding(
              padding: AppPadding.tabScreensPadding,
              child: Column(
                children: [
                  _buildSearchWidget(productListBloc.state),
                  addHeight(8),
                  _buildListWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget(ApiRenderState state) {
    if (isNavigatedFromSearch && state is InitialState) {
      focusNode.requestFocus();
    }
    return CustomSearchBar(
      showFilter: true,
      hint: productListBloc.categoryId != null ? Strings.search() : null,
      controller: searchController,
      focusNode: focusNode,
      onChanged: (text) {
        productListBloc.add(SearchChangeEvent(text));
      },
      isFilterApplied: productListBloc.isFilterApplied(),
      onFilterClick: _showFilterBottomSheet,
    );
  }

  _showFilterBottomSheet() {
    showBSFilter(
      selectedConditionTypes: productListBloc.selectedConditionTypes ?? [],
      selectedProductTypes: productListBloc.selectedProductTypes ?? [],
      onFilterChanged: (BSFilterState filter) {
        productListBloc.add(FilterChangeEvent(
          filter.selectedProductTypes.toList(),
          filter.selectedConditionTypes.toList(),
        ));
      },
    );
  }

  Widget _buildListWidget() {
    return BlocBuilder(
      bloc: productListBloc,
      builder: (context, state) {
        return BlocBuilder(
          bloc: _blocFavList,
          builder: (context, state)
        {
          return CustomProgressIndicator(
            onRefresh: () async {
              productListBloc.add(ReLoadProductListEvent());
            },
            child: productListBloc.productList.isEmpty
                ? NoDataWidget(
                title: Strings.noProductsTitle(), desc: Strings.noProductsDesc())
                : GridView.builder(
              padding: const EdgeInsets.only(top: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 226.v,
                crossAxisCount: columns,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.h,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: productListBloc.productList.length,
              itemBuilder: (context, index) {
                if (index >= productListBloc.productList.length - 1) {
                  productListBloc.add(LoadMoreProductListEvent());
                }
                return _buildListItemWidget(productListBloc.productList[index]);
              },
            ),
          ).expanded;
        });
      },
    );
  }

  Widget _buildListItemWidget(Product product) {
    return Wrap(
      children: [
        ProductCardItemWidget(
          product: product,
          width: double.maxFinite,
          height: 140.v,
          onFavoriteClick: (product) {
            // _blocFavList.add(UnFavoriteEvent(product));
          },
          onProductClick: (product) {
            // navigation.push(Routes.productDetail(product));
          },
        ),
      ],
    );
  }
}
