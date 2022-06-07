import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ProductModel.dart';
import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Bloc/States/States.dart';
import '../../shared/Style/Colors.dart';
import '../Feeds_Screen/FeedsScreen.dart';

class WishListScreen extends StatelessWidget {
  //const WishListScreen({Key? key}) : super(key: key);
  static const routeName = '/WishListScreen';
  List WishList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppCubit.get(context).inWishList.isEmpty
            ? Scaffold(
                body: BuildWishListEmptyScreen(context),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                      'WishList(${AppCubit.get(context).inWishList.length})'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context).ClearWishList();
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
                body: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            BuildWishListFullScreen(context,
                                AppCubit.get(context).inWishList, index),
                        separatorBuilder: (context, state) => SizedBox(
                              height: 10,
                            ),
                        itemCount: AppCubit.get(context).inWishList.length)),
              );
      },
    );
  }

  Widget BuildWishListEmptyScreen(context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/empty-wishlist.png'),
                    fit: BoxFit.cover)),
          ),
          // SizedBox(height: 10,),
          Text(
            'Your Wish List Is Empty',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Explore more and shortlist some items',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 26, color: Colors.grey),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                FeedsScreen.routeName,
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'ADD A WISH',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      );
  Widget BuildWishListFullScreen(context, List<ProductModel> wishlist, index) =>
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 170,
            margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).backgroundColor,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        child: Image.network('${wishlist[index].imageUrl}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${wishlist[index].title}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '${wishlist[index].price}\$',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BuiltRemoveWishListItem(),
        ],
      );
  Widget BuiltRemoveWishListItem() => Positioned(
        top: 10,
        right: 15,
        child: Container(
          height: 30,
          width: 30,
          child: MaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: ColorsConsts.favColor,
            padding: EdgeInsets.all(0),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      );
}
