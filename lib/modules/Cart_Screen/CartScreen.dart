import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Bloc/States/States.dart';
import '../../shared/Style/Colors.dart';
import 'EmptyCartScreen.dart';
import 'FullCartScreen.dart';

class CartScreen extends StatelessWidget {
  //const CartScreen({Key? key}) : super(key: key);
  static const routeName = '/CartScreen';
  List product = [];
//product.length<1?Scaffold(body:EmptyCartScreen() ,):
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).inCartList.isNotEmpty)
          AppCubit.get(context).CalculateTheTotalPrice();

        return AppCubit.get(context).inCartList.isEmpty
            ? Scaffold(
                body: EmptyCartScreen(),
              )
            : Scaffold(
                bottomSheet: BuildCheckOutSection(
                    context, AppCubit.get(context).totalsum),
                appBar: AppBar(
                  title:
                      Text('Cart(${AppCubit.get(context).inCartList.length})'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context).ClearCartList();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                body: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => FullCartScreen(
                      AppCubit.get(context).inCartList,
                      AppCubit.get(context).num,
                      index),
                  itemCount: AppCubit.get(context).inCartList.length,
                ),
              );
      },
    );
  }

  Widget BuildCheckOutSection(context, sum) {
    return Container(
      // height: 50,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    ColorsConsts.gradiendLStart,
                    ColorsConsts.gradiendLEnd,
                  ], stops: [
                    0.0,
                    0.7
                  ]),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    splashColor: Theme.of(context).splashColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            //color: Theme.of(ctx).textSelectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              'US \$${sum}',
              //textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
