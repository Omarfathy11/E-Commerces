import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int primaryColor = 0xffff7e54 ;


ThemeData lightTheme = ThemeData(
  textTheme: const TextTheme(
    bodyMedium: TextStyle (
        fontFamily: 'jannah',
        color: Colors.black
    ) ,
  ),
  primaryColor: Color(primaryColor),
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.white ,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.deepOrange
    ),
    elevation: 0,
    backgroundColor:  Colors.white ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  Colors.white ,
      statusBarIconBrightness: Brightness.dark ,


    ) ,
  ) ,
);