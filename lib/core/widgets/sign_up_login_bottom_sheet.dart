import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/check_user_validation/check_user_validation_cubit.dart';
import '../../features/auth/presentation/widgets/sign_up_login_widget.dart';
import '../../injection_container.dart';
import 'app_bottom_sheet.dart';

Future<dynamic> showSignUpLoginBottomSheet(BuildContext context) {
  return showAppBottomSheet(
      context: context,
      child: BlocProvider(
          create: (_) => getIt<CheckUserValidationCubit>(),
          child: const SignUpLoginWidget()));
}
