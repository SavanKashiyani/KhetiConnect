import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/custom/widget/no_data_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/search_bar/search_bar.dart';
import 'package:kheticonnect/presentation/screen/home/bloc/home_bloc.dart';
import 'package:kheticonnect/presentation/screen/home/bloc/home_event.dart';
import 'package:kheticonnect/presentation/screen/product_list/list_type.dart';
import 'package:kheticonnect/presentation/service/navigation.dart';
import 'package:kheticonnect/resources/styles/padding.dart';
import 'package:kheticonnect/util/extensions.dart';
import 'package:kheticonnect/util/text_styles.dart';

import '../../custom/widget/custom_refresh_indicator.dart';
import 'banner_list.dart';
import 'widget/categories_item_widget.dart';
import 'widget/productcard_item_widget.dart';

class HomeScreen extends BaseWidget {
  HomeScreen({super.key});

  final _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _bloc.state is Ideal ? (_bloc..add(LoadDashboardEvent())) : _bloc,
        listener: (context, state) {
          if (state is ApiFailure) {
            showError(state.data);
          }
        },
        builder: (context, ApiRenderState state) {
          return StackLoader(
            state: state,
            child: Scaffold(
              backgroundColor: ColorName.gray50,
              body: CustomProgressIndicator(
                onRefresh: () async {
                  _bloc.add(ReloadDashboardEvent());
                },
                child: SizedBox.expand(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: AppPadding.tabScreensPadding,
                    child: Column(
                      children: [
                        _buildSearchSection(),
                        _buildBannerSection(),
                        _buildBrowseCategorySection(),
                        _buildNewlyAddedSection(),
                        _buildMostRentedSection(),
                         NoDataWidget(shrinkWrap: true,height: 500,desc: Strings.noProductsFound(),).visibility(isVisible: _bloc.mostRentedProducts.isEmpty)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildSearchSection() {
    return CustomSearchBar(
      isDisabled: true,
      onFilterClick: () {
        navigation.push(Routes.productList(isNavigatedFromFilter: true));
      },
      showFilter: true,
    ).addOnTap(() {
      navigation.push(Routes.productList(isNavigatedFromSearch: true));
    });
  }

  Widget _buildBannerSection() {
    return BannerListWidget(
      bannerList: _bloc.bannerList,
      onBannerButtonClick: (banner) {
      },
    ).visibility(isVisible: _bloc.bannerList.isNotEmpty);
  }

  Widget _buildSectionHeader(
    String title, {
    bool showSeeAll = true,
    Function()? onSeeAllClick,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyles.exo.semiBold.of(18, color: ColorName.primary),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              Strings.seeAll(),
              style: TextStyles.exo.semiBold.of(12, color: ColorName.gray500),
            ),
            Assets.drawables.icArrowRight.svg(
              height: 18.adaptSize,
              width: 18.adaptSize,
            ),
          ],
        ).addOnTap(() {
          onSeeAllClick?.call();
        }).visibility(isVisible: showSeeAll),
      ],
    );
  }

  Widget _buildBrowseCategorySection() {
    return Column(
      children: [
        SizedBox(height: 24.v),
        _buildSectionHeader(
          Strings.browseCategories(),
          onSeeAllClick: () {
            navigation.push(Routes.categories);
          },
        ),
        addHeight(16.v),
        SizedBox(
          height: 94.v,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => addWidth(12.h),
            itemCount: _bloc.categories.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 90.h,
                child: CategoriesItemWidget(
                  category: _bloc.categories[index],
                  onCategoryClick: (category) {
                    navigation.push(Routes.productList(
                      title: category.name,
                      categoryId: category.id.toString(),
                    ));
                  },
                ),
              );
            },
          ),
        ),
      ],
    ).visibility(isVisible: _bloc.categories.isNotEmpty);
  }

  Widget _buildNewlyAddedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.v),
        _buildSectionHeader(
          Strings.newlyAdded(),
          onSeeAllClick: () {
            navigation.push(Routes.productList(
              title: Strings.newlyAdded(),
              columns: 1,
              listType: ListType.newly_added,
            ));
          },
        ),
        addHeight(16.v),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
          child: Row(
            children:
                List.generate(_bloc.newlyAddedProducts.length,
                (index) {
                  var product = _bloc.newlyAddedProducts[index];
                  return Row(
                    children: [
                      ProductCardItemWidget(
                        product: product,
                        width: 260.h,
                        height: 140.v,
                        onFavoriteClick: (product) {
                          _bloc.add(FavoriteClickEvent(product));
                        },
                        onProductClick: (product) {
                          navigation.push(Routes.productDetail(product));
                        },
                      ),
                      if(index < _bloc.newlyAddedProducts.length - 1) SizedBox(width: 16.h),
                    ],
                  );
                },)
          ),
        )
      ],
    ).visibility(isVisible: _bloc.newlyAddedProducts.isNotEmpty);
  }

  Widget _buildMostRentedSection() {
    return Column(
      children: [
        SizedBox(height: 24.v),
        _buildSectionHeader(
          Strings.mostRented(),
          onSeeAllClick: () {
            navigation.push(Routes.productList(
              title: Strings.mostRented(),
              listType: ListType.most_rented,
            ));
          },
        ),
        addHeight(16.v),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 226.v,
            crossAxisCount: 2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.h,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _bloc.mostRentedProducts.length,
          itemBuilder: (context, index) {
            return Wrap(
              children: [
                ProductCardItemWidget(
                  product: _bloc.mostRentedProducts[index],
                  width: double.maxFinite,
                  height: 140.v,
                  onFavoriteClick: (product) {
                    _bloc.add(FavoriteClickEvent(product));
                  },
                  onProductClick: (product) {
                    navigation.push(Routes.productDetail(product));
                  },
                ),
              ],
            );
          },
        ),
      ],
    ).visibility(isVisible: _bloc.mostRentedProducts.isNotEmpty);
  }
}
