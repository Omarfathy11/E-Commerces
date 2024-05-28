
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smallproject/cubit/merchantlayout_cubit_cubit.dart';
import 'package:smallproject/layout/layout_cubit/layout_cubit.dart';
import 'package:smallproject/layout/layout_screen.dart';
import 'package:smallproject/murchant_cubit/murchant_cubit.dart';
import 'package:smallproject/screens/authentication_screen/cubit/auth_cubit_cubit.dart';
import 'package:smallproject/screens/murchant_Screen/murchantlayout.dart';
import 'package:smallproject/screens/splash_screen.dart';
import 'package:smallproject/screens/theme.dart';
import 'package:smallproject/shared/constants/constants.dart';
import 'package:smallproject/shared/network/local_network.dart';
import 'package:smallproject/shared/style/colors.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  token = await CacheNetwork.getCacheData(key: 'accesstoken');
  merchanttoken = await CacheNetwork.getCacheData(key: 'token');

  debugPrint('TOKEN IS  $token');
  debugPrint('MerchToken IS  $merchanttoken');


  runApp(ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
          child : const MyApp()

    ),
     );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Consumer<ThemeProvider>(builder: (context, provider, child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MerchantCubit()),
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getUserData()
            ..getCategoriesData()
            ..getProductsData()
            ..updateUserData(),
        ),
        BlocProvider(create: (context) => MerchantlayoutCubitCubit()..getMerchantData()..getProductsData()..updateMerchantData()..getOrders())
      ],
      
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
          return MaterialApp(
          
           theme: ThemeData(
            appBarTheme:const AppBarTheme(backgroundColor: fourthColor),
            primaryColor: Colors.blue
          ),
          darkTheme: ThemeData.dark(),
          themeMode: provider.themeMode,
          
            debugShowCheckedModeBanner: false,
            home:  token!= null ? const LayoutScreen() : merchanttoken != null ? const LayoutMurchant() : const SplasScreen());
      }
      
      ),
    );
  }); }
}

     
    
