import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'contained_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainedButton(
        margin: const EdgeInsets.all(9.0),
        icon: const Padding(
          padding: EdgeInsetsDirectional.only(start: 4.0),
          child: Icon(Icons.arrow_back_ios, size: 18),
        ),
        onPressed: context.maybePop);
  }
}
