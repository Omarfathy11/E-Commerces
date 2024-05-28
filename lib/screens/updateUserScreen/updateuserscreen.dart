import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/layout/layout_screen.dart';
import 'package:smallproject/shared/style/colors.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final ImagePicker _imagePiker = ImagePicker();

  UpdateUserDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LayoutCubit()..getUserData(),
        child:
            BlocConsumer<LayoutCubit, LayoutStates>(listener: (context, state) {
          if (state is UpDateUserDataSuccessState) {
            showSnackBarItem(context, "Data Updated Successfully", true);
            Navigator.pop(context);
          }
          if (state is UpDateUserDatawithFailureState) {
            showSnackBarItem(context, state.error!, false);
          }
        }, builder: (context, state) {
          if (state is LayoutInitialState) {
            return const Center(
              child:
                  CupertinoActivityIndicator(radius: 40, color: Colors.amber),
            );
          } else if (state is GetUserDataSuccessState) {
            final usermodel = state.usermodel;

            nameController.text = usermodel.customer!.fullName!;
            phoneController.text = usermodel.customer!.phoneNumber!;
            emailController.text = usermodel.customer!.email!;
            addressController.text = usermodel.customer!.address!;

            return Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LayoutScreen()));
                        },
                        icon: const Icon(Icons.arrow_back)),
                     Text(
                      'Update Profile',
                      style: TextStyle(fontSize: 20.sp),
                    )
                  ],
                ),
                Center(
                    child: SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              usermodel.image!,
                            )))),
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: IconButton(
                    onPressed: () async {
                      final pickedImage = await _imagePiker.pickImage(
                          source: ImageSource.gallery);
                      if (pickedImage != null) {
                        File profileImage = File(pickedImage.path);
                        BlocProvider.of<LayoutCubit>(context).updateUserData(
                            phone_number: phoneController.text,
                            full_name: nameController.text,
                            email: emailController.text,
                            userid: usermodel.id!,
                            address: addressController.text,
                            profileImage: profileImage);
                      }
                    },
                    color: mainColor,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "User Name"),
                ),
                 SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                ),
                 SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Phone"),
                ),
                 SizedBox(
                  height: 15.h,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "address"),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, right: 80),
                  child: MaterialButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          emailController.text.isNotEmpty&& addressController.text.isNotEmpty) {
                        BlocProvider.of<LayoutCubit>(context).updateUserData(
                          phone_number: phoneController.text,
                          full_name: nameController.text,
                          email: emailController.text,
                          address: addressController.text,
                          userid: usermodel.id!,
                        );
                      } else {
                        showSnackBarItem(
                            context, 'Please, Enter all Data !!', false);
                      }
                    },
                    color: mainColor,
                    textColor: Colors.white,
                    child: Text(state is UpDateUserDataLoadingState
                        ? "Loading..."
                        : "update data"),
                  ),
                )
              ]),
            ));
          } else {
            return Container(
              color: Colors.white,
              child:  Center(
                child: CupertinoActivityIndicator(
                    radius: 40.sp, color: Colors.orange),
              ),
            );
          }
        }));
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
    ));
  }
}
