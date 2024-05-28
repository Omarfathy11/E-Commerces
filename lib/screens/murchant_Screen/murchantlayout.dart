
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/shared/style/colors.dart';

class LayoutMurchant extends StatelessWidget {
  const LayoutMurchant({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit =
        BlocProvider.of<MerchantlayoutCubitCubit>(context); // عشام اوصل  للداتا
    return BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            /*  appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Image.asset(
                'images/Frame 928.png',
                height: 150,
                width: 150,
              ),
            ),*/
            bottomNavigationBar: BottomNavigationBar(
                elevation: 0,
                selectedItemColor: mainColor,
                unselectedItemColor: Colors.grey,
                currentIndex: cubit.buttomNavindex, // بيبقي واقف علي اول ايتم
                onTap: ((index) {
                  cubit.changeButtomNavIndex(index: index);
                }),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_shopping_cart_sharp),
                      label: 'addProduct'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.outbox_rounded), label: 'orders'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ]),
            body: cubit.layoutmerchantScreens[cubit.buttomNavindex],
          );
        });
  }
}

void showSnackBarItem(
    BuildContext context, String message, bool forSuccessOrFailure) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
  ));
}
