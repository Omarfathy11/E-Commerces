
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/models/categories.dart';
import 'package:smallproject/shared/style/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);

    List<CategoriesModel> categoriesdata =
        BlocProvider.of<LayoutCubit>(context).categories;
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onChanged: (input) {
                  cubit.filterCategories(input: input);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    suffixIcon: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoriesScreen()),
                          );
                        },
                        child: const Icon(
                          Icons.clear,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    contentPadding: EdgeInsets.zero),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "categories",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            categoriesdata.isEmpty
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: cubit.filteredCategories.isEmpty
                            ? categoriesdata.length
                            : cubit.filteredCategories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Text(
                                cubit.filteredCategories.isEmpty
                                    ? categoriesdata[index].name!
                                    : cubit.filteredCategories[index].name!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          );
                        }),
                  ),
          ]),
        );
      },
    );
  }
}
