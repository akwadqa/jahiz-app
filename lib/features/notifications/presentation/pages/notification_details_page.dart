import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Notification;
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../domain/entities/notification.dart';

@RoutePage()
class NotificationDetailsPage extends StatelessWidget {
  const NotificationDetailsPage({super.key, required this.notification});

  final Notification notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const CustomBackButton(),
            flexibleSpace:
                AppCachedNetworkImage(imageUrl: notification.appMessageIcon),
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
              child: Center(
                  child: Column(
            children: [
              Text(notification.appMessageTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(notification.content),
            ],
          )))
        ],
      ),
    );
  }
}
