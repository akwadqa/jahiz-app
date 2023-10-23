import 'package:flutter/material.dart';

import '../../../../core/app_constants.dart';
import '../../../../core/gen/assets.gen.dart';

class QatarInternationalCodeWidget extends StatelessWidget {
  const QatarInternationalCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          color: Theme.of(context).primaryColor),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Assets.images.qatarFlag.image(),
          const SizedBox(width: 6),
          const Text(AppConstants.qatarInternationalCodeLabel,
              style: TextStyle(fontSize: 18, color: Colors.white))
        ],
      ),
    );
  }
}
