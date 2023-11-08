import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class NoElementsWidget extends StatelessWidget {
  const NoElementsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(S.of(context).noElements));
  }
}
