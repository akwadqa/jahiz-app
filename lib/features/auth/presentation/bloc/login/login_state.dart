part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadInProgress extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadSuccess extends LoginState {
  final String message;

  const LoginLoadSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class LoginLoadFailure extends LoginState {
  final String error;
  const LoginLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
