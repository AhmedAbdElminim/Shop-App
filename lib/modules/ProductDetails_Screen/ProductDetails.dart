import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ProductModel.dart';
import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Bloc/States/States.dart';
import '../../shared/Component/Componetnt.dart';
import '../../shared/Constant/data.dart';
import '../../shared/Style/Colors.dart';
import '../Cart_Screen/CartScreen.dart';
import '../Feeds_Screen/FeedsProducts.dart';
import '../WishList_Screen/WishListScreen.dart';

class ProductDetails extends StatelessWidget {
  // const ProductDetails({Key? key}) : super(key: key);
  static const routeName = '/ProductDetails';
  int index;
  List<ProductModel> listOfProduct = [];
  ProductDetails(this.listOfProduct, this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomSheet: BuildBottomSheetDesign(context, listOfProduct[index]),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .45,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    image: DecorationImage(
                      image: NetworkImage('${listOfProduct[index].imageUrl}'),
                      // fit: BoxFit.fill,
                    )),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .39),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {},
                              child: Icon(Icons.save_alt),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {},
                              child: Icon(Icons.share),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            '${listOfProduct[index].title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'US 1000 \$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                          SizedBox(height: 15),
                          MyDivider(),
                          SizedBox(height: 15),
                          Text(
                            '${listOfProduct[index].description}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey[500]),
                          ),
                          SizedBox(height: 15),
                          MyDivider(),
                          SizedBox(height: 15),
                          BuildDesignOfProductInformation(
                              'Brand', '${listOfProduct[index].brand}'),
                          SizedBox(height: 15),
                          BuildDesignOfProductInformation(
                              'Quantity', '${listOfProduct[index].quantity}'),
                          SizedBox(height: 15),
                          BuildDesignOfProductInformation('Category',
                              '${listOfProduct[index].productCategoryName}'),
                          SizedBox(height: 15),
                          BuildDesignOfProductInformation('Popularity',
                              '${listOfProduct[index].isPopular}'),
                          SizedBox(height: 15),
                          MyDivider(),
                          Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.blueGrey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No reviews yet',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'No reviews yet',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[800]),
                                )
                              ],
                            ),
                          ),
                          MyDivider(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Suggested products:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 290,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: FeedsProducts(listOfProduct, index),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      "DETAIL",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.shopping_basket_sharp,
                          color: ColorsConsts.favColor,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(WishListScreen.routeName);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: ColorsConsts.cartColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                      ),
                    ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget BuildDesignOfProductInformation(String text1, String text2) => Row(
        children: [
          Text(
            '${text1}: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            text2,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey[700]),
          ),
        ],
      );
  Widget BuildBottomSheetDesign(context, ProductModel product) => Container(
        height: 50,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  showToAst(
                      msg: 'The Product Added To Your Cart Succussfuly ',
                      iserror: false);
                  AppCubit.get(context).AddToCart(product);
                },
                child: Container(
                    color: Colors.deepOrange,
                    height: double.infinity,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ADD TO CART',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ))),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                  //color: Colors.deepOrange,
                  height: double.infinity,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'BUY NOW',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.shopping_cart)
                      ],
                    ),
                  ))),
            ),
            InkWell(
              onTap: () {
                showToAst(
                    msg: 'The Product Added To Your WishList Succussfuly ',
                    iserror: false);
                AppCubit.get(context).Add_DeleteFromWishList(product);
              },
              child: Container(
                  color: Colors.grey,
                  height: double.infinity,
                  child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            size: 35,
                            color: Colors.red[900],
                          )))),
            ),
          ],
        ),
      );
}
