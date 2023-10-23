import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/app_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, AppResponse<Auth>>> call(
          String firstName,
          String lastName,
          String email,
          String phoneNumber,
          String password) async =>
      await _repository.register(
          firstName, lastName, email, phoneNumber, password);
}
