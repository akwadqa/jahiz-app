import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jahiz/features/auth/domain/usecases/login.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/features/notifications/application/notifications_service.dart';

import '../../../../../core/app_constants.dart';
import '../../../../../core/shared_functions.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._authCubit, this._notificationsService)
      : super(LoginInitial());

  final LoginUseCase _loginUseCase;
  final AuthCubit _authCubit;
  final NotificationsService _notificationsService;

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  String? _password;

  String? Function(String?)? validator(BuildContext context) =>
      SharedFunctions.requiredValidator(context);

  void onSavedPassword(String? value) => _password = value;

  Future<void> login(String phoneNumber) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      emit(LoginLoadInProgress());
      final failureOrAuthResponse = await _loginUseCase(
          '${AppConstants.qatarInternationalCode}$phoneNumber', _password!);
      failureOrAuthResponse
          .fold((failure) => emit(LoginLoadFailure(failure.message)),
              (authResponse) async {
        await _authCubit.setAuthenticated(authResponse.data.token);
        await _notificationsService
            .setDeviceToken();
        emit(LoginLoadSuccess(authResponse.message));
      });
    }
  }
}
