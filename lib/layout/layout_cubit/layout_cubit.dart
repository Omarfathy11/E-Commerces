import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/layout/user_model.dart';
import 'package:smallproject/models/categories.dart';
import 'package:smallproject/models/products_model.dart';
import 'package:smallproject/screens/cart.dart';
import 'package:smallproject/screens/categories.dart';
import 'package:smallproject/screens/favoriets.dart';
import 'package:smallproject/screens/homepage.dart';
import 'package:smallproject/screens/profile_screen/profile_screen.dart';
import 'package:smallproject/shared/constants/constants.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  int buttomNavindex = 0;
  List<Widget> layoutScreens = [
    Homepage(),
    const CategoriesScreen(),
    FavorietsScreen(),
    const CartScreen(
    ),
    const ProfileScreen(),
   
  ]; // لازم بالترتيب

  void changeButtomNavIndex({required int index}) {
    buttomNavindex = index;
    // Emit state
    emit(ChangeButtomNavIndexState());
  }

  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());

    try {
      Response response = await http.get(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/customers/profiles/"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $token',
        },
      );
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(responseBody[0]);

        emit(GetUserDataSuccessState(userModel!));
      }
    } catch (e) {
    //  print("Error fetching user data: $e");
    }
  }


  List<CategoriesModel> categories = [];
  void getCategoriesData() async {
    Response response = await http.get(Uri.parse(
        'https://django-e-commerce-production.up.railway.app/api/categories/'));
    final responseBody = jsonDecode(response.body);
    // print("response is  $responseBody");

    if (response.statusCode == 200) {
      for (var item in responseBody['categories']) {
        categories.add(CategoriesModel.fromJson(data: item));
      }
      emit(GetCategotiesSuccessState());
    } else {
      emit(FailedToGetCategotiesState());
    }
  }

  List<ProductModel> products = [];
  void getProductsData() async {
    emit(GetProductsLoadingState());
    Response response = await http.get(
      Uri.parse(
          'https://django-e-commerce-production.up.railway.app/api/products/'),
    );
    var responseBody = jsonDecode(response.body);
    // print(" products data id : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody) {
        products.add(ProductModel.fromJson(item));
        emit(GetProductsSuccessState());
      }
    } else {
      emit(FailedToGetProductsState());
    }
  }

  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input}) {
    filteredProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterproductSuccessState());
  }

  List<CategoriesModel> filteredCategories = [];
  void filterCategories({required String input}) {
    filteredCategories = categories
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FiltercategoriesSuccessState());
  }

  ProductModel? model;
  void getproductDetails({required int productid}) async {
    emit(GetProductsDetailsLoadingState());

    Response response = await http.get(Uri.parse(
        'https://django-e-commerce-production.up.railway.app/api/products/$productid'));
    var responseBody = await jsonDecode(response.body);
      print(" product details : $responseBody");
    if (response.statusCode == 200) {
      model = ProductModel.fromJson(
          
              responseBody); // عشان الداتا محطوطة في ماب فلازم اعملها fromjson
      emit(GetProductDetailssSuccessState(model!));
    } else {
      emit(FailedToGetProductsDetailsState());
    }
  }
void updateUserData({
  int? userid,
  String? full_name,
  String? phone_number,
  String? email,
  String?address,
  File? profileImage,
}) async {
  emit(UpDateUserDataLoadingState());

  try {
    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(
        'https://django-e-commerce-production.up.railway.app/customers/profiles/$userid/',
      ),
    );

    request.headers['Authorization'] = 'Bearer $token';

    if (profileImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          profileImage.path,
        ),
      );
    }

    request.fields['full_name'] = full_name!;
    request.fields['email'] = email!;
    request.fields['phone_number'] = phone_number!;
    request.fields['address'] = address!;

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    // print('body: $responseBody');

    if (response.statusCode == 200) {
      await getUserData();
      emit(UpDateUserDataSuccessState());
    } else {
      emit(UpDateUserDatawithFailureState(responseBody.toString()));
    }
  } catch (e) {
    emit(UpDateUserDatawithFailureState(e.toString()));
    print('$e');
  }
}

 void changePassword({required String currentPassword, required String newPassword})async{
  emit(ChangepasswordLoadingState());
  Response response = await http.post(Uri.parse('https://django-e-commerce-production.up.railway.app/customers/password-update/'),
  headers: {
      'Authorization': 'Bearer $token',
  },
  body: {
     "old_password": currentPassword,
     "new_password": newPassword,
  }
  );
  var responseBody = jsonDecode(response.body);
    if(response.statusCode == 200){
        emit(ChangepasswordSuccessState());
     } else{
        emit(ChangepswwordwithFailureState(responseBody['error']));
      }

   
 }
 void ordercustomer()async{
  Response response = await http.post(Uri.parse('https://django-e-commerce-production.up.railway.app/orders/customer-orders/'),
  headers: {
              'Authorization': 'Bearer $token',

  });
  if(response.statusCode == 201){
    emit(GetOrderSuccessState());
  }else{
    emit(FailedToGetOrderState());
  }
 } 
  
}
