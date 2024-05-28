import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/murchant_cubit/murchant_cubit.dart';
import 'package:smallproject/screens/homepage.dart';
import 'package:smallproject/screens/murchant_Screen/details_productmerchant.dart';
import 'package:smallproject/screens/murchant_Screen/login_murchant.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';
import 'package:smallproject/screens/murchant_Screen/updateProduct.dart';
import 'package:smallproject/screens/splash_screen.dart';
import 'package:smallproject/screens/theme.dart';
import 'package:smallproject/shared/style/colors.dart';

class MerchantHomepage extends StatelessWidget {
  MerchantHomepage({super.key});
  final pagecotroller = PageController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MerchantlayoutCubitCubit>(context);

    return BlocProvider(

        create: (context) => MerchantlayoutCubitCubit()..getProductsData(),
        child: BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
            listener: (context, state) {
          if (state is GetProductsDetailssSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsMerchantProduct(
                  productModel: state.model,
                ),
              ),
            );
          }
           if (state is UpDateProductDataSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductUpdateScreen(productId: state.model.id!,
                  
                ),
              ),
            );
          }
          if(state is ProductsDeleted){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LayoutMurchant(
                  
                ),
              ),
              
            );
              showSnackBarItem(
                                                            context,
                                                            "product deleted",
                                                            true);
          }
         
        }, builder: (context, state) {

         if (state is GetProductsSuccessState) {
            final products = state.products;
            return Scaffold(
                endDrawer: Drawer(
                  child: BlocProvider(
                    create: (context) =>
                        MerchantlayoutCubitCubit()..getMerchantData(),
                    child: BlocConsumer<MerchantlayoutCubitCubit,
                        MerchantlayoutCubitState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is MerchantlayoutCubitInitial) {
                          return const Center(
                            child: CupertinoActivityIndicator(
                                radius: 40, color: Colors.amber),
                          );
                        } else if (state is GetMerchantDataSuccessState) {
                          final merchant = state.merchant;
                          return ListView(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: SizedBox(
                                            height: 140,
                                            width: 140,
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .horizontal(),
                                                child: merchant.image == null
                                                    ? Image.asset(
                                                        'images/—Pngtree—no image vector illustration isolated_4979075.png')
                                                    : Image.network(
                                                        merchant.image!,
                                                      )))),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    merchant.merchant!.businessName!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    merchant.merchant!.email!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 80),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Consumer<ThemeProvider>(
                                            builder:
                                                (context, provider, child) {
                                              return Column(
                                                children: [
                                                  SwitchListTile(
                                                    title: Text(
                                                      'Dark',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,
                                                    ),
                                                    value:
                                                        provider.currentTheme ==
                                                            'dark',
                                                    onChanged: (bool value) {
                                                      provider.changeTheme(value
                                                          ? 'dark'
                                                          : 'system');
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30, left: 5),
                                                    child: ListTile(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    MerchantCubit>(
                                                                context)
                                                            .logout();
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SplasScreen(),
                                                        ));
                                                        showSnackBarItem(
                                                            context,
                                                            "Logout successfully",
                                                            true);
                                                      },
                                                      leading: const Icon(
                                                        Icons.logout,
                                                      ),
                                                      title: const Text(
                                                        'Logout',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CupertinoActivityIndicator(
                                radius: 40, color: Colors.amber),
                          );
                        }
                      },
                    ),
                  ),
                ),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text(
                    "Products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    products[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                           children: [
                            Container(
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<MerchantlayoutCubitCubit>(
                                            context)
                                        .getproductDetails(
                                            productid:
                                                cubit.products[index].id!);
                                  },
                               child: Image.network(
                                    products[index].image!,
                                    height: 100.h,
                                    width: 115.w,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    BlocProvider.of<MerchantlayoutCubitCubit>(
                                            context)
                                        .getproductDetails(
                                            productid:
                                                cubit.products[index].id!);
                                  },
                                  child: Text(products[index].name!)),
                              Text(products[index].price!),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        AwesomeDialog(
                                          btnOkColor: Colors.red,
                                          btnCancelColor: mainColor,
                                          context: context,
                                          dialogType: DialogType.question,
                                          animType: AnimType.rightSlide,
                                          desc:
                                              "Do you want to delete this item?",
                                          descTextStyle:
                                              const TextStyle(fontSize: 18),
                                          btnCancelText: "cancel",
                                          btnOkText: "delete",
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () async {
                                            BlocProvider.of<
                                                        MerchantlayoutCubitCubit>(
                                                    context)
                                                .deleteProduct(
                                              productId: products[index].id!,
                                            );
                                          },
                                        ).show();
                                      },
                                      textColor: Colors.white,
                                      color: Colors.red,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(),
                                      ),
                                      child: const Text("Remove"),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                         BlocProvider.of<MerchantlayoutCubitCubit>(
                                            context)
                                        .editProductData(
                                            productid:
                                                cubit.products[index].id!);
                                      },
                                      textColor: Colors.black,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(),
                                      ),
                                      child: const Text("edit"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ));
          } else {
 return const Center(
                      child: CupertinoActivityIndicator(
                          radius: 40, color: Colors.amber),
                    );          }
        }));
  }
}

void showSnackBarItem(
    BuildContext context, String message, bool forSuccessOrFailure) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
  ));
}
