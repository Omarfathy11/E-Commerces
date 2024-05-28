import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/cubit_favorites/favorites_cubit.dart';
import 'package:smallproject/cubit_favorites/favorites_state.dart';
import 'package:smallproject/shared/style/colors.dart';

class FavorietsScreen extends StatelessWidget {
  const FavorietsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocProvider(
        create: (context) => FavoritesCubit()..getFavorites(),
        child: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {
            // Add any necessary listener logic here
          },
          builder: (context, state) {
            if (state is FavoritesInitial) {
              return const Center(child: CupertinoActivityIndicator(radius: 40, color: Colors.amber),);
            } else if (state is FavoritesSuccessState) {
              final favorites = state.favorites;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                 favorites[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.network(
                          favorites[index].image!,
                          height: 100,
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(favorites[index].name!),
                              Text(favorites[index].price!.toString()),
                              MaterialButton(
                                onPressed: () {
                                  AwesomeDialog(
                                    btnOkColor: Colors.red,
                                    btnCancelColor: mainColor,
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    desc: "Do you want to delete this item?",
                                    descTextStyle: const TextStyle(fontSize: 18),
                                    btnCancelText: "cancel",
                                    btnOkText: "delete",
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      BlocProvider.of<FavoritesCubit>(context)
                                          .deleteFavorite(
                                        productId: favorites[index].id.toString(),
                                      );
                                    },
                                  ).show();
                                },
                                
                                textColor: Colors.white,
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: const Text("Remove"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(radius: 40, color: Colors.amber),
              );
            }
          },
        ),
      ),
    );
  }
}