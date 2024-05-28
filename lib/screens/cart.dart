import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/cubit_cart/cubit/cart_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/layout/layout_screen.dart';
import 'package:smallproject/shared/style/colors.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return  BlocListener<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is GetOrderSuccessState) {
                        showSnackBarItem(context, "Order successfully", true);

            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LayoutScreen()));
          }
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                    padding: EdgeInsets.only(right: 250.sp),
                    child: Row(
                      children: [
                        const Text('Order'),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<LayoutCubit>(context)
                                .ordercustomer();
                          },
                          icon: const Icon(Icons.shopping_bag_rounded),
                        ),
                      ],
                    )),
              ],
            ),
            body: BlocProvider(
                create: (context) => CartCubit()
                  ..getCarts(),
                child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                  if (state is CartsInitial) {
                    return const Center(
                        child: CupertinoActivityIndicator(
                            radius: 40, color: Colors.amber));
                  } else if (state is GetcartSuccessState) {
                    final carts = state.carts;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final cart = carts[index];

                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Expanded(
                                  child: Image.network(
                                carts[index].product!.image!,
                                fit: BoxFit.fill,
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(children: [
                                  Text(carts[index].product!.name!),
                                  Text(carts[index].product!.price!.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 60.sp, bottom: 10.sp),
                                        child: GestureDetector(
                                          onTap: () {
                                            AwesomeDialog(
                                                btnOkColor: Colors.red,
                                                btnCancelColor: mainColor,
                                                context: context,
                                                dialogType: DialogType.question,
                                                animType: AnimType.rightSlide,
                                                desc:
                                                    "Do you want delete this item ?",
                                                descTextStyle: const TextStyle(
                                                    fontSize: 18),
                                                btnCancelText: "cancel",
                                                btnOkText: "delete",
                                                btnCancelOnPress: () {},
                                                btnOkOnPress: () async {
                                                  BlocProvider.of<CartCubit>(
                                                          context)
                                                      .deleteCarts(
                                                          productId:
                                                              carts[index]
                                                                  .id
                                                                  .toString());
                                                }).show();
                                          },
                                          child: const SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                              )
                            ]));
                      },
                    );
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(
                          radius: 40, color: Colors.amber),
                    );
                  }
                }))),
      
    );
  }
}
