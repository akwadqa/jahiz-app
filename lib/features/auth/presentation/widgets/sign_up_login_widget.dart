import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  const SignUpLoginWidget({Key? key}) : super(key: key);

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
              Form(
                key: context.read<CheckUserValidationCubit>().formKey,
                child: Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: AppConstants.phoneNumberHint),
                  textInputAction: TextInputAction.done,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  validator: context
                      .read<CheckUserValidationCubit>()
                      .validator(context),
                  onSaved: context
                      .read<CheckUserValidationCubit>()
                      .onSavedPhoneNumber,
                )),
              )
            ],
          )
        ],
      ),
      submitButton:
          BlocConsumer<CheckUserValidationCubit, CheckUserValidationState>(
              listenWhen: (previousState, state) =>
                  state is CheckUserValidationLoadSuccess,
              listener: (context, state) {
                context.popRoute().then((value) {
                  showAppBottomSheet(
                      context: context,
                      child:
                          (state as CheckUserValidationLoadSuccess).userIsExist
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
                  return const CircularProgressIndicator.adaptive();
                } else if (state is CheckUserValidationLoadFailure) {
                  return AppErrorWidget(
                      errorText: state.error,
                      onRetryClicked: context
                          .read<CheckUserValidationCubit>()
                          .checkUserValidation);
                }
                return ElevatedButton(
                  onPressed: context
                      .read<CheckUserValidationCubit>()
                      .checkUserValidation,
                  child: Text(S.of(context).continueLabel),
                );
              }),
    );
  }
}
