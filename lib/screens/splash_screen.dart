
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/screens/login_screen.dart';

import 'murchant_Screen/login_murchant.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Image.asset(
            "images/unsplash_ow1mML1sOi0.png",
            fit: BoxFit.cover,
          )),
          Padding(
            padding: const EdgeInsets.only(right: 54),
            child: Align(
              alignment: Alignment.centerRight, // change .2 based on your need
              child: MaterialButton(color: Colors.red,onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()));
             }, child: const Text('sign as User',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),)
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 100.sp, right: 30.sp),
            child: Align(
              alignment: Alignment.centerRight, // change .2 based on your need
              child: 
                 MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginMurchant()));
                  },
                  child: 
                   const Text('sign as merchant',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
