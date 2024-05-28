import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:smallproject/murchant_cubit/murchant_cubit_state.dart';
import 'package:smallproject/shared/constants/constants.dart';
import 'package:smallproject/shared/network/local_network.dart';


class MerchantCubit extends Cubit<MerchantStates> {
  MerchantCubit() : super(MerchantInitialState());

  
  //  void signup({
  //   required String email,
  //   required String businessName,
  //   required String phoneNumber,
  //   required String password, 
  //   required String address,
  //   required String paymentInformation,
  // }) async {  
  //   emit(SignUpLoadingState());
    
  //     Response response = await http.post(
  //       Uri.parse(
  //           'https://django-e-commerce-production.up.railway.app/merchants/signup/'),
  //       body: {
  //         'email': email,
  //         'phone_number': phoneNumber,
  //         'address': address,
  //         'payment_information': paymentInformation,
  //         'password': password,
  //         'business_name': businessName,


  //       },
  //     );
    
              
  //   if (response.statusCode == 201) {


  //     emit(SignUpSuccessState());
  //   } else {
  //     FailedToSignUpState(message: 'faild to register');
  //     debugPrint('faild to register');
  //   }
    
  // }

  void signup({
  required String email,
  required String businessName,
  required String phoneNumber,
  required String password,
  required String address,
  required String paymentInformation,
}) async {
  emit(SignUpLoadingState());

  try {
    final Uri uri = Uri.parse(
        'https://django-e-commerce-production.up.railway.app/merchants/signup/');
    final Map<String, String> body = {
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'payment_information': paymentInformation,
      'password': password,
      'business_name': businessName,
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Ensure appropriate content type
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      emit(SignUpSuccessState());
    } else {
      emit(FailedToSignUpState(message: 'failed to register'));
      debugPrint('failed to register');
    }
  } catch (e) {
    emit(FailedToSignUpState(message: 'An error occurred: $e'));
    debugPrint('An error occurred: $e');
  }
}


  void signin({required String email, required String password}) async {
    emit(SignInLoadingState());

    try {
      Response response = await http.post(
        // request => url = base url + method url
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/merchants/login/'),
        body: {'email_or_phone': email, 'password': password},
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print(responseData);

        var token = responseData['access'];

        await CacheNetwork.insertToCache(
            key: 'token', value: token);
        merchanttoken = await CacheNetwork.getCacheData(key: "token");

        emit(SignInSuccessState());
      } else {
        emit(FailedToSigInState(
            message: "Faild to Login, please check your Email and password"));
      }
    } catch (e) {
      emit(FailedToSigInState(message: e.toString()));
    }
  }

  
  void logout() async {
    Response response = await http.post(
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/merchants/logout/'),
        headers: {
          'Authorization': 'Bearer $merchanttoken',
        });
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 205) {
          await CacheNetwork.deleteCacheItem(key: 'token');

      emit(LogoutSuccessState());
    } else {
      emit(FailedToLogoutState());
    }
  }


}