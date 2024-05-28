
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/murchant_cubit/murchant_cubit.dart';
import 'package:smallproject/murchant_cubit/murchant_cubit_state.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';
import 'package:smallproject/screens/murchant_Screen/register_murchant.dart';

class LoginMurchant extends StatefulWidget {
  const LoginMurchant({super.key});

  @override
  State<LoginMurchant> createState() => _LoginMurchantState();
}

class _LoginMurchantState extends State<LoginMurchant> {
  @override
  bool hidden = true;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantCubit, MerchantStates>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LayoutMurchant()));
          showSnackBarItem(context, "Login successfully", true);
        } else if (state is FailedToSigInState) {
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
                  Text(
                    "Signin",
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
                          BlocProvider.of<MerchantCubit>(context).signin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                      color: Colors.redAccent,
                      minWidth: double.infinity,
                      child: Text(
                        state is SignInLoadingState ? "Loading ..." : "Login",
                        style: const TextStyle(
                          fontSize: 17,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Signup()));
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
