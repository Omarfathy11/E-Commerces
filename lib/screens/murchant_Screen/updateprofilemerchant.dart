import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';
import 'package:smallproject/shared/style/colors.dart';

class UpdateProfileMerchant extends StatelessWidget {

   final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ImagePicker _imagePiker = ImagePicker();
   UpdateProfileMerchant({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
        create: (context) => MerchantlayoutCubitCubit()..getMerchantData(),
        child:
            BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(listener: (context, state) {
          if (state is UpDateMerchantDataSuccessState) {
                showSnackBarItem(context, "Data Updated Successfully", true);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateProfileMerchant()));
          }
          if (state is UpDateMerchantDatawithFailureState) {

          }
        }, builder: (context, state) {
          if (state is MerchantlayoutCubitInitial) {
            return const Center(
              child:
                  CupertinoActivityIndicator(radius: 40, color: Colors.amber),
            );
          } else if (state is GetMerchantDataSuccessState) {
            final merchant = state.merchant;

            nameController.text = merchant.merchant!.businessName!;
            phoneController.text = merchant.merchant!.phoneNumber!;
            emailController.text =  merchant.merchant!.email!;

            return Scaffold(
               
                body: 
                     Padding(
                       padding: const EdgeInsets.all(10),
                       child: ListView(children: [
                          
                        Row(
                          children: [
                            
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => const LayoutMurchant()));
                                },
                                icon: const Icon(Icons.arrow_back)),
                              const  Text('Update Profile',style: TextStyle(fontSize: 20),)
                          ],
                        ),
                          
                                         
                        
                        Center(
                            child: SizedBox(
                                height: 150,
                                width: 150,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child:  merchant.image == null
                                                    ? Image.asset(
                                                        'images/—Pngtree—no image vector illustration isolated_4979075.png')
                                                    : Image.network(
                                      merchant.image!,
                                    )))),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, right: 80),
                          child: IconButton(
                            onPressed: () async {
                              final image = await _imagePiker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                File Image = File(image.path);
                                BlocProvider.of<MerchantlayoutCubitCubit>(context)
                                    .updateMerchantData(
                                        phone_number: phoneController.text,
                                        business_name: nameController.text,
                                        email: emailController.text,
                                        merchantid: merchant.id!,
                                        profileImage: Image);
                              }
                            },
                            color: mainColor,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "User Name"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Phone"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, right: 80),
                          child: MaterialButton(
                            onPressed: () async {
                              if (nameController.text.isNotEmpty &&
                                  phoneController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty) {
                                BlocProvider.of<MerchantlayoutCubitCubit>(context)
                                    .updateMerchantData(
                                  phone_number: phoneController.text,
                                  business_name: nameController.text,
                                  email: emailController.text,
                                  merchantid: merchant.id!,
                                );
                              } else {
                                
                              }
                            },
                            color: mainColor,
                            textColor: Colors.white,
                            child: Text(state is UpDateMerchantDataLoadingState
                                ? "Loading..."
                                : "update data"),
                          ),
                        )
                                         ]),
                     ));
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CupertinoActivityIndicator(
                    radius: 40, color: Colors.orange),
              ),
            );
          }
        }));
  }

  
 
}