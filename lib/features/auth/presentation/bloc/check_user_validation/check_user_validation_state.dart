part of 'check_user_validation_cubit.dart';

abstract class CheckUserValidationState extends Equatable {
  const CheckUserValidationState();
}

class CheckUserValidationInitial extends CheckUserValidationState {
  @override
  List<Object> get props => [];
}

class CheckUserValidationLoadInProgress extends CheckUserValidationState {
  @override
  List<Object> get props => [];
}

class CheckUserValidationLoadSuccess extends CheckUserValidationState {
  final bool userIsExist;
  final String userPhoneNumber;
  const CheckUserValidationLoadSuccess(this.userIsExist, this.userPhoneNumber);
  @override
  List<Object> get props => [userIsExist, userPhoneNumber];
}

class CheckUserValidationLoadFailure extends CheckUserValidationState {
  final String error;
  const CheckUserValidationLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
