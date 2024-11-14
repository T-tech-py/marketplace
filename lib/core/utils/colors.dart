import 'package:flutter/material.dart';

class AppColors{
  static const transparent = Colors.transparent;
  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const success = Colors.green;
  static const red = Colors.red;
  static const lightBlack = Color(0xff121111);
  static const cardBlack = Color(0xff1F1F1F);
  static const yellow = Color(0xffE9B32A);
  static const grey1 = Color(0xff696969);
  static const grey2 = Color(0xffFCF9F2);
  static var buttonGradient = const LinearGradient(colors: [
   Color(0xffF9D03F),
      Color(0xffE9B32A),
  ], tileMode: TileMode.clamp, begin: Alignment.bottomCenter,
  end: Alignment.topLeft,stops:[0,1]);

}