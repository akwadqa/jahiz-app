import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jahiz/features/notification/domain/entities/notification.dart';

class NotifiationWidget extends StatelessWidget {
  final Notifications notification;
  const NotifiationWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      titleAlignment: ListTileTitleAlignment.center,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.subject,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(notification.emailContent),
        ],
      ),
      subtitle: Text(
        "${DateFormat('dd', "en_US").format(DateTime.parse(notification.postingDateTime))} ${DateFormat('MMMM', "en_US").format(DateTime.parse(notification.postingDateTime)).substring(0, 3)} ${DateFormat('y', "en_US").format(DateTime.parse(notification.postingDateTime))}",
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
