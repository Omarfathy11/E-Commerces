import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:smallproject/models/cart_model.dart';
import 'package:smallproject/shared/constants/constants.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartsInitial());

  List<CartModel> carts = [];
  Set<String> carstId = {};
  Future<void> getCarts() async {
    carts.clear();
    Response response = await http.get(
      Uri.parse(
          'https://django-e-commerce-production.up.railway.app/carts/my-cart/'),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
    );
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in responseBody) {
        carstId.add(item['id'].toString());
        carts.add(CartModel.fromJson(item));
      }
      print('carts number is ${carts.length}');
      emit(GetcartSuccessState(carts));
    } else {
      emit(FailedToGetCartState());
    }
  }

  void addCart({required String productId}) async {
    Response response = await http.post(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/carts/my-cart/"),
        headers: {'Authorization': 'Bearer $token'},
        body: {"product_id": productId});
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 201) {
         carstId.add(productId);
      emit(AddcartSuccessState(carstId));
    } else {
      emit(FailedToaddCartState());
    }
    
  }
  
void deleteCarts({required String productId}) async {
  try {
    emit(CartsLoadingDeleted());

    Response response = await http.delete(
      Uri.parse("https://django-e-commerce-production.up.railway.app/carts/my-cart/$productId/"),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 204) {
      emit(CartsDeleted());
      await getCarts();
    } else {
      emit(CartsError('Failed to delete carts'));
    }
  } catch (e) {
    emit(CartsError('An error occurred while deleting the cart'));
  }
}
}
