import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12.0),
      child: Text(text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.error, fontSize: 12.0)),
    );
  }
}
