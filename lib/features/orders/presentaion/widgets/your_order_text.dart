import 'package:flutter/material.dart';
import 'package:jahiz/generated/l10n.dart';

class YourOrderText extends StatelessWidget {
  const YourOrderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(S.of(context).yourOrder,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold));
  }
}
