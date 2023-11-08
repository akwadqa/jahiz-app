import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/blocs/selected_language_cubit.dart';
import '../../../../core/theme/app_colors.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        S.of(context).language,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.darkGreen,
        ),
      ),
      trailing: BlocBuilder<SelectedLanguageCubit, String>(
        builder: (context, state) {
          return ToggleSwitch(
            initialLabelIndex: state == 'ar' ? 0 : 1,
            totalSwitches: 2,
            inactiveBgColor: Colors.white,
            borderColor: [Colors.grey.shade400, Colors.grey.shade400],
            borderWidth: 1,
            labels: [
              S.of(context).arabic,
              S.of(context).english,
            ],
            onToggle: (index) {
              final language = index == 0 ? 'ar' : 'en';
              context.read<SelectedLanguageCubit>().language = language;
            },
          );
        },
      ),
    );
  }
}
