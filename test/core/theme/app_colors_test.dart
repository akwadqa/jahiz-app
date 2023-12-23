import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/theme/app_colors.dart';

void main() {
  test('AppColors should have correct color values', () {
    expect(AppColors.mediumLightGray, equals(const Color(0xff999999)));
    expect(AppColors.midnight, equals(const Color(0xff232F3E)));
    expect(AppColors.lightGray, equals(const Color(0xffA4A4A7)));
    expect(AppColors.red, equals(const Color(0xffD42027)));
    expect(AppColors.shadowColor, equals(Colors.black.withOpacity(0.16)));
    expect(AppColors.lightBlack, equals(const Color(0xff0B0A0A)));
    expect(AppColors.whiteSmoke, equals(const Color(0xffF6F9F6)));
    expect(AppColors.darkGreen, equals(const Color(0xff000303)));
    expect(AppColors.lightShadeOfGray, equals(const Color(0xffCBCBCB)));
    expect(AppColors.green, equals(const Color(0xff4DB561)));
    expect(AppColors.gray, equals(const Color(0xff8F8F8F)));
    expect(AppColors.darkGray, equals(const Color(0xff726E6F)));
    expect(AppColors.backgroundColor, equals(const Color(0xffF2F2F4)));
    expect(AppColors.whiteLilacColor, equals(const Color(0xffF1F1F3)));
  });

  test('HexColor should create Color from hex string', () {
    final hexColor = HexColor("#4DB561");
    expect(hexColor, equals(const Color(0xff4DB561)));
  });

  test('HexColor should handle shorthand hex format', () {
    final hexColor = HexColor("#F00");
    expect(hexColor, equals(const Color(0xFFFF0000))); // Expanded to full format
  });

  test('HexColor should handle transparent color', () {
    final hexColor = HexColor("#80FFFFFF"); // 50% opacity
    expect(hexColor, equals(const Color(0x80FFFFFF)));
  });

  test('HexColor should handle full hex format', () {
    final hexColor = HexColor("#FF00FF");
    expect(hexColor, equals(const Color(0xFFFF00FF)));
  });
}
