import 'package:flutter/material.dart';

import '../../models/ProductModel.dart';
import '../Feeds_Screen/FeedsProducts.dart';
import '../ProductDetails_Screen/ProductDetails.dart';

class ShowCategoryProductScreen extends StatelessWidget {
  //const ShowCategoryProductScreen({Key? key}) : super(key: key);
  List<ProductModel> categoryproductslist;
  //int index;
  ShowCategoryProductScreen(this.categoryproductslist);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 185 / 350,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(categoryproductslist.length, (index) {
            return FeedsProducts(categoryproductslist, index);
          }),
        ),
      ),
    );
  }
}
