
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/models/products_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<LayoutCubit>(context);

          return ListView(
            children: [
              Image.network(
                productModel.image!,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                productModel.name!,
                style: const TextStyle(fontSize: 20),
              )),
              const SizedBox(
                height: 10,
              ),
            Row(
              children: [
                  const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("description : ",
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(productModel.description!,
                    style: const TextStyle(fontSize: 14)),
              
              ],
            ),
              const SizedBox(
                height: 10,
              ),
             Row(children: [
                const Padding(
                   padding:  EdgeInsets.only(left: 10),
                   child: Text(
                    "Old_Price : ",
                    style: TextStyle(fontSize: 20, ),
                                 ),
                 ),
              
               Text(
                  productModel.price!.toString(),
                  style: const TextStyle(fontSize: 20,decoration: TextDecoration.lineThrough),
                ),
              
             ],),
            const SizedBox(height: 10,),
             const Row(children: [
                 Padding(
                   padding:  EdgeInsets.only(left: 10),
                   child: Text(
                    "sale_percent :",
                    style: TextStyle(fontSize: 20 ),
                                 ),
                 ),
              
              // Text(
                //  productModel.sale_percent!,
                 // style: const TextStyle(fontSize: 20),
                //),
              
             ],),
                    const      SizedBox(height: 10,),

             const Row(children: [
                Padding(
                   padding:  EdgeInsets.only(left: 10),
                   child: Text(
                    "price_after_sale : ",
                    style: TextStyle(fontSize: 20),
                                 ),
                 ),
              
             //  Text(
               //   productModel.price_after_sale!,
                 // style: const TextStyle(fontSize: 20),
               // ),
              
             ],),
           
            ],
          );
        },
      ),
    );
  }
}
