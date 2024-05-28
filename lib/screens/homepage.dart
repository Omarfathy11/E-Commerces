import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/cubit_cart/cubit/cart_cubit.dart';
import 'package:smallproject/cubit_favorites/favorites_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/models/products_model.dart';
import 'package:smallproject/screens/details_screen.dart';
import 'package:smallproject/shared/constants/constants.dart';
import 'package:smallproject/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  Homepage({
    Key? key,
  }) : super(key: key);

  final pagecotroller = PageController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is GetProductDetailssSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                productModel: state.model,
              ),
            ),
          );
        }if(state is ProductsDeleted){
             Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (
              Homepage()),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  onChanged: (input) {
                    cubit.filterProducts(input: input);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    suffixIcon: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                      child: const Icon(
                        Icons.clear,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Image.asset(
                    "images/Frame 560.png",
                  ),
                ),
                 SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pagecotroller,
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: const SlideEffect(
                      spacing: 8.0,
                      radius: 25,
                      dotWidth: 24.0,
                      dotHeight: 16.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: secondColor,
                    ),
                  ),
                ),
                 SizedBox(
                  height: 15.h,
                ),

              /* const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      "categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: 5.h,
                ),
                cubit.categories.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : SizedBox(
                        height: 50.h,
                        width: double.infinity.w,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.categories.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: ((context, index) {
                            return const SizedBox(
                              width: 15,
                            );
                          }),
                          itemBuilder: (context, index) {
                            return Text(
                              cubit.categories[index].name!,
                              style:  TextStyle(fontSize: 20.sp),
                            );
                          },
                        ),
                      ),
                      */
                Row(
                  children: [
                    Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: 10.h,
                ),
                cubit.products.isEmpty
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : GridView.builder(
                        itemCount: cubit.filteredProducts.isEmpty
                            ? cubit.products.length
                            : cubit.filteredProducts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.none,
                        gridDelegate:
                             const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              cubit.getproductDetails(
                                  productid: cubit.products[index].id!);
                            },
                            child: _productItem(
                              model: cubit.filteredProducts.isEmpty
                                  ? cubit.products[index]
                                  : cubit.filteredProducts[index],
                              favorite: FavoritesCubit()..favorites,
                              cart: CartCubit()..carts,
                              context: context,
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _productItem(
    {required BuildContext context,
    required ProductModel model,
    required FavoritesCubit favorite,
    required CartCubit cart}) {
  return Stack(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: model.image == null ? Image.asset('images/—Pngtree—no image vector illustration isolated_4979075.png',  fit: BoxFit.fill,) :Image.network(
              model.image!,
              fit: BoxFit.fill,
            )),
            Text(
              model.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${model.name!} \$",
              style: const TextStyle(fontSize: 13),
            ),
            MaterialButton(
              onPressed: () {
                favorite.addFavorites(productId: model.id.toString());
                AwesomeDialog(
                  btnOkColor: Colors.red,
                  btnCancelColor: mainColor,
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  desc: "add to favorits successfully",
                  descTextStyle: const TextStyle(fontSize: 18),
                ).show();
              },
              textColor: Colors.white,
              color: mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45)),
                                child: const Text("add to favorites"),

            )
          ],
        ),
      ),
      CircleAvatar(
        backgroundColor: Colors.grey,
        child: GestureDetector(
          onTap: () {
            cart.addCart(productId: model.id.toString());
            AwesomeDialog(
              btnOkColor: Colors.red,
              btnCancelColor: mainColor,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              desc: "add to Cart successfully",
              descTextStyle: const TextStyle(fontSize: 18),
            ).show();
          },
          child: Icon(Icons.shopping_cart,
              color: cart.carstId.contains(model.id.toString())
                  ? Colors.red
                  : Colors.black),
        ),
      )
    ],
  );
}


