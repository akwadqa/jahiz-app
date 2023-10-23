import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class CheckUserValidationUseCase {
  final AuthRepository _repository;

  CheckUserValidationUseCase(this._repository);

  Future<Either<Failure, bool>> call(String phoneNumber) async =>
      await _repository.checkUserValidation(phoneNumber);
}
