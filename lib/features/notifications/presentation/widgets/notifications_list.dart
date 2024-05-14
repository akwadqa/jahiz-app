import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_pagination_widget.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../bloc/get_notifications/get_notifictions_cubit.dart';
import 'notification_widget.dart';
import '../../../../generated/l10n.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotificationsCubit, GetNotificationsState>(
        builder: (context, state) {
      if (state is GetNotificationsIsEmpty) {
        return Center(child: Text(S.of(context).noNotifications));
      }
      if (state is GetNotificationsSuccess) {
        return AppPaginationWidget(
            onLoading: context.read<GetNotificationsCubit>().onLoadingMore,
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                itemBuilder: (context, index) {
                  return NotifiationWidget(
                      notification: state.appResponse.data[index]);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 20.0,
                  );
                },
                itemCount: state.appResponse.data.length));
      }
      if (state is GetNotificationsFailure) {
        return AppErrorWidget(
            errorText: state.error,
            onRetryClicked:
                context.read<GetNotificationsCubit>().getNotifications);
      }
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}
