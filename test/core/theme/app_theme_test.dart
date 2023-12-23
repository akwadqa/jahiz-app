import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/theme/app_theme.dart';

void main() {
  test('AppTheme should create light theme with correct properties', () {
    const primaryColor = "#4DB561"; // Replce this color
    final theme = AppTheme.lightTheme(primaryColor);

    // AppBar Theme
    expect(theme.appBarTheme.elevation, equals(0.0));
    expect(theme.appBarTheme.centerTitle, equals(true));
    expect(theme.appBarTheme.backgroundColor, equals(Colors.transparent));
    expect(theme.appBarTheme.titleTextStyle, isNotNull);

    // Color Scheme
    expect(theme.colorScheme, isNotNull);

    // Input Decoration Theme
    expect(theme.inputDecorationTheme, isNotNull);

    // Scaffold Background Color
    expect(theme.scaffoldBackgroundColor, equals(Colors.white));

    // Elevated Button Theme
    expect(theme.elevatedButtonTheme, isNotNull);

    // TabBar Theme
    expect(theme.tabBarTheme, isNotNull);

    // Chip Theme
    expect(theme.chipTheme, isNotNull);
  });
}
