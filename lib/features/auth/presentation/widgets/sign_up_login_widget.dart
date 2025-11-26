import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/auth/presentation/widgets/login_text_form_field_widget.dart';
import '../../../../core/app_constants.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../bloc/check_user_validation/check_user_validation_cubit.dart';
import '../bloc/login/login_cubit.dart';
import 'login_widget.dart';
import 'register_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

import '../../../../core/widgets/app_bottom_sheet.dart';
import '../bloc/register/register_cubit.dart';
import 'qatar_international_code_widget.dart';

class SignUpLoginWidget extends StatelessWidget {
  const SignUpLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
      title: S.of(context).signupLogin,
      subtitle: S.of(context).signupLoginDescription,
      isShowBackButton: false,
      content: Column(
        children: [
          const SizedBox(height: 30.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const QatarInternationalCodeWidget(),
              const SizedBox(width: 6),
              Expanded(
                child: Form(
                  key: context.read<CheckUserValidationCubit>().formKey,
                  child: LoginTextFormField(
                    labelText: AppConstants.phoneNumberHint,
                    validator: context
                        .read<CheckUserValidationCubit>()
                        .validator(context),
                    onSaved: context
                        .read<CheckUserValidationCubit>()
                        .onSavedPhoneNumber,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      stackedSubmitButton: BlocConsumer<CheckUserValidationCubit,
              CheckUserValidationState>(
          listenWhen: (previousState, state) =>
              state is CheckUserValidationLoadSuccess,
          listener: (context, state) {
            context.maybePop().then((value) {
              showAppBottomSheet(
                  context: context,
                  child: (state as CheckUserValidationLoadSuccess).userIsExist
                      ? BlocProvider(
                          create: (_) => getIt<LoginCubit>(),
                          child: LoginWidget(
                              userPhoneNumber: state.userPhoneNumber))
                      : BlocProvider(
                          create: (_) => getIt<RegisterCubit>(),
                          child: RegisterWidget(
                              userPhoneNumber: state.userPhoneNumber)));
            });
          },
          builder: (context, state) {
            if (state is CheckUserValidationLoadInProgress) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CheckUserValidationLoadFailure) {
              return AppErrorWidget(
                  errorText: state.error,
                  onRetryClicked: context
                      .read<CheckUserValidationCubit>()
                      .checkUserValidation);
            }
            return ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Theme.of(context).primaryColor)),
              onPressed:
                  context.read<CheckUserValidationCubit>().checkUserValidation,
              child: Text(S.of(context).continueLabel),
            );
          }),
    );
  }
}
