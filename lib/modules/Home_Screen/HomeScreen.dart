import 'package:backdrop/backdrop.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../BrandRail_Screen/BrandsRailScreen.dart';
import '../../models/ProductModel.dart';
import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Bloc/States/States.dart';
import '../../shared/Constant/data.dart';
import '../../shared/Style/Colors.dart';
import '../FeedOfAllPopularProducts_Screen/FeedOfAllPopularProductsScreen.dart';
import '../ProductDetails_Screen/ProductDetails.dart';
import '../ShowCategoryProduct_Screen/ShowCategoryProductScreen.dart';
import '../UploadProduct_Screen/UploadProductScreen.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key? key}) : super(key: key);
  List<String> CrouselImages = [
    'assets/images/Carouselimages/carousel1.png',
    'assets/images/Carouselimages/carousel2.jpeg',
    'assets/images/Carouselimages/carousel3.jpg',
    'assets/images/Carouselimages/carousel3.jpg',
  ];
  List<String> SwiperImages = [
    'assets/images/Swiperimages/addidas.jpg',
    'assets/images/Swiperimages/apple.jpg',
    'assets/images/Swiperimages/Dell.jpg',
    'assets/images/Swiperimages/Huawei.jpg',
    'assets/images/Swiperimages/nike.jpg',
    'assets/images/Swiperimages/samsung.jpg',
    'assets/images/Swiperimages/hm.jpg',
  ];
  List<String> CategorieName = [
    'Laptop',
    'Phones',
    'Beauty',
    'Furniture',
    'Clothes',
    'Shoes',
    'Watches'
  ];
  List<String> CategorieImage = [
    'assets/images/Categoriesimages/CatLaptops.png',
    'assets/images/Categoriesimages/CatPhones.png',
    'assets/images/Categoriesimages/CatBeauty.jpg',
    'assets/images/Categoriesimages/CatFurniture.jpg',
    'assets/images/Categoriesimages/CatClothes.jpg',
    'assets/images/Categoriesimages/CatShoes.jpg',
    'assets/images/Categoriesimages/CatWatches.jpg'
  ];

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: BackdropScaffold(
              frontLayerBackgroundColor:
                  Theme.of(context).scaffoldBackgroundColor,
              headerHeight: MediaQuery.of(context).size.height * 0.30,
              appBar: BackdropAppBar(
                title: Text("Home"),
                leading: BackdropToggleButton(icon: AnimatedIcons.home_menu),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorsConsts.starterColor,
                      ColorsConsts.endColor
                    ]),
                  ),
                ),
                actions: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    splashRadius: 10,
                    onPressed: () {},
                    splashColor: Theme.of(context).splashColor,
                    icon: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          '${AppCubit.get(context).userModel?.userImage}'),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              backLayer: BuildbacklayerDesign(context),
              frontLayer: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CarouselSlider(
                            items: [
                              Image.asset(
                                CrouselImages[0],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Image.asset(
                                CrouselImages[1],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Image.asset(
                                CrouselImages[2],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Image.asset(
                                CrouselImages[3],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ],
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                cubit.ChangeDotsOfCarousal(index);
                              },
                              height: 200,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            )),
                        Container(
                          width: double.infinity,
                          color: Colors.grey.withOpacity(.5),
                          child: DotsIndicator(
                            dotsCount: CrouselImages.length,
                            position:
                                AppCubit.get(context).DotsIndex.toDouble(),
                            decorator: DotsDecorator(
                              color: Colors.white,
                              activeColor: Colors.purple,
                              size: const Size.square(9.0),
                              activeSize: const Size(18.0, 9.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 180,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: CategorieImage.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowCategoryProductScreen(cubit
                                              .getCategoryList(index: index))));
                            },
                            child: BuildCategorieItem(
                                CategorieName, index, context, CategorieImage),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 15,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Popular Brands',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19)),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BrandsRailScreen(
                                            cubit.getPopularProduct(), 7)));
                              },
                              child: Text('View all..',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 15))),
                        ],
                      ),
                    ),
                    Container(
                      height: 210,
                      width: MediaQuery.of(context).size.width * .95,
                      child: Swiper(
                        autoplay: true,
                        scale: .9,
                        viewportFraction: .8,
                        itemCount: SwiperImages.length,
                        onTap: (index) {
                          /*Navigator.of(context).pushNamed(

                        BrandsRailScreen.routeName,
                        arguments: {
                          index,
                        },
                      );*/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BrandsRailScreen(
                                      cubit.getBrandList(index: index),
                                      index)));
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.blueGrey,
                              child: Image(
                                image: AssetImage(SwiperImages[index]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Popular Products',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19)),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FeedOfAllPopularProducts(
                                                cubit.getPopularProduct())));
                              },
                              child: Text('View all..',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 15))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 285,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                BuildPopularProductsItem(
                                    cubit.getPopularProduct(index: index),
                                    index,
                                    context),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 15,
                                ),
                            itemCount: cubit.getPopularProduct().length),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Viewed Recently',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19)),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FeedOfAllPopularProducts(
                                                cubit.ViewesRecentlyList)));
                              },
                              child: Text('View all>>',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 15))),
                        ],
                      ),
                    ),
                    if (cubit.ViewesRecentlyList.length == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                            child: Text(
                          'No Products Viewed Yet!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    if (cubit.ViewesRecentlyList.length > 0)
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 285,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  BuildPopularProductsItem(
                                      cubit.ViewesRecentlyList, index, context),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 15,
                                  ),
                              itemCount: cubit.ViewesRecentlyList.length),
                        ),
                      ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget BuildCategorieItem(
          List<String> catname, index, context, List<String> catimage) =>
      Container(
        height: 180,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                      image: AssetImage(catimage[index]), fit: BoxFit.fill)),
            ),
            Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  catname[index],
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
  Widget BuildPopularProductsItem(List<ProductModel> listt, index, context) =>
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetails(listt, index)));
        },
        child: Container(
          height: 185,
          width: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular((10)),
              bottomLeft: Radius.circular((10)),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${listt[index].imageUrl}'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 15,
                        right: 15,
                        child: Icon(
                          Icons.star,
                          color: Colors.black,
                        )),
                    Positioned(
                      right: 15,
                      bottom: 30,
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '1000 \$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${listt[index].title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      ' ${listt[index].description}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                    Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        onTap: () {},
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  Widget BuildbacklayerDesign(context) => Container(
        height: MediaQuery.of(context).size.height * .55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ColorsConsts.starterColor, ColorsConsts.endColor]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(
                              '${AppCubit.get(context).userModel?.userImage}'),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wishlist',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.favorite_border)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadProductScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upload a new product',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.upload_outlined)
                ],
              ),
            ),
          ],
        ),
      );
}
