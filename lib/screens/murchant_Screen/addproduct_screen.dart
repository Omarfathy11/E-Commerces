
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/screens/murchant_Screen/homepage_merchant.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _imagePiker = ImagePicker();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchantlayoutCubitCubit, MerchantlayoutCubitState>(
      listener: (context, state) {
        if (state is addProductsSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  LayoutMurchant()));
                        showSnackBarItem(context, "add successfully", true);

        } else if (state is FailedToaddProductsState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  const Text(
                    "merchant add product",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Enter your details below",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFielditem(controller: nameController, hintText: "name"),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFielditem(
                      controller: descriptionController,
                      hintText: "description"),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFielditem(
                      controller: priceController, hintText: "price"),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFielditem(
                      controller: quantityController, hintText: "quantity"),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          final pickedImage = await _imagePiker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedImage != null) {
                            File image = File(pickedImage.path);
                            BlocProvider.of<MerchantlayoutCubitCubit>(context)
                                .addProduct(
                                    name: nameController.text,
                                    description: descriptionController.text,
                                    price: priceController.text,
                                    quantity: quantityController.text,
                                    image: image);
                          }
                        }
                      },
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      color: Colors.redAccent,
                      minWidth: double.infinity,
                      child: const Text(
                        "add  photo",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<MerchantlayoutCubitCubit>(context)
                              .addProduct(
                            name: nameController.text,
                            description: descriptionController.text,
                            price: priceController.text,
                            quantity: quantityController.text,
                          );
                        }
                      },
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      color: Colors.redAccent,
                      minWidth: double.infinity,
                      child: Text(
                        state is addProductsLoadingState
                            ? "Loading ..."
                            : "update ",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void showSnackBarItem(
    BuildContext context, String message, bool forSuccessOrFailure) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
  ));
}

Widget _textFielditem(
    {bool? isScure,
    required TextEditingController controller,
    required String hintText}) {
  return TextFormField(
    controller: controller,
    validator: (input) {
      if (controller.text.isEmpty) {
        return "$hintText name must not be empyt";
      } else {
        return null;
      }
    },
    obscureText: isScure ?? false,
    decoration:
        InputDecoration(hintText: hintText, border: const OutlineInputBorder()),
  );
}
}