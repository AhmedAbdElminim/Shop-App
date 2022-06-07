import 'package:flutter/material.dart';

import '../../models/ProductModel.dart';
import '../Feeds_Screen/FeedsProducts.dart';

class FeedOfAllPopularProducts extends StatelessWidget {
  // const FeedOfAllPopularProducts({Key? key}) : super(key: key);
  List<ProductModel> PopularProductsList;
  FeedOfAllPopularProducts(this.PopularProductsList);

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
          children: List.generate(PopularProductsList.length, (index) {
            return FeedsProducts(PopularProductsList, index);
          }),
        ),
      ),
    );
  }
}
