part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadInProgress extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoadSuccess extends RegisterState {
  final String message;

  const RegisterLoadSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class RegisterLoadFailure extends RegisterState {
  final String error;
  const RegisterLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
