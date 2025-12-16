import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/auth/application/auth_cubit.dart';
import '../../../../core/app_constants.dart';
import '../bloc/register/register_cubit.dart';
import '../../../../generated/l10n.dart';

import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/check_box_form_field.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key, required this.userPhoneNumber});
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
                    '${AppConstants.jordanInternationalCodeLabel}$userPhoneNumber',
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
                  textCapitalization: TextCapitalization.sentences,
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
                  textCapitalization: TextCapitalization.sentences,
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
            const _PasswordTextFormField(),
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
          listener: (ctx, state) => context
              .read<AuthCubit>()
              .setAuthenticated((state as RegisterLoadSuccess).token),
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
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Theme.of(context).primaryColor)),
                onPressed: () =>
                    context.read<RegisterCubit>().register(userPhoneNumber),
                child: Text(S.of(context).createAccount));
          }),
    );
  }
}

class _PasswordTextFormField extends StatefulWidget {
  const _PasswordTextFormField();

  @override
  State<_PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<_PasswordTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          label: Text(S.of(context).password),
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )),
      obscureText: _obscureText,
      onSaved: context.read<RegisterCubit>().onSavedPassword,
      validator: context.read<RegisterCubit>().passwordValidator(context),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
