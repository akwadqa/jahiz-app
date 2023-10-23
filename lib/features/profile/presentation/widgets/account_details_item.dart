import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AccountDetailsItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final VoidCallback onTap;

  const AccountDetailsItem({
    Key? key,
    required this.leading,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGreen,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}
