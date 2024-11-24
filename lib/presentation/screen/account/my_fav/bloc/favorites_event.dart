import 'package:kheticonnect/data/model/product.dart';

abstract class FavoritesEvent {}

class LoadFavoriteListEvent extends FavoritesEvent {}

class ReLoadFavoriteListEvent extends FavoritesEvent {}

class UnFavoriteEvent extends FavoritesEvent {
  final Product product;

  UnFavoriteEvent(this.product);
}
