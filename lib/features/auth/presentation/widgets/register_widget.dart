import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/features/auth/presentation/bloc/register/register_cubit.dart';
import 'package:jahiz/generated/l10n.dart';

import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/check_box_form_field.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key, required this.userPhoneNumber})
      : super(key: key);
  final String userPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
      title: S.of(context).registerANewAccount,
      subtitle: S.of(context).registerDescription,
      isShowBackButton: false,
      content: Form(
        key: context.read<RegisterCubit>().formKey,
        child: Column(
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                    '${AppConstants.qatarInternationalCode}$userPhoneNumber',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor))),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                    label: Text(S.of(context).firstName),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: context.read<RegisterCubit>().validator(context),
                  onSaved: context.read<RegisterCubit>().onSavedFirstName,
                )),
                const SizedBox(width: 14.0),
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                    label: Text(S.of(context).lastName),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: context.read<RegisterCubit>().validator(context),
                  onSaved: context.read<RegisterCubit>().onSavedLastName,
                )),
              ],
            ),
            const SizedBox(height: 14.0),
            TextFormField(
              decoration: InputDecoration(
                label: Text(S.of(context).email),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: context.read<RegisterCubit>().emailValidator(context),
              onSaved: context.read<RegisterCubit>().onSavedEmail,
            ),
            const SizedBox(height: 14.0),
            TextFormField(
              decoration: InputDecoration(
                label: Text(S.of(context).password),
              ),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              validator:
                  context.read<RegisterCubit>().passwordValidator(context),
              onSaved: context.read<RegisterCubit>().onSavedPassword,
            ),
            const SizedBox(height: 20.0),
            CheckBoxFormField(
              validator: (value) => context
                  .read<RegisterCubit>()
                  .checkBoxValidator(value, context),
              sideWidgets: [
                Text(S.of(context).agreeTermsAndConditions),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).termsAndConditions,
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ],
        ),
      ),
      submitButton: BlocConsumer<RegisterCubit, RegisterState>(
          listenWhen: (_, state) => state is RegisterLoadSuccess,
          listener: (ctx, state) {
            context.popRoute();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text((state as RegisterLoadSuccess).message)));
          },
          builder: (context, state) {
            if (state is RegisterLoadInProgress) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is RegisterLoadFailure) {
              return AppErrorWidget(
                  errorText: state.error,
                  onRetryClicked: () =>
                      context.read<RegisterCubit>().register(userPhoneNumber));
            }
            return ElevatedButton(
                onPressed: () =>
                    context.read<RegisterCubit>().register(userPhoneNumber),
                child: Text(S.of(context).createAccount));
          }),
    );
  }
}
