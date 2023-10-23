import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class TitledContainer extends StatelessWidget {
  const TitledContainer({Key? key, required this.title, required this.child})
      : super(key: key);
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.gray,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: child,
          ),
        ],
      ),
    );
  }
}
