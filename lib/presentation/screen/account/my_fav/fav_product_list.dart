import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/app_bar/custom_app_bar.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_refresh_indicator.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/custom/widget/no_data_widget.dart';
import 'package:kheticonnect/presentation/screen/account/my_fav/bloc/favorites_event.dart';
import 'package:kheticonnect/presentation/screen/my_rentals/widget/row_rental_product.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../service/navigation.dart';
import 'bloc/favorites_bloc.dart';

class MyFavProductListScreen extends BaseWidget {
  MyFavProductListScreen({super.key});

  final FavoritesBloc _bloc = FavoritesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _bloc..add(LoadFavoriteListEvent()),
        listener: (context, state) {
          if (state is ApiFailure) {
            showError(state.data);
          }
        },
        builder: (context, ApiRenderState state) {
          return StackLoader(
            state: state,
            child: Scaffold(
              backgroundColor: ColorName.whiteBg,
              appBar: _renderAppBar(),
              body:_renderRentalList(),
            ),
          );
        });
  }

  _renderRentalList() {
    return CustomProgressIndicator(
      onRefresh: () async {
        _bloc.add(ReLoadFavoriteListEvent());
      },
      child: _bloc.favoriteList.isEmpty && _bloc.state is! Loading
          ? const NoDataWidget(
              shrinkWrap: true,
              height: 700,
              width: double.infinity,
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
              ),
              itemCount: _bloc.favoriteList.length,
              itemBuilder: (context, index) {
                var product = _bloc.favoriteList[index];
                return Wrap(
                  children: [
                    RowRentalProduct(
                      product: product,
                      isFavoriteAllow: true,
                      onFavoriteClick: () {
                        _bloc.add(UnFavoriteEvent(product));
                      },
                      onItemClick: () {
                        // navigation.push(Routes.productDetail(product));
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }

  _renderAppBar() {
    return CustomAppBar(
      title: Strings.myFavourites()
          .toString()
          .appendCount(_bloc.favoriteList.length),
    );
  }
}
