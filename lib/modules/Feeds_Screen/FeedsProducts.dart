import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/ProductModel.dart';
import '../../shared/Bloc/Cubit/Cubit.dart';
import '../ProductDetails_Screen/ProductDetails.dart';

class FeedsProducts extends StatelessWidget {
  // const FeedsProducts({Key? key}) : super(key: key);
  List<ProductModel> products;
  int index;
  FeedsProducts(this.products, this.index);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          /* Navigator.of(context).pushNamed(

            ProductDetails.routeName,
            arguments: {
              index:index
            }

          );*/
          AppCubit.get(context).ViewesRecentlyList.add(products[index]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(products, index)));
        },
        child: Stack(
          children: [
            Container(
              height: 290,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage('${products[index].imageUrl}'),
                      width: double.infinity,
                      height: 140,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${products[index].title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(
                      '${products[index].price}\$ ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantit: ${products[index].quantity}'),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Theme.of(context).splashColor,
                            onTap: () {},
                            child: Icon(Icons.more_horiz),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'New',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
