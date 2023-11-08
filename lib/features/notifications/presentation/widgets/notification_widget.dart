import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Notification;
import '../../../../core/router/app_router.dart';
import '../../domain/entities/notification.dart';

class NotifiationWidget extends StatelessWidget {
  final Notification notification;
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
            notification.appMessageTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(notification.content),
        ],
      ),
      subtitle: Text(
        notification.publishedOn,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => context.pushRoute(NotificationDetailsRoute(notification: notification)),
    );
  }
}
