import 'package:kheticonnect/data/model/GetCategoriesResModel.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';

abstract class CategoriesState extends ApiRenderState {}

class InitialState extends CategoriesState {}

class CategoriesRetrievedState extends CategoriesState {
  List<Categories> categories;

  CategoriesRetrievedState(this.categories);
}
