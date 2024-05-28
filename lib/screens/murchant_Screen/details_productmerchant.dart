
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/models/merchantproducts_model.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';

class DetailsMerchantProduct extends StatelessWidget {
    final merchantproduct productModel;

   const DetailsMerchantProduct({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      
      body: BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<MerchantlayoutCubitCubit>(context);

          return ListView(
            children: [
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
              
          
              
             ],),
           
            ],
          );
        },
      ),
    );
  }
}