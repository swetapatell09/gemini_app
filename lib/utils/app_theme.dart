import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white12,
    centerTitle: true,
    titleTextStyle:
        TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'comic'),
  ),
  brightness: Brightness.light,
);
ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.black,
    centerTitle: true,
    titleTextStyle:
        TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'comic'),
  ),
  brightness: Brightness.dark,
);
