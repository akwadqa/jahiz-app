import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/auth/presentation/widgets/login_text_form_field_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../bloc/login/login_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import 'qatar_international_code_widget.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key, required this.userPhoneNumber})
      : super(key: key);
  final String userPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return AppBottomSheetSkeleton(
      title: S.of(context).login,
      subtitle: S.of(context).loginDescription,
      isShowBackButton: false,
      content: Form(
        key: context.read<LoginCubit>().formKey,
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const QatarInternationalCodeWidget(),
                const SizedBox(width: 6.0),
                Expanded(
                  child: LoginTextFormField(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      initialValue: userPhoneNumber,
                      readOnly: true,
                      filled: true,
                      fillColor:
                          Theme.of(context).primaryColor.withOpacity(0.05)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const _PasswordTextFormField()
          ],
        ),
      ),
      stackedSubmitButton: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (_, state) => state is LoginLoadSuccess,
          listener: (ctx, state) {
            context.popRoute();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text((state as LoginLoadSuccess).message)));
          },
          builder: (context, state) {
            if (state is LoginLoadInProgress) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is LoginLoadFailure) {
              return AppErrorWidget(
                  errorText: state.error,
                  onRetryClicked: () =>
                      context.read<LoginCubit>().login(userPhoneNumber));
            }
            return ElevatedButton(
              onPressed: () =>
                  context.read<LoginCubit>().login(userPhoneNumber),
              child: Text(S.of(context).login),
            );
          }),
    );
  }
}

class _PasswordTextFormField extends StatefulWidget {
  const _PasswordTextFormField({Key? key}) : super(key: key);

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
      onSaved: context.read<LoginCubit>().onSavedPassword,
      validator: context.read<LoginCubit>().validator(context),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
  }
}
