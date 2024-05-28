
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/layout/layout_screen.dart';
import 'package:smallproject/murchant_cubit/murchant_cubit_state.dart';
import 'package:smallproject/screens/murchant_Screen/login_murchant.dart';

import '../../murchant_cubit/murchant_cubit.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final addressController = TextEditingController();

  final businessnameController = TextEditingController();

  final paymentInformationController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantCubit, MerchantStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginMurchant()));
            showSnackBarItem(context, "Register successfully", true);
          } else if (state is FailedToSignUpState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0.sp),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    Center(
                        child: SizedBox(
                            height: 300.h,
                            width: 300.w,
                            child: Image.asset(
                                "images/Ecommerce campaign-rafiki.png"))),
                     Text(
                      "Sign up as A merchant",
                      style:
                          TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                     Text(
                      "Enter your details below",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    _textFielditem(
                        controller: businessnameController,
                        hintText: "business name"),
                     SizedBox(
                      height: 20.h,
                    ),
                    _textFielditem(
                        controller: emailController, hintText: "email"),
                     SizedBox(
                      height: 20.h,
                    ),
                    _textFielditem(
                        controller: phoneController, hintText: "phone"),
                     SizedBox(
                      height: 20.h,
                    ),
                    _textFielditem(
                        controller: addressController, hintText: "address"),
                     SizedBox(
                      height: 20.h,
                    ),
                    _textFielditem(
                        controller: paymentInformationController,
                        hintText: "payment information"),
                    
                     SizedBox(
                      height: 20.h,
                    ),
                    _textFielditem(
                        isScure: true,
                        controller: passwordController,
                        hintText: "Password"),
                 
                     SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            BlocProvider.of<MerchantCubit>(context).signup(
                              businessName: businessnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phoneNumber: phoneController.text,
                              address: addressController.text,
                              paymentInformation:
                                  paymentInformationController.text,
                            );
                          }
                        },
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        color: Colors.redAccent,
                        minWidth: double.infinity,
                        child: Text(
                          state is SignUpLoadingState
                              ? "Loading ..."
                              : "Register",
                          style:  TextStyle(
                              fontSize: 17.sp, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? ',
                            ),
                         SizedBox(
                          width: 4.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginMurchant()));
                          },
                          child: const Text('login ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}

Widget _textFielditem(
    {bool? isScure,
    required TextEditingController controller,
    required String hintText}) {
  return TextFormField(
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return "$hintText name must not be empyt";
      } else {
        return null;
      }
    },
    obscureText: isScure ?? false,
    decoration:
        InputDecoration(hintText: hintText, border: const OutlineInputBorder()),
  );
}
