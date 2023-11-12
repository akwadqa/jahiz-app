import 'package:flutter/material.dart';
import 'package:jahiz/core/theme/app_colors.dart';

class CustomCurveBackground extends StatelessWidget {
  final Widget child;
  final Widget stackedChild;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double borderRadius;

  const CustomCurveBackground(
      {super.key,
      required this.child,
      required this.stackedChild,
      this.padding = EdgeInsets.zero,
      required this.backgroundColor,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Container(
            padding: padding,
            color: backgroundColor,
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteLilacColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: child)),
        stackedChild
      ],
    );
  }
}
