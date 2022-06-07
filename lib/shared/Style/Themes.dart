import 'package:flutter/material.dart';

ThemeData darkTHeme(context) => ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: Colors.purple,
    primaryColor: Colors.blueGrey[900],
    backgroundColor: Colors.grey.shade300,
    indicatorColor: Color(0xff0E1D36),
    hintColor: Colors.grey.shade300,
    highlightColor: Color(0xff372901),
    hoverColor: Color(0xff3A3A3B),
    focusColor: Color(0xff0B2512),
    disabledColor: Colors.grey,
    cardColor: Color(0xFF151515),
    canvasColor: Colors.black,
    brightness: Brightness.dark,
    buttonTheme:
        Theme.of(context).buttonTheme.copyWith(colorScheme: ColorScheme.dark()),
    appBarTheme: AppBarTheme(elevation: 0.0));
//Light theme
ThemeData lightTHeme(context) => ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade300,
    primarySwatch: Colors.purple,
    primaryColor: Colors.white,
    backgroundColor: Colors.white,
    indicatorColor: Color(0xffCBDCF8),
    hintColor: Colors.grey.shade800,
    highlightColor: Color(0xffFCE192),
    hoverColor: Color(0xff4285F4),
    focusColor: Color(0xffA8DAB5),
    disabledColor: Colors.grey,
    cardColor: Colors.white,
    canvasColor: Colors.grey[50],
    brightness: Brightness.light,
    buttonTheme: Theme.of(context)
        .buttonTheme
        .copyWith(colorScheme: ColorScheme.light()),
    appBarTheme: AppBarTheme(elevation: 0.0));
