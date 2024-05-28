import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

import 'package:http/http.dart%20';
import 'package:smallproject/cubit_favorites/favorites_state.dart';
import 'package:smallproject/models/cart_model.dart';
import 'package:smallproject/shared/constants/constants.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  
  FavoritesCubit() : super(FavoritesInitial());

  List<Product> favorites = [];
  Set<String> favoritesID = {};

  Future<void> getFavorites() async {
    emit(FavoritesLoadnigState());
    try {
      favorites.clear();

      Response response = await http.get(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/wishlists/my-wishlist/"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $token'
        },
      );
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      if (response.statusCode == 200) {
        for (var item in responseBody) {
          favorites.add(Product.fromJson(item['product']));
          favoritesID.add(item['product']['id'].toString());
        }

        print("favorites number is: ${favorites.length}");
        emit(FavoritesSuccessState(favorites));
      } else {
        emit(FavoritesErrorState());
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void addFavorites({required String productId}) async {
    Response response = await http.post(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/wishlists/my-wishlist/"),
        headers: {'Authorization': 'Bearer $token'},
        body: {"product_id": productId});
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
        favoritesID.add(productId);

                emit(FavoritesaddSuccess(favoritesID));

      
    } else {
      emit(FavoritesError('Failed to fetch favorites'));
    }
  }

  void deleteFavorite({required String productId}) async {
    emit(FavoritesLoadingDeleted());
    Response response = await http.delete(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/wishlists/my-wishlist/"),
        headers: {'Authorization': 'Bearer $token'},
        body: {"product_id": productId});

    if (response.statusCode == 200) {
        favoritesID.remove(productId);

      emit(FavoritesDeleted(favoritesID));
      await getFavorites();
    } else {
      emit(FavoritesError('Failed to delete favorite'));
    }
  }
}
