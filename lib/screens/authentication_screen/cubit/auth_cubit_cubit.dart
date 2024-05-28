import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_state.dart';
import 'package:smallproject/shared/constants/constants.dart';
import 'package:smallproject/shared/network/local_network.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  void register(
      {required String email,
      required String full_name,
      required String phone_number,
      required String password}) async {
        emit(RegisterLoadingState());
      
        
         Response response = await http.post(
      Uri.parse(
          'https://django-e-commerce-production.up.railway.app/customers/signup/'),
      body: {
        'full_name': full_name,
        'email': email, 
        'password': password,
        'phone_number': phone_number,
      },
    );

    if (response.statusCode == 201) {


      emit(RegisterSuccessState());
      }
      else {
        FailedToRegisterState(message: 'faild to register');
        debugPrint('faild to register');
      
      }
   
    
  }

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());

   try{
     Response response = await http.post(
      // request => url = base url + method url
      Uri.parse(
          'https://django-e-commerce-production.up.railway.app/customers/login/'),
      body: {'email_or_phone': email, 'password': password},
    );
          var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(responseData);

      var accessToken = responseData['access'];

      await CacheNetwork.insertToCache(key: 'accesstoken', value: accessToken);
      token = await CacheNetwork.getCacheData(key: "accesstoken");

      emit(LoginSuccessState());
   }else{
    emit(FailedToLoginState(message:  responseData['error']));
   }
    }catch(e){
        emit(FailedToLoginState(message: e.toString()));
    }
  }

  void logout() async {
    Response response = await http.post(
        Uri.parse(
            'https://django-e-commerce-production.up.railway.app/customers/logout/'),
        headers: {
          'Authorization': 'Bearer $token',
        });
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 205) {
          await CacheNetwork.deleteCacheItem(key: 'accesstoken');

      emit(LogoutSuccessState());
    } else {
      emit(FailedToLogoutState());
    }
  }
}
