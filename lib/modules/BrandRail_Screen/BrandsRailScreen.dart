import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:flutter/material.dart';

import '../../models/ProductModel.dart';
import 'BrandRailItem.dart';

class BrandsRailScreen extends StatefulWidget {
  //const BrandsRailScreen({Key? key}) : super(key: key);
  static const routeName = '/BrandsRailScreen';
  List<ProductModel> brandList;
  int index;
  BrandsRailScreen(this.brandList, this.index);

  @override
  State<BrandsRailScreen> createState() => _BrandsRailScreenState();
}

class _BrandsRailScreenState extends State<BrandsRailScreen> {
  int selectedIndex = 0;
  final padding = 8.0;
  late String brand;
  late String routeArg;

  void didChangeDependencies() {
    //routeArg = ModalRoute.of(context)!.settings.arguments.toString();
    selectedIndex =
        widget.index; /*int.parse(
      routeArg.substring(1, 2),
    );*/
    //  print(selectedIndex);
    if (selectedIndex == 0) {
      setState(() {
        brand = 'Adidas';
      });
    }
    if (selectedIndex == 1) {
      setState(() {
        brand = 'Apple';
      });
    }
    if (selectedIndex == 2) {
      setState(() {
        brand = 'Dell';
      });
    }
    if (selectedIndex == 3) {
      setState(() {
        brand = 'Huawei';
      });
    }
    if (selectedIndex == 4) {
      setState(() {
        brand = 'Nike';
      });
    }
    if (selectedIndex == 5) {
      setState(() {
        brand = 'Samsung';
      });
    }
    if (selectedIndex == 6) {
      setState(() {
        brand = 'H\$M';
      });
    }
    if (selectedIndex == 7) {
      setState(() {
        brand = 'All';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 56.0,
                      groupAlignment: 1,
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                          if (selectedIndex == 0) {
                            setState(() {
                              brand = 'Adidas';
                              widget.brandList =
                                  AppCubit.get(context).AdidasList;
                            });
                          }
                          if (selectedIndex == 1) {
                            setState(() {
                              brand = 'Apple';
                              widget.brandList =
                                  AppCubit.get(context).AppleList;
                            });
                          }
                          if (selectedIndex == 2) {
                            setState(() {
                              brand = 'Dell';
                              widget.brandList = AppCubit.get(context).DellList;
                            });
                          }
                          if (selectedIndex == 3) {
                            setState(() {
                              brand = 'Huawei';
                              widget.brandList =
                                  AppCubit.get(context).HuaweiList;
                            });
                          }
                          if (selectedIndex == 4) {
                            setState(() {
                              brand = 'Nike';
                              widget.brandList = AppCubit.get(context).NikeList;
                            });
                          }
                          if (selectedIndex == 5) {
                            setState(() {
                              brand = 'Samsung';
                              widget.brandList =
                                  AppCubit.get(context).SamsungList;
                            });
                          }
                          if (selectedIndex == 6) {
                            setState(() {
                              brand = 'H\$M';
                              widget.brandList = AppCubit.get(context).HMList;
                            });
                          }
                          if (selectedIndex == 7) {
                            setState(() {
                              brand = 'All';
                              widget.brandList = AppCubit.get(context).Products;
                            });
                          }
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        BuildRotatedTextRailDistination('Adidas', padding),
                        BuildRotatedTextRailDistination('Apple', padding),
                        BuildRotatedTextRailDistination('Dell', padding),
                        BuildRotatedTextRailDistination('Huawei', padding),
                        BuildRotatedTextRailDistination('Nike', padding),
                        BuildRotatedTextRailDistination('Samsung', padding),
                        BuildRotatedTextRailDistination('H\$M', padding),
                        BuildRotatedTextRailDistination('All', padding),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          ContentSpace(context, brand, widget.brandList),
        ],
      ),
    );
  }
}

NavigationRailDestination BuildRotatedTextRailDistination(
    String text, double padding) {
  return NavigationRailDestination(
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
    icon: SizedBox.shrink(),
  );
}

class ContentSpace extends StatelessWidget {
  // const ContentSpace({Key? key}) : super(key: key);
  final String brand;
  List<ProductModel> brabdlist;
  ContentSpace(context, this.brand, this.brabdlist);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(24, 8, 0, 0),
      child: MediaQuery.removePadding(
          context: context,
          child: ListView.builder(
              itemCount: brabdlist.length,
              itemBuilder: (context, index) =>
                  BrandRailItem(brabdlist, index))),
    ));
  }
}
