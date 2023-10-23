import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.onTap, required this.child})
      : super(key: key);
  final VoidCallback onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(17));
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          boxShadow: [BoxShadow(blurRadius: 6, color: AppColors.shadowColor)]),
      clipBehavior: Clip.antiAlias,
      child: Material(
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
