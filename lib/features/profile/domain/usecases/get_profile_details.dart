import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/profile/domain/entities/profile_details.dart';
import 'package:jahiz/features/profile/domain/repositories/profile_repository.dart';

class GetProfileDetailsUseCase {
  final ProfileRepository _repository;

  GetProfileDetailsUseCase(this._repository);

  Future<Either<Failure, ProfileDetails>> call() async =>
      await _repository.getProfileDetails();
}
