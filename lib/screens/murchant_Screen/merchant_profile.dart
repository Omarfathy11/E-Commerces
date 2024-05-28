
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/screens/murchant_Screen/update_paswwordmerchant.dart';
import 'package:smallproject/screens/murchant_Screen/updateprofilemerchant.dart';

import '../../shared/style/colors.dart';

class MerchantProfile extends StatelessWidget {
  const MerchantProfile({super.key});

 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MerchantlayoutCubitCubit()..getMerchantData(),
      child: BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
        listener: (context, state) {
            

        },
        builder: (context, state) {
          if (state is MerchantlayoutCubitInitial) {
            return const Center(
              child:
                  CupertinoActivityIndicator(radius: 40, color: Colors.amber),
            );
          } else if (state is GetMerchantDataSuccessState) {
            final merchant = state.merchant;
            print(merchant.merchant!.email!);

            return Scaffold(
              body:Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: ListView(
                        children: [
                          Center(
                              child: SizedBox(
                                  height: 180,
                                  width: 180,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child:   merchant.image== null? Image.asset('images/—Pngtree—no image vector illustration isolated_4979075.png') :Image.network(
                                        merchant.image!,
                                      )))),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            ' Profile',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: Text(merchant.merchant!.businessName!),
                                prefixIcon: const Icon(LineAwesomeIcons.user)),
                          ),
                          //      Text(cubit.userModel!.full_name!),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: Text(merchant.merchant!.email!),
                                prefixIcon:
                                     Icon(LineAwesomeIcons.envelope)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: Text(merchant.merchant!.phoneNumber!),
                                prefixIcon:  Icon(LineAwesomeIcons.phone_alt_solid)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 80, right: 80),
                            child: MaterialButton(
                              onPressed: () {
                              Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProfileMerchant()));
                              },
                              color: mainColor,
                              textColor: Colors.white,
                              child: const Text(
                                'Edit Your profile',
                                style: TextStyle(fontSize: 17),
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
                                Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>  UpdatePasswordMerchant()));
                              },
                              color: mainColor,
                              textColor: Colors.white,
                              child: const Text(
                                'Update Password',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  
            );
          }else {
              return const Center(
                child: CupertinoActivityIndicator(radius: 40, color: Colors.amber),
              );
            }
        },
      ),
    );
  }
}
