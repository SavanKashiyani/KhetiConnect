import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/data/model/product.dart';
import 'package:kheticonnect/data/model/product_status.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_refresh_indicator.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/custom/widget/no_data_widget.dart';
import 'package:kheticonnect/presentation/screen/my_rentals/bloc/my_rental_bloc.dart';
import 'package:kheticonnect/presentation/screen/my_rentals/bloc/my_rental_event.dart';
import 'package:kheticonnect/presentation/screen/my_rentals/widget/row_rental_product.dart';
import 'package:kheticonnect/resources/styles/padding.dart';


class MyRentalsScreen extends BaseWidget {
  MyRentalsScreen({super.key});

  final _bloc = MyRentalBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _bloc.rentalList.isEmpty ? (_bloc..add(LoadMyRentalListEvent())) : _bloc,
        listener: (context, state) {
          if (state is ApiFailure) {
            showError(state.data);
          }
        },
        builder: (context, ApiRenderState state) {
          return StackLoader(
            state: state,
            child: _renderRentalList(),
          );
        });
  }

  _renderRentalList() {
    return CustomProgressIndicator(
      onRefresh: () async {
        _bloc.add(LoadMyRentalListEvent());
      },
      child: _bloc.rentalList.isEmpty && _bloc.state is! Loading
          ? const NoDataWidget()
          : SafeArea(
              child: GridView.builder(
                padding: AppPadding.screensPadding,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 250,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: _bloc.rentalList.length,
                itemBuilder: (context, index) {
                  var rentalProduct = _bloc.rentalList[index];
                  return Wrap(
                    children: [
                      RowRentalProduct(
                        product: Product(
                          name: rentalProduct.productName,
                          images: [Images(url: rentalProduct.productImage)],
                          status: ProductStatus(
                            key: rentalProduct.sellerStatus,
                            value: rentalProduct.statusToShow,
                          ),
                          ),
                          onItemClick: () {
                          })
                    ],
                  );
                },
              ),
            ),
    );
  }
}
