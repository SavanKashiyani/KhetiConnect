import 'package:kheticonnect/data/model/product.dart';

abstract class HomeEvent {}

class LoadDashboardEvent extends HomeEvent {}

class ReloadDashboardEvent extends HomeEvent {}

class FavoriteClickEvent extends HomeEvent {
  final Product product;

  FavoriteClickEvent(this.product);
}

class FavoriteToggleEvent extends HomeEvent {}
