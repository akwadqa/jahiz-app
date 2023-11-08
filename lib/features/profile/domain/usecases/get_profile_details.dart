import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_details.dart';
import '../repositories/profile_repository.dart';

class GetProfileDetailsUseCase {
  final ProfileRepository _repository;

  GetProfileDetailsUseCase(this._repository);

  Future<Either<Failure, ProfileDetails>> call() async =>
      await _repository.getProfileDetails();
}
