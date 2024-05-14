import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget(
      {super.key, required this.errorText, required this.onRetryClicked});
  final String errorText;
  final VoidCallback onRetryClicked;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorText,
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
          const SizedBox(height: 10.0),
          IconButton(onPressed: onRetryClicked, icon: const Icon(Icons.refresh))
        ],
      ),
    );
  }
}
