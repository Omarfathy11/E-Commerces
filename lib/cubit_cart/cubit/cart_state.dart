part of 'cart_cubit.dart';

abstract class CartState {}

 class CartsInitial extends CartState {

 }

 class GetcartSuccessState extends CartState{
  final List<CartModel> carts;

  GetcartSuccessState(this.carts);
 }
class FailedToGetCartState extends CartState{}


 class AddcartSuccessState extends CartState{
          Set<String> cartsID = {};
AddcartSuccessState(this.cartsID);
 }
class FailedToaddCartState extends CartState{}

class CartsError extends CartState {
  final String errorMessage;

  CartsError(this.errorMessage);
}
class CartsLoadingDeleted extends CartState {}
class CartsDeleted extends CartState {
     
}
