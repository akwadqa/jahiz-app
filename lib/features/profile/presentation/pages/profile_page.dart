import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/gen/fonts.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/widgets/sign_up_login_bottom_sheet.dart';
import '../../../auth/application/auth_cubit.dart';
import '../widgets/account_details.dart';
import '../widgets/action_button.dart';
import '../widgets/settings.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/gen/assets.gen.dart';
import '../../../app_settings/domain/entities/app_settings.dart';
import '../../../app_settings/presentation/bloc/app_settings_cubit.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        child: Assets.images.profileIcon
            .svg(height: 88, width: 88, color: AppColors.whiteLilacColor),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: AppColors.whiteLilacColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                        icon: Assets.images.shareAppIcon.svg(),
                        onTap: () => _shareApp('', ''),
                        text: S.of(context).appShare),
                    ActionButton(
                        icon: Assets.images.contactUsIcon.image(),
                        onTap: () => _contactUs(context),
                        text: S.of(context).contactUs),
                  ],
                ),
                const SizedBox(height: 40),
                BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is Authenticated) {
                    return const AccountDetails();
                  }
                  return const SizedBox.shrink();
                }),
                const Settings(),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                        '${S.of(context).version} ${getIt<PackageInfo>().version}',
                        style: const TextStyle(color: AppColors.gray))),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 0.0,
        right: 0.0,
        top: MediaQuery.of(context).size.height * 0.22,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.black.withOpacity(0.16),
                      blurRadius: 10)
                ]),
            margin: const EdgeInsets.symmetric(horizontal: 60),
            child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              if (state is Authenticated) {
                return BlocBuilder<AppSettingsCubit, AppSettings?>(
                    builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      children: [
                        Text(state!.fullName,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        Text(state.username,
                            style: const TextStyle(color: AppColors.lightGray)),
                      ],
                    ),
                  );
                });
              }
              return TextButton(
                  onPressed: () => showSignUpLoginBottomSheet(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.qatar),
                  ),
                  child: Text(S.of(context).login));
            })),
      )
    ]);
  }

  void _shareApp(String androidAppId, String iOSAppId) {
    final url = Platform.isIOS
        ? 'https://apps.apple.com/app/id$iOSAppId'
        : 'https://play.google.com/store/apps/details?id=$androidAppId';
    Share.share(url);
  }

  Future<void> _contactUs(BuildContext context) async {
    final phone = context.read<AppSettingsCubit>().state?.mobileNo ?? '';
    final Uri telLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (!await launchUrl(telLaunchUri)) {
      throw Exception('Could not launch $telLaunchUri');
    }
  }
}
