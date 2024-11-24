import 'package:kheticonnect/presentation/base/api_render_state.dart';

abstract class ProductListState extends ApiRenderState {}

class InitialState extends ProductListState {}

class ProductsRetrievedState extends ProductListState {}
