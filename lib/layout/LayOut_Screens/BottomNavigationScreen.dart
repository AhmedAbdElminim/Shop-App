import 'package:e_commerce_app/shared/Bloc/Cubit/Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modules/Cart_Screen/CartScreen.dart';
import '../../modules/Feeds_Screen/FeedsScreen.dart';
import '../../modules/Home_Screen/HomeScreen.dart';
import '../../modules/Search_Screen/SearchScreen.dart';
import '../../modules/Swip_screen/SwipScreen.dart';
import '../../modules/User_Screen/UserScreen.dart';
import '../../shared/Constant/MyAppIcons.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<Widget> Screens = [];
  int pageIndex = 0;
  @override
  void initState() {
    Screens = [
      HomeScreen(),
      FeedsScreen(),
      SearchScreen(),
      CartScreen(),
      UserInfoScreen(),
    ];

    super.initState();
  }

  void SelectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[pageIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: .01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                color: Colors.grey,
                width: .5,
              ))),
          child: BottomNavigationBar(
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            onTap: SelectPage,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey[800],
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.rss_feed_sharp,
                  color: Colors.grey[800],
                ),
                label: 'feeds',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                label: 'search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.card_travel_outlined,
                  color: Colors.grey[800],
                ),
                label: 'cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.grey[800],
                ),
                label: 'user',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              pageIndex = 2;
            });
          },
          splashColor: Colors.grey,
          hoverElevation: 10,
          tooltip: 'search',
          elevation: 4,
          child: Icon(Icons.search),
        ),
      ),
    );
  }
}
