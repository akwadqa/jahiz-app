import 'package:flutter/material.dart';
import '../gen/fonts.gen.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData lightTheme(String? primaryColor) => ThemeData(
      fontFamily: FontFamily.qatar,
      appBarTheme: _appBarTheme,
      colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.white,
          primarySwatch: primaryColor != null
              ? _createMaterialColor(HexColor(primaryColor))
              : Colors.blue),
      inputDecorationTheme: _inputDecorationTheme(primaryColor),
      primarySwatch: primaryColor != null
          ? _createMaterialColor(HexColor(primaryColor))
          : null,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: _elevatedButtonThemeData(primaryColor),
      tabBarTheme: _tabBarTheme,
      chipTheme: _chipTheme(primaryColor));

  static AppBarTheme get _appBarTheme => const AppBarTheme(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontFamily: FontFamily.qatar,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black));

  static ChipThemeData _chipTheme(String? primaryColor) => ChipThemeData(
        selectedColor: primaryColor != null ? HexColor(primaryColor) : null,
        backgroundColor: primaryColor != null
            ? HexColor(primaryColor).withOpacity(0.2)
            : null,
      );

  static TabBarThemeData get _tabBarTheme =>
      const TabBarThemeData(labelColor: Colors.black);

  static ElevatedButtonThemeData _elevatedButtonThemeData(
          String? primaryColor) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              primaryColor != null
                  ? _createMaterialColor(HexColor(primaryColor))
                  : null,
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(17)))),
            textStyle: MaterialStateProperty.all(const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.qatar)),
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 60))),
      );

  static InputBorder outlineInputBorder(String? primaryColor) =>
      OutlineInputBorder(
        borderSide: BorderSide(
            color:
                primaryColor != null ? HexColor(primaryColor) : Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      );

  static InputDecorationTheme _inputDecorationTheme(String? primaryColor) =>
      InputDecorationTheme(
        border: outlineInputBorder(primaryColor),
        enabledBorder: outlineInputBorder(primaryColor),
        focusedBorder: outlineInputBorder(primaryColor),
      );

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
