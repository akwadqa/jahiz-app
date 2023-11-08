import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key, required this.icon, required this.onTap, required this.text})
      : super(key: key);
  final Widget icon;
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
            radius: 38,
            child: icon,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.darkGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
