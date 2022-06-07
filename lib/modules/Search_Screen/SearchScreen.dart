import 'package:e_commerce_app/models/ProductModel.dart';
import 'package:e_commerce_app/shared/Bloc/States/States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Style/Colors.dart';
import '../ProductDetails_Screen/ProductDetails.dart';

class SearchScreen extends StatelessWidget {
  // const SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          ColorsConsts.starterColor,
                          ColorsConsts.endColor
                        ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        )),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Search Now In Our Products for what you need 😌',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // if(AppCubit.get(context).SearchList.isEmpty&&searchController.text.isNotEmpty)
                  //  Text('No Products Found'),

                  if (AppCubit.get(context).SearchList.isEmpty &&
                      AppCubit.get(context).onChangeValue.isEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => BuildSearchItem(
                            context, AppCubit.get(context).Products, index),
                        itemCount: AppCubit.get(context).Products.length,
                      ),
                    ),
                  //Text('Search Now To get Our Offers'),
                  if (AppCubit.get(context).SearchList.isNotEmpty &&
                      AppCubit.get(context).onChangeValue.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => BuildSearchItem(
                            context, AppCubit.get(context).SearchList, index),
                        itemCount: AppCubit.get(context).SearchList.length,
                      ),
                    ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .21,
                right: MediaQuery.of(context).size.width * .05,
                child: Container(
                  width: MediaQuery.of(context).size.width * .90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors
                        .white, //Theme.of(context).scaffoldBackgroundColor
                  ),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) =>
                        AppCubit.get(context).getSearchProducts(value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget BuildSearchItem(context, List<ProductModel> searchList, index) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: InkWell(
            onTap: () {
              AppCubit.get(context).ViewesRecentlyList.add(searchList[index]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetails(searchList, index)));
            },
            child: Card(
              elevation: 20,
              child: Row(
                children: [
                  Container(
                    width: 130,
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage('${searchList[index].imageUrl}'),
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${searchList[index].title}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text('Price:', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                '${searchList[index].price}\$',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
