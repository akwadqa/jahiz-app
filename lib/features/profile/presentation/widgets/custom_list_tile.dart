import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/generated/l10n.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    if (authState is Authenticated) {
      return ListTile(
        leading: Text(
          S.of(context).signOut,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.darkGreen,
          ),
        ),
        trailing: Assets.images.logoutIcon.svg(),
        onTap: context.read<AuthCubit>().setUnauthenticated,
      );
    } else {
      return ListTile(
          leading: Text(
            S.of(context).country,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGreen,
            ),
          ),
          trailing: Text(
            S.of(context).qatar,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.gray,
            ),
          ));
    }
  }
}
