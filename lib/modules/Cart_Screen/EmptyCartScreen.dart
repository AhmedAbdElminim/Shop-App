import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Feeds_Screen/FeedsScreen.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/emptycart.png'),
                  fit: BoxFit.cover)),
        ),
        // SizedBox(height: 10,),
        Text(
          'Your Cart Is Empty',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Looks Like You didn\'t add anything to your cart yet ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 26, color: Colors.grey),
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              FeedsScreen.routeName,
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
                child: Text(
              'Shop Now',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }
}
