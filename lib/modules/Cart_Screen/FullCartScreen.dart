import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ProductModel.dart';
import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Bloc/States/States.dart';
import '../../shared/Style/Colors.dart';

class FullCartScreen extends StatelessWidget {
  List<ProductModel> cartproducts;
  int index;
  List<int> quantitylist;
  //List<double>checkOut;
  FullCartScreen(this.cartproducts, this.quantitylist, this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppAddInCartSuccessState) {
          // AppCubit.get(context).CalculateThePriceOfProductsInCart();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppCubit.get(context).isDark
                    ? Colors.blueGrey[900]
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )),
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage('${cartproducts[index].imageUrl}'),
                    fit: BoxFit.cover,
                  )),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            '${cartproducts[index].title}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Theme.of(context).splashColor,
                                onTap: () {
                                  print('hello world');
                                  AppCubit.get(context)
                                      .removeSelecteditemFromCartList(index);
                                },
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text('Price:', style: TextStyle(fontSize: 16)),
                          Text(
                            '${cartproducts[index].price}\$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text('Sub Total:', style: TextStyle(fontSize: 16)),
                          Text(
                            '${cartproducts[index].price! * quantitylist[index]}\$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text('Ships Free', style: TextStyle(fontSize: 16)),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .CalculateThePriceOfProductsInCart(
                                        '-', index);
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Colors.grey,
                              )),
                          Container(
                            height: 25,
                            width: 29,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                ColorsConsts.gradiendLStart,
                                ColorsConsts.gradiendLEnd,
                              ], stops: [
                                0.0,
                                0.7
                              ]),
                            ),
                            child:
                                Center(child: Text('${quantitylist[index]}')),
                          ),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .CalculateThePriceOfProductsInCart(
                                        '+', index);
                                AppCubit.get(context).CalculateTheTotalPrice();
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.green,
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
