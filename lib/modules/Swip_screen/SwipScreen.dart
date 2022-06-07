import 'package:flutter/material.dart';

import '../../layout/LayOut_Screens/BottomNavigationScreen.dart';
import '../Home_Screen/HomeScreen.dart';
import '../UploadProduct_Screen/UploadProductScreen.dart';

class SwipScreen extends StatelessWidget {
  const SwipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomNavigationScreen(), UploadProductScreen()],
    );
  }
}
