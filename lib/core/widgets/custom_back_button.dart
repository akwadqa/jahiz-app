import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'contained_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainedButton(
        margin: const EdgeInsets.all(8.0),
        icon: const Padding(
          padding: EdgeInsetsDirectional.only(start: 4.0),
          child: Icon(Icons.arrow_back_ios),
        ),
        onPressed: context.popRoute);
  }
}
