import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../bloc/get_notifications/get_notifictions_cubit.dart';
import '../widgets/notifications_list.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

@RoutePage()
class NotificationsPage extends StatelessWidget implements AutoRouteWrapper {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const CustomBackButton(),
            title: Text(S.of(context).notifications)),
        body: const NotificationsList());
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<GetNotificationsCubit>()..getNotifications(),
        child: this);
  }
}
