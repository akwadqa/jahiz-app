import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import 'titled_container.dart';
import '../../../../generated/l10n.dart';

import '../../../../core/gen/assets.gen.dart';
import 'account_details_item.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitledContainer(
            title: S.of(context).myAccount,
            child: Column(
              children: [
                AccountDetailsItem(
                  leading: Assets.images.addressesIcon.svg(),
                  title: S.of(context).myAddresses,
                  onTap: () => context.pushRoute(const AddressesRoute()),
                ),
                const Divider(),
                AccountDetailsItem(
                  leading: Assets.images.editProfileIcon.svg(),
                  title: S.of(context).editProfile,
                  onTap: () => context.pushRoute(const EditProfileRoute()),
                ),
                const Divider(),
                AccountDetailsItem(
                  leading: Assets.images.folderIcon.svg(),
                  title: S.of(context).myOrders,
                  onTap: () => context.pushRoute(const OrderHistoryRoute()),
                ),
              ],
            )),
        const SizedBox(height: 30),
      ],
    );
  }
}
