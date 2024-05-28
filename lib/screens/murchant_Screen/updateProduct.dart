import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';
import 'package:smallproject/shared/style/colors.dart';

class ProductUpdateScreen extends StatefulWidget {
  final int productId;

  ProductUpdateScreen({required this.productId});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;

  String? _description;

  String? _price;
  File? _image;
  File? _selectedImage;

    final ImagePicker _imagePiker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MerchantlayoutCubitCubit(),
      child: BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
        listener: (context, state) {
          if (state is UpDateProductDataSuccessState) {
            // Handle successful update
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Product updated successfully'),
              ),
            );
          } else if (state is UpDateProductDatawithFailureState) {
            // Handle update failure
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update product: ${state.error}'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is UpDateProductDataLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
           
            body: Column(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                            children: [
                              
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => const LayoutMurchant()));
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                                const  Text('Edit Product',style: TextStyle(fontSize: 20),)
                            ],
                          ),
                  ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  
                  child: Form(
                    
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _name,
                          onChanged: (value) => _name = value,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          initialValue: _description,
                          onChanged: (value) => _description = value,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          initialValue: _price,
                          onChanged: (value) => _price = value,
                          decoration: const InputDecoration(
                            labelText: 'Price',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async{
                            
                            if (_formKey.currentState?.validate() ?? false) {
                              
                              BlocProvider.of<MerchantlayoutCubitCubit>(context).editProductData(
                                    productid: widget.productId,
                                    name: _name,
                                    description: _description,
                                    price: _price,
                                  
                                  );
                            }
                          },
                          child: Text('Update Product'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, right: 80),
                          child: IconButton(
                            onPressed: () async {
                              final image = await _imagePiker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
                                BlocProvider.of<MerchantlayoutCubitCubit>(context)
                                    .editProductData(
                                      
                                        image: _selectedImage);
                              }
                            },
                            color: mainColor,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}