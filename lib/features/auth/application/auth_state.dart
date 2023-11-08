part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class Unauthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String token;

  const Authenticated(this.token);
  @override
  List<Object> get props => [token];
}
