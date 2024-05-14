import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ContainedButton extends StatelessWidget {
  const ContainedButton(
      {super.key,
      required this.icon,
      this.color = AppColors.darkGreen,
      required this.onPressed,
      this.backgroundColor = AppColors.whiteSmoke,
      this.withShadow = true,
      this.margin});
  final Widget icon;
  final Color color;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool withShadow;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: withShadow
              ? [
                  BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      color: AppColors.shadowColor)
                ]
              : null),
      margin: margin,
      child: Center(
          child: IconButton(
              icon: icon, color: Colors.black, onPressed: onPressed)),
    );
  }
}
