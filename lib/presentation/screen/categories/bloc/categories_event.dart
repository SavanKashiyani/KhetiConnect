abstract class CategoriesEvent {}

class LoadCategoriesEvent extends CategoriesEvent {}

class ReLoadCategoriesEvent extends CategoriesEvent {}

class SearchCategoriesEvent extends CategoriesEvent {
  final String searchText;

  SearchCategoriesEvent(this.searchText);
}
