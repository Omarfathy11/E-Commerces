

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/layout/layout_screen.dart';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_cubit.dart';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_state.dart';
import 'package:smallproject/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidden = true;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LayoutScreen()));
          showSnackBarItem(context, "Login successfully", true);
        } else if (state is FailedToLoginState) {
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
            padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
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
                    "Login",
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (input) {
                      if (emailController.text.isEmpty) {
                        return "email name must not be empyt";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: "email", border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (input) {
                      if (passwordController.text.isEmpty) {
                        return "password name must not be empyt";
                      } else {
                        return null;
                      }
                    },
                    obscureText: hidden ?? false,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidden = !hidden;
                              });
                            },
                            icon: hidden
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.red,
                                  )),
                        hintText: "password",
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          // Register
                          BlocProvider.of<AuthCubit>(context).login(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                      color: Colors.redAccent,
                      minWidth: double.infinity,
                      child: Text(
                        state is LoginLoadingState ? "Loading ..." : "Login",
                        style: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do not have account ? ', style: TextStyle()),
                      SizedBox(
                        width: 4.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()));
                        },
                        child: const Text('Signup ',
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
