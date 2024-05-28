
import 'package:smallproject/models/cart_model.dart';

abstract class FavoritesState {
    Set<String> favoritesID = {};

}

 class FavoritesInitial extends FavoritesState {}
 


class FavoritesLoadnigState extends FavoritesState{
  
}
class  FavoritesSuccessState extends FavoritesState {
  final List<Product> favorites;

  FavoritesSuccessState(this.favorites);

}
class FavoritesErrorState extends FavoritesState{}
class FavoritesErrorStatError extends FavoritesState{}


class FavoritesaddSuccess extends FavoritesState{
    @override
  Set<String> favoritesID = {};
FavoritesaddSuccess(this.favoritesID);
}

class FavoritesError extends FavoritesState {
  final String errorMessage;

  FavoritesError(this.errorMessage);
}
class FavoritesLoadingDeleted extends FavoritesState {}
class FavoritesDeleted extends FavoritesState {
      @override
  Set<String> favoritesID = {};
FavoritesDeleted(this.favoritesID);
 
}
