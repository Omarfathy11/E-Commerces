import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:smallproject/models/merchantproducts_model.dart';
import 'package:smallproject/models/orders_model.dart';
import 'package:smallproject/models/updateproduct.dart';
import 'package:smallproject/murchant_cubit/murchant_model.dart';
import 'package:smallproject/screens/murchant_Screen/addproduct_screen.dart';
import 'package:smallproject/screens/murchant_Screen/homepage_merchant.dart';
import 'package:smallproject/screens/murchant_Screen/merchant_profile.dart';
import 'package:smallproject/screens/murchant_Screen/orders_screen.dart';

import '../shared/constants/constants.dart';

part 'merchantlayout_cubit_state.dart';

class MerchantlayoutCubitCubit extends Cubit<MerchantlayoutCubitState> {
  MerchantlayoutCubitCubit() : super(MerchantlayoutCubitInitial());
      Set<String> ProductsID = {};

  int buttomNavindex = 0;
  List<Widget> layoutmerchantScreens = [
    MerchantHomepage(),
    AddProduct(),
    OrdersScreen(),
    const MerchantProfile(),
  ];
  void changeButtomNavIndex({required int index}) {
    buttomNavindex = index;
    // Emit state
    emit(ChangeButtomNavIndexState());
  } // لازم بالترتيب

  MerchantModel? merchant;
  Future<void> getMerchantData() async {
    emit(GetMerchantDataLoadingState());

    try {
      Response response = await http.get(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/merchants/profiles/"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization': 'Bearer $merchanttoken',
        },
      );
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        merchant = MerchantModel.fromJson(responseBody[0]);

        emit(GetMerchantDataSuccessState(merchant!));
      }
    } catch (e) {
      //  print("Error fetching user data: $e");
    }
  }

  List<merchantproduct> products = [];
   Future<void> getProductsData() async {
    emit(GetProductsLoadingState());
    products.clear();
    Response response = await http.get(
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/api/products-for-merchants/'),
        headers: {
          'Authorization': 'Bearer $merchanttoken',
        });
    var responseBody = jsonDecode(response.body);
    // print(" products data id : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody) {
        products.add(merchantproduct.fromJson(item));
        emit(GetProductsSuccessState(products));
      }
    } else {
      emit(FailedToGetProductsState());
    }
  }

  merchantproduct? model;
  Future <void> getproductDetails({required int productid}) async {
    emit(GetProductsDetailsLoadingState());

    Response response = await http.get(
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/api/products-for-merchants/$productid'),
        headers: {
          'Authorization': 'Bearer $merchanttoken',
        });
    var responseBody = await jsonDecode(response.body);
   // print(" product details : $responseBody");
    if (response.statusCode == 200) {
      model = merchantproduct.fromJson(responseBody); // عشان الداتا محطوطة في ماب فلازم اعملها fromjson
      emit(GetProductsDetailssSuccessState(model!));
    } else {
      emit(FailedToGetProductsDetailsState());
    }
  }

  

  void addProduct(
      {String? name,
      String? description,
      String? price,
      String? quantity,
      File? image}) async {
    emit(addProductsLoadingState());
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://django-e-commerce-production.up.railway.app/api/products-for-merchants/',
        ),
      );

      request.headers['Authorization'] = 'Bearer $merchanttoken';

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
          ),
        );

        request.fields['name'] = name!;
        request.fields['description'] = description!;
        request.fields['price'] = price!;
        request.fields['quantity'] = quantity!;
      }
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        emit(addProductsSuccessState());
      } else {
        emit(FailedToaddProductsState(message: 'faild to add product'));
      }
    } catch (e) {
      emit(FailedToaddProductsState(
        message: e.toString(),
      ));
    }
  }

  void updateMerchantData({
    int? merchantid,
    String? business_name,
    String? phone_number,
    String? email,
    File? profileImage,
  }) async {
    emit(UpDateMerchantDataLoadingState());

    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse(
          'https://django-e-commerce-production.up.railway.app/merchants/profiles/$merchantid/',
        ),
      );

      request.headers['Authorization'] = 'Bearer $merchanttoken';

      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            profileImage.path,
          ),
        );
      }

      request.fields['business_name'] = business_name!;
      request.fields['email'] = email!;
      request.fields['phone_number'] = phone_number!;

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('body: $responseBody');

      if (response.statusCode == 200) {
        await getMerchantData();
        emit(UpDateMerchantDataSuccessState());
      } else {
        emit(UpDateMerchantDatawithFailureState(responseBody.toString()));
      }
    } catch (e) {
      emit(UpDateMerchantDatawithFailureState(e.toString()));
      print('$e');
    }
  }

  void changePassword(
      {required String currentPassword, required String newPassword}) async {
    emit(ChangepasswordLoadingState());
    Response response = await http.post(
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/merchants/password-update/'),
        headers: {
          'Authorization': 'Bearer $merchanttoken',
        },
        body: {
          "old_password": currentPassword,
          "new_password": newPassword,
        });
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      emit(ChangepasswordSuccessState());
    } else {
      emit(ChangepswwordwithFailureState(responseBody['error']));
    }
  }

  void deleteProduct({required int productId}) async {
    emit(ProductsLoadingDeleted());
    Response response = await http.delete(
        Uri.parse(
            "https://django-e-commerce-production.up.railway.app/api/products-for-merchants/$productId/"),
        headers: {'Authorization': 'Bearer $merchanttoken'},
        );

    if (response.statusCode == 204) {

      emit(ProductsDeleted());
      await getProductsData();
    } else {
      emit(FailedToDeletedProductState('Failed to delete favorite'));
    }
  }
    void editProductData({
  int? productid,
  String? name,
  String? description,
  String? price,
  File? image,
}) async {
  emit(UpDateProductDataLoadingState());

  try {
    // Fetch the existing product data
    Response response = await http.get(
      Uri.parse('https://django-e-commerce-production.up.railway.app/api/products-for-merchants/$productid/'),
      headers: {
        'Authorization': 'Bearer $merchanttoken',
      },
    );

    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Create a new product model with the existing data
      model = merchantproduct.fromJson(responseBody);

      // Update the product data with the new values
      model!.name = name ?? model!.name;
      model!.description = description ?? model!.description;
      model!.price = price ?? model!.price;
      

      // Convert the image to a base64-encoded string
      if (image != null) {
        Uint8List imageBytes = await image.readAsBytes();
        model!.image = base64Encode(imageBytes);
      } else {
        model!.image = null;
      }

      // Make a PATCH request to update the product on the server
      Map<String, dynamic> requestBody = model!.toJson();
      if (image != null) {
        requestBody['image'] = model!.image;
      }

      Response updateResponse = await http.patch(
        Uri.parse('https://django-e-commerce-production.up.railway.app/api/products-for-merchants/$productid/'),
        headers: {
          'Authorization': 'Bearer $merchanttoken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (updateResponse.statusCode == 200) {
        // If the update was successful, emit a success state
        emit(UpDateProductDataSuccessState(model!));
        await getProductsData();
      } else {
        // If the update failed, emit a failure state
        emit(UpDateProductDatawithFailureState(updateResponse.body));
      }
    } else {
      // If the initial fetch failed, emit a failure state
      emit(UpDateProductDatawithFailureState(responseBody.toString()));
    }
  } catch (e) {
    // If there was an exception, emit a failure state
    emit(UpDateProductDatawithFailureState(e.toString()));
    print('$e');
  }
}



  
  List<Order> orders = [];
   void getOrders() async {
    emit(GetOrdersLoadingState());
    orders.clear();
    Response response = await http.get(
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/orders/merchant-orders/'),
        headers: {
          'Authorization': 'Bearer $merchanttoken',
        });
    var responseBody = jsonDecode(response.body);
     print(" orders data id : $responseBody");
    if (response.statusCode == 200) {
      for (var item in responseBody) {
        orders.add(Order.fromJson(item));
        emit(GetOrdersSuccessState(orders));
      }
    } else {
      emit(FailedToGetOrdersState());
    }
  }
}
