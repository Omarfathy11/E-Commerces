
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/screens/change_password/change_passwordScreen.dart';
import 'package:smallproject/screens/updateUserScreen/updateuserscreen.dart';
import 'package:smallproject/shared/style/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getUserData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is UpDateUserDataSuccessState) {
            showSnackBarItem(context, "Data Updated Successfully", true);
          }
        },
        builder: (context, state) {
          if (state is LayoutInitialState) {
            return const Center(
              child:
                  CupertinoActivityIndicator(radius: 40, color: Colors.amber),
            );
          } else if (state is GetUserDataSuccessState) {
            final usermodel = state.usermodel;

            return Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(9.0),
              child: ListView(
                children: [
                  Center(
                      child: SizedBox(
                          height: 180.h,
                          width: 180.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: usermodel.image == null
                                  ? Image.asset(
                                      'images/—Pngtree—no image vector illustration isolated_4979075.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      usermodel.image!,
                                    )))),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Text(
                    ' Profile',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text(usermodel.customer!.fullName!),
                        prefixIcon: const Icon(LineAwesomeIcons.user)),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: usermodel.customer!.address == null
                            ? const Text('No address')
                            : Text(usermodel.customer!.address!),
                        prefixIcon: const Icon(LineAwesomeIcons.address_book)),
                  ),
                  //      Text(cubit.userModel!.full_name!),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text(usermodel.customer!.email!),
                        prefixIcon:  const Icon(LineAwesomeIcons.envelope)),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        label: Text(usermodel.customer!.phoneNumber!),
                        prefixIcon: const Icon(LineAwesomeIcons.phone_alt_solid)),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateUserDataScreen()));
                      },
                      color: mainColor,
                      textColor: Colors.white,
                      child: Text(
                        'Edit Your profile',
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword()));
                      },
                      color: mainColor,
                      textColor: Colors.white,
                      child: Text(
                        'Update Password',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ));
          } else {
            return const Center(
              child:
                  CupertinoActivityIndicator(radius: 40, color: Colors.amber),
            );
          }
        },
      ),
    );
  }
}
