import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/shared_functions.dart';
import '../../../domain/usecases/register.dart';
import '../../../../notifications/application/notifications_service.dart';
import '../../../../../generated/l10n.dart';
import 'package:queen_validators/queen_validators.dart';

import '../../../../../core/app_constants.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase, this._notificationsService)
      : super(RegisterInitial());

  final RegisterUseCase _registerUseCase;
  final NotificationsService _notificationsService;

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;

  String? Function(String?)? validator(BuildContext context) =>
      SharedFunctions.requiredValidator(context);

  String? Function(String?)? emailValidator(BuildContext context) =>
      SharedFunctions.emailValidator(context);

  String? Function(String?)? passwordValidator(BuildContext context) =>
      qValidator([
        IsRequired(S.of(context).required),
        MinLength(8, S.of(context).mustBeEightDigitsAtLeast)
      ]);

  String? checkBoxValidator(bool? value, BuildContext context) =>
      value == null || !value
          ? S.of(context).agreeTermsAndConditionsValidator
          : null;

  void onSavedFirstName(String? value) => _firstName = value;

  void onSavedLastName(String? value) => _lastName = value;

  void onSavedEmail(String? value) => _email = value;

  void onSavedPassword(String? value) => _password = value;

  Future<void> register(String phoneNumber) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      emit(RegisterLoadInProgress());
      final failureOrAuthResponse = await _registerUseCase(
          _firstName!,
          _lastName!,
          _email!,
          '${AppConstants.jordanInternationalCode}$phoneNumber',
          _password!);
      failureOrAuthResponse
          .fold((failure) => emit(RegisterLoadFailure(failure.message)),
              (authResponse) async {
        await _notificationsService.setDeviceToken();
        emit(RegisterLoadSuccess(authResponse.data.token));
      });
    }
  }
}
