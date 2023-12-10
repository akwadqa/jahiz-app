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
  final String token;

  const LoginLoadSuccess(this.token);
  @override
  List<Object> get props => [token];
}

class LoginLoadFailure extends LoginState {
  final String error;
  const LoginLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
