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
  final String token;

  const RegisterLoadSuccess(this.token);
  @override
  List<Object> get props => [token];
}

class RegisterLoadFailure extends RegisterState {
  final String error;
  const RegisterLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
