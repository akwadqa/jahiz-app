import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/features/auth/domain/usecases/check_user_validation.dart';

part 'check_user_validation_state.dart';

class CheckUserValidationCubit extends Cubit<CheckUserValidationState> {
  CheckUserValidationCubit(this._checkUserValidationUseCase)
      : super(CheckUserValidationInitial());

  final CheckUserValidationUseCase _checkUserValidationUseCase;

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  String? _phoneNumber;

  String? Function(String?)? validator(BuildContext context) =>
      SharedFunctions.phoneNumberValidator(context);

  void onSavedPhoneNumber(String? value) => _phoneNumber = value;

  Future<void> checkUserValidation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      emit(CheckUserValidationLoadInProgress());
      final failureOrUserIsExist = await _checkUserValidationUseCase(
          '${AppConstants.qatarInternationalCode}$_phoneNumber');
      failureOrUserIsExist.fold(
          (failure) => emit(CheckUserValidationLoadFailure(failure.message)),
          (userIsExist) =>
              emit(CheckUserValidationLoadSuccess(userIsExist, _phoneNumber!)));
    }
  }
}
