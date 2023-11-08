import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import 'language_switch.dart';
import 'titled_container.dart';
import '../../../../generated/l10n.dart';

import '../../../../core/theme/app_colors.dart';
import 'custom_list_tile.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledContainer(
      title: S.of(context).settings,
      child: Column(
        children: [
          const LanguageSwitch(),
          const Divider(),
          ListTile(
            onTap: () => context.pushRoute(const NotificationsRoute()),
            leading: Text(S.of(context).notification,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGreen)),
            trailing: const Icon(Icons.arrow_forward_ios,
                color: Colors.black, size: 18),
          ),
          const Divider(),
          const CustomListTile(),
        ],
      ),
    );
  }
}
