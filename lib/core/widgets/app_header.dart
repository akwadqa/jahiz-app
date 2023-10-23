import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: Text(title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
