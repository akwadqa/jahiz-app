import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color mediumLightGray = Color(0xff999999);
  static const Color midnight = Color(0xff232F3E);
  static const Color lightGray = Color(0xffA4A4A7);
  static const Color red = Color(0xffD42027);
  static final Color shadowColor = Colors.black.withOpacity(0.16);
  static const Color lightBlack = Color(0xff0B0A0A);
  static const Color whiteSmoke = Color(0xffF6F9F6);
  static const Color darkGreen = Color(0xff000303);
  static const Color lightShadeOfGray = Color(0xffCBCBCB);
  static const Color green = Color(0xff4DB561);
  static const Color gray = Color(0xff8F8F8F);
  static const Color darkGray = Color(0xff726E6F);
  static const Color backgroundColor = Color(0xffF2F2F4);
  static const Color whiteLilacColor = Color(0xffF1F1F3);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
