import '../../../../data/enums/condition_type_enum.dart';
import '../../../../data/enums/product_type_enum.dart';

abstract class ProductListEvent {}

class LoadProductListEvent extends ProductListEvent {}

class ReLoadProductListEvent extends ProductListEvent {}

class LoadMoreProductListEvent extends ProductListEvent {}

class SearchChangeEvent extends ProductListEvent {
  final String? text;

  SearchChangeEvent(this.text);
}

class FilterChangeEvent extends ProductListEvent {
  final List<ProductType>? selectedProductTypes;
  final List<ConditionType>? selectedConditionTypes;

  FilterChangeEvent(
    this.selectedProductTypes,
    this.selectedConditionTypes,
  );
}
