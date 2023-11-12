import 'package:flutter/material.dart';
import 'package:jahiz/core/theme/app_colors.dart';

class CustomCurveBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final BorderRadiusGeometry? backgroundContainerborderRadius;
  final BorderRadiusGeometry? listContainerborderRadius;
  final double? height;

  const CustomCurveBackground({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.height,
    required this.backgroundColor,
    required this.backgroundContainerborderRadius,
    required this.listContainerborderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: backgroundContainerborderRadius),
        child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteLilacColor,
              borderRadius: listContainerborderRadius,
            ),
            clipBehavior: Clip.antiAlias,
            child: child));
  }
}
