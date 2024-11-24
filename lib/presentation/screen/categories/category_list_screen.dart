import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/model/GetCategoriesResModel.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/app_bar/custom_app_bar.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_refresh_indicator.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/screen/categories/bloc/categories_bloc.dart';
import 'package:kheticonnect/presentation/screen/categories/bloc/categories_event.dart';
import 'package:kheticonnect/presentation/screen/categories/bloc/categories_state.dart';
import 'package:kheticonnect/resources/styles/padding.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../base/api_render_state.dart';
import '../../custom/widget/no_data_widget.dart';
import '../../service/navigation.dart';
import '../home/widget/categories_item_widget.dart';

class CategoryListScreen extends BaseWidget {
  final searchController = TextEditingController();

  CategoryListScreen({super.key});
  var categories = <Categories>[];
  final categoriesBloc = CategoriesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, ApiRenderState>(
      bloc: categoriesBloc..add(LoadCategoriesEvent()),
      listener: (BuildContext context, ApiRenderState state) {
        if (state is ApiFailure) {
          showError(state.data);
        }else if (categoriesBloc.state is CategoriesRetrievedState) {
          categories =
              (categoriesBloc.state as CategoriesRetrievedState).categories;
        }
      },
      builder: (BuildContext context, ApiRenderState state) {
        return StackLoader(
          state: state,
          child: Scaffold(
            backgroundColor: ColorName.whiteBg,
            extendBody: true,
            appBar: CustomAppBar(title: Strings.categories()),
            body: Padding(
              padding: AppPadding.tabScreensPadding,
              child: Column(
                children: [
                  _buildSearchWidget(),
                  addHeight(8),
                  _buildListWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchWidget() {
    return CustomTextField(
      controller: searchController,
      hintText: Strings.search(),
      onChanged: (text) => categoriesBloc.add(SearchCategoriesEvent(text)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      borderDecoration: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      prefix: Assets.drawables.icSearch.svg(height: 24, width: 24),
    );
  }

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();

  Widget _buildListWidget() {

    return CustomProgressIndicator(
      key: refreshIndicatorKey,
      onRefresh: () async {
        categoriesBloc.add(ReLoadCategoriesEvent());
      },
      child: categories.isEmpty
          ? NoDataWidget(
              isScrollable: false,
              title: Strings.noCategoriesTitle(),
              desc: Strings.noCategoriesDesc(),
            )
          : GridView.builder(
              padding: const EdgeInsets.only(top: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.h,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildListItemWidget(categories[index]);
              },
            ),
    ).expanded;
  }

  Widget _buildListItemWidget(Categories category) {
    return CategoriesItemWidget(
      category: category,
      maxLines: 2,
      onCategoryClick: (category) {
        navigation.push(Routes.productList(
          title: category.name,
          categoryId: category.id.toString(),
        ));
      },
    );
  }
}
