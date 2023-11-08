import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/shared_functions.dart';
import '../../../domain/entities/profile_details.dart';
import '../../../domain/usecases/update_profile_details.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this._updateProfileDetailsUseCase)
      : super(EditProfileInitial());

  final UpdateProfileDetailsUseCase _updateProfileDetailsUseCase;

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  String? _firstName;
  String? _lastName;
  String? _phone;
  String? _email;

  String? Function(String?)? validator(BuildContext context) =>
      SharedFunctions.requiredValidator(context);

  String? Function(String?)? emailValidator(BuildContext context) =>
      SharedFunctions.emailValidator(context);

  String? Function(String?)? phoneValidator(BuildContext context) =>
      SharedFunctions.phoneNumberValidator(context);

  void onSavedFirstName(String? value) => _firstName = value;

  void onSavedLastName(String? value) => _lastName = value;

  void onSavedPhoneNumber(String? value) => _phone = value;

  void onSavedEmail(String? value) => _email = value;

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      emit(EditProfileLoading());
      final failuerOrLoaded = await _updateProfileDetailsUseCase(
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          phone: _phone,
          enabled: null);

      failuerOrLoaded.fold((failure) => emit(EditProfileError(failure.message)),
          (profileDetails) => emit(EditProfileSuccess(profileDetails)));
    }
  }

  Future<void> deleteProfile() async {
    emit(EditProfileDeleteLoading());
    final failuerOrLoaded = await _updateProfileDetailsUseCase(
        firstName: null, lastName: null, email: null, phone: null, enabled: 0);

    failuerOrLoaded.fold((failure) => emit(EditProfileError(failure.message)),
        (profileDetails) => emit(EditProfileSuccess(profileDetails)));
  }
}
