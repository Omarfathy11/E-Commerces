
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_cubit.dart';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_state.dart';
import 'package:smallproject/screens/login_screen.dart';

import '../layout/layout_screen.dart';

class RegisterScreen extends StatefulWidget {
 const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          showSnackBarItem(context, "Register successfully", true);
        } else if (state is FailedToRegisterState) {
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  const Text(
                    "create an account",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      controller: nameController, hintText: "User name"),
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
                          // Register
                          BlocProvider.of<AuthCubit>(context).register(
                              full_name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone_number: phoneController.text);
                        }
                      },
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      color: Colors.redAccent,
                      minWidth: double.infinity,
                      child: Text(
                        state is RegisterLoadingState
                            ? "Loading ..."
                            : "Register",
                        style:
                             TextStyle(fontSize: 17.sp, color: Colors.black),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 20.h,
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
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text('login ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 20.h,
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
