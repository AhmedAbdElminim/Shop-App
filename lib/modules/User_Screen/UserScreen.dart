import 'package:e_commerce_app/shared/Network/Local/CasheHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

import '../../shared/Bloc/Cubit/Cubit.dart';
import '../../shared/Bloc/States/States.dart';
import '../../shared/Component/Componetnt.dart';
import '../../shared/Style/Colors.dart';
import '../Cart_Screen/CartScreen.dart';
import '../WishList_Screen/WishListScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoScreen extends StatelessWidget {
  //const UserInfoScreen({Key? key}) : super(key: key);

  late ScrollController scrollController;
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        scrollController.addListener(() {
          AppCubit.get(context).ChangePostionOfFloatingButton();
        });
      },
      builder: (context, state) {
        scrollController = ScrollController();
        var cubit = AppCubit.get(context).userModel;

        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    elevation: 4,
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace:
                        LayoutBuilder(builder: (context, constraints) {
                      top = constraints.biggest.height;
                      return Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        )),
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          centerTitle: true,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: top <= 110.0 ? 1.0 : 0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: kToolbarHeight / 1.8,
                                      width: kToolbarHeight / 1.8,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 1.0,
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${cubit?.userImage}'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '${cubit?.name}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          background: Image(
                            image: NetworkImage('${cubit?.userImage}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titles('User Bag'),
                        SizedBox(
                          height: 10,
                        ),
                        MyDivider(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  WishListScreen.routeName,
                                );
                              },
                              child: ListTile(
                                title: Text('Wishlist'),
                                trailing: Icon(Icons.arrow_forward_ios),
                                leading: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  CartScreen.routeName,
                                );
                              },
                              child: ListTile(
                                title: Text('Cart'),
                                trailing: Icon(Icons.arrow_forward_ios),
                                leading: Icon(Icons.card_travel_outlined),
                              )),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              onTap: () {},
                              child: ListTile(
                                title: Text('My Order'),
                                trailing: Icon(Icons.arrow_forward_ios),
                                leading: Icon(Icons.border_color),
                              )),
                        ),
                        titles('User Information'),
                        SizedBox(
                          height: 10,
                        ),
                        MyDivider(),
                        userListTile(
                            Icons.email, 'Email', '${cubit?.email}', context),
                        userListTile(Icons.phone_android, 'Phone number',
                            '${cubit?.phone}', context),
                        userListTile(Icons.local_shipping, 'Shipping address',
                            'Cairo,Egypt', context),
                        userListTile(Icons.date_range, 'Joined date',
                            '21,jan,2022', context),
                        titles('User Setting'),
                        SizedBox(
                          height: 10,
                        ),
                        MyDivider(),
                        ListTileSwitch(
                          value: AppCubit.get(context).isDark,
                          leading: Icon(Icons.dark_mode_sharp),
                          onChanged: (value) {
                            //isDarkSwitch =value;
                            AppCubit.get(context).changeAppMode();
                          },
                          visualDensity: VisualDensity.comfortable,
                          switchType: SwitchType.cupertino,
                          switchActiveColor: Theme.of(context).primaryColor,
                          title: Text('Dark Mode'),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              //  Navigator.canPop(context)
                              //    ? Navigator.pop(context)
                              //   : null;
                              //  await FirebaseAuth.instance.signOut();
                              // CasheHelper.saveData(key: 'token', value: null);
                              // AppCubit.get(context).signout(context);
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,

                                // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        AppCubit.get(context).isDark
                                            ? Colors.blueGrey[900]
                                            : Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),

                                    //title: const Text('AlertDialog Title'),
                                    clipBehavior: Clip.antiAlias,
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text(
                                            '😔',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 70),
                                          ),
                                          Text(
                                            'SignOut',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Are you sure? You will be logged out ',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.cyan,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextButton(
                                              child: Text(
                                                'Cancel',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.cyan,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextButton(
                                              child: Text(
                                                'SignOut',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () {
                                                CasheHelper.removeData(
                                                    key: 'token');
                                                CasheHelper.removeData(
                                                    key: 'uId');
                                                AppCubit.get(context)
                                                    .signout(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            splashColor: Theme.of(context).splashColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.grey[800],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('LogOut')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              //BuildAnimationFloatingActionButton(),
            ],
          ),
        );
      },
    );
  }

  Widget BuildAnimationFloatingActionButton() {
    final double defaultTopMargin = 200.0 - 4.0;
    final double scaleStart = 160.0;
    final double scaleEnd = scaleStart / 2;
    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
          transform: Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.purple,
            heroTag: 'btn1',
            child: Icon(Icons.camera_alt_outlined),
          )),
    );
  }

  Widget titles(String text) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  Widget userListTile(IconData icon, String title, String subtitle, context) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          splashColor: Theme.of(context).splashColor,
          child: ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ),
      );
}
