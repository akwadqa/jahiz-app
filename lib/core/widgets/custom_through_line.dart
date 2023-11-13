import 'package:flutter/material.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'dart:math' as math;

class CustomThroughLine extends StatelessWidget {
  final String productPrice;
  final bool isSmallestPremiumItem;
  const CustomThroughLine(
      {super.key,
      required this.productPrice,
      required this.isSmallestPremiumItem});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(productPrice,
            style: TextStyle(
              fontSize: isSmallestPremiumItem ? 11 : 13,
              color: AppColors.lightBlack,
            )),
        Transform.rotate(
          angle: -math.pi / 9,
          child: const SizedBox(
            width: 54,
            child: Divider(
              thickness: 1,
              height: 8,
              color: AppColors.red,
            ),
          ),
        ),
      ],
    );
  }
}
