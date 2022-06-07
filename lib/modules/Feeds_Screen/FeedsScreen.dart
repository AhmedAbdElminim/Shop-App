import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:e_commerce_app/shared/Bloc/States/States.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ProductModel.dart';
import '../../shared/Constant/data.dart';
import 'FeedsProducts.dart';

class FeedsScreen extends StatelessWidget {
  // const FeedsScreen({Key? key}) : super(key: key);
  static const routeName = '/FeedsScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 185 / 350,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children:
                  List.generate(AppCubit.get(context).Products.length, (index) {
                return FeedsProducts(AppCubit.get(context).Products, index);
              }),
            ),
          ),
        );
      },
    );
  }
}
