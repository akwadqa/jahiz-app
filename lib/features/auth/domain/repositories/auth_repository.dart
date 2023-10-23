import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> checkUserValidation(String phoneNumber);

  Future<Either<Failure, AppResponse<Auth>>> login(
      String phoneNumber, String password);

  Future<Either<Failure, AppResponse<Auth>>> register(String firstName,
      String lastName, String email, String phoneNumber, String password);
}
