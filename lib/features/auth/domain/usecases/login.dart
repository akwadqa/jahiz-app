import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, AppResponse<Auth>>> call(
          String phoneNumber, String password) async =>
      await _repository.login(phoneNumber, password);
}
