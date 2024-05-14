import 'package:flutter/material.dart';

class ChangeQuantityButton extends StatelessWidget {
  const ChangeQuantityButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.padding = const EdgeInsets.all(8)});
  final IconData icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8.0));
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Padding(
          padding: padding,
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 18),
        ),
      ),
    );
  }
}
