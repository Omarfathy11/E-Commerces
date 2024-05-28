
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_state.dart';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_cubit.dart';
import 'package:smallproject/screens/login_screen.dart';
import 'package:smallproject/screens/splash_screen.dart';
import 'package:smallproject/screens/theme.dart';
import 'package:smallproject/shared/style/colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context); // عشام اوصل  للداتا
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            endDrawer: Drawer(
              child: BlocProvider(
                create: (context) => LayoutCubit()..getUserData(),
                child: BlocConsumer<LayoutCubit, LayoutStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LayoutInitialState) {
                      return const Center(
                        child: CupertinoActivityIndicator(
                            radius: 40, color: Colors.amber),
                      );
                    } else if (state is GetUserDataSuccessState) {
                      final usermodel = state.usermodel;
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
                                            borderRadius:
                                                const BorderRadius.horizontal(),
                                            child: Image.network(
                                              usermodel.image!,
                                            )))),
                              ), 
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                usermodel.customer!.fullName!,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                usermodel.customer!.email!,
                                style: const TextStyle(fontSize: 17),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Consumer<ThemeProvider>(
                                        builder: (context, provider, child) {
                                          return Column(
                                            children: [
                                              SwitchListTile(
                                                title: Text(
                                                  'Dark',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                                value: provider.currentTheme ==
                                                    'dark',
                                                onChanged: (bool value) {
                                                  provider.changeTheme(value
                                                      ? 'dark'
                                                      : 'system');
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 30, left: 5),
                                                child: ListTile(
                                                  onTap: () {
                                                    BlocProvider.of<AuthCubit>(
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
                                                    style:
                                                        TextStyle(fontSize: 20),
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
              elevation: 0,
              title: Image.asset(
                'images/Frame 928.png',
                height: 150,
                width: 150,
              ),
            ),
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
                      icon: Icon(Icons.category), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile'),
                ]),
            body: cubit.layoutScreens[cubit.buttomNavindex],
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
