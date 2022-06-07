//import 'package:completeshopapp/shared/Bloc/Cubit/Cubit.dart';
//import 'package:completeshopapp/shared/Bloc/States/States.dart';
//import 'package:completeshopapp/shared/Bloc_Observer/Bloc%20Observer.dart';
//import 'package:completeshopapp/shared/Network/Local/CasheHelper.dart';
//import 'package:completeshopapp/shared/Style/Themes.dart';
import 'package:e_commerce_app/modules/Swip_screen/SwipScreen.dart';
import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:e_commerce_app/shared/Bloc/States/States.dart';
import 'package:e_commerce_app/shared/Bloc_Observer/Bloc%20Observer.dart';
import 'package:e_commerce_app/shared/Constant/Constant.dart';
import 'package:e_commerce_app/shared/Network/Local/CasheHelper.dart';
import 'package:e_commerce_app/shared/Style/Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/BrandRail_Screen/BrandsRailScreen.dart';
import 'layout/LayOut_Screens/BottomNavigationScreen.dart';
import 'modules/Cart_Screen/CartScreen.dart';
import 'modules/Feeds_Screen/FeedsScreen.dart';
import 'modules/Landing_Screen/LandingScreen.dart';
import 'modules/Login_Screen/LoginScreen.dart';
import 'modules/ProductDetails_Screen/ProductDetails.dart';
import 'modules/Register_Screen/RegisterScreen.dart';
import 'modules/UploadProduct_Screen/UploadProductScreen.dart';
import 'modules/WishList_Screen/WishListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  await Firebase.initializeApp();

  bool isDark = CasheHelper.getdata(key: 'isDark') ?? false;
  Widget startWidget;
  dynamic token = CasheHelper.getdata(key: 'token');
  uId = CasheHelper.getdata(key: 'uId');
  if (token != null) {
    startWidget = SwipScreen();
  } else {
    startWidget = LandingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark, startWidget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  final bool isdark;
  final Widget beginScreen;
  MyApp(this.isdark, this.beginScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        if (uId != null)
          BlocProvider(
              create: (context) => AppCubit()
                ..getUserData()
                ..getAllProducts()
                ..changeAppMode(fromShared: isdark)),
        if (uId == null)
          BlocProvider(
              create: (context) => AppCubit()
                ..getAllProducts()
                ..changeAppMode(fromShared: isdark)),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: AppCubit.get(context).isDark
                ? darkTHeme(context)
                : lightTHeme(context), //? darkTHeme(context), //:
            home: beginScreen, //BottomNavigationScreen(),
            routes: {
              // BrandsRailScreen.routeName: (context) => BrandsRailScreen(),
              WishListScreen.routeName: (context) => WishListScreen(),
              FeedsScreen.routeName: (context) => FeedsScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              // ProductDetails.routeName: (context) => ProductDetails(0),
            },
          );
        },
      ),
    );
  }
}
//"Variant: releaseUnitTest"
//"Config: debug"
//Store: C:\Users\Ahmed abdelmonaim\.android\debug.keystore
//Alias: AndroidDebugKey
//MD5: 5A:A9:8C:9D:12:71:6B:63:36:F6:90:F0:D5:75:17:BD
//SHA1: A2:DC:5A:12:51:25:43:C8:1F:B0:32:A1:9C:E6:37:DA:97:8A:FA:1C
//SHA-256: CB:40:31:C0:34:5D:91:D2:78:82:CD:0E:60:6B:69:CD:0D:61:00:5F:51:FC:13:25:60:58:6D:EC:94:5D:F7:4F
//Valid until: Monday, March 18, 2052
