import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_details.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileDetailsUseCase {
  final ProfileRepository _repository;

  UpdateProfileDetailsUseCase(this._repository);

  Future<Either<Failure, ProfileDetails>> call(
          {String? firstName,
          String? lastName,
          String? email,
          String? phone,
          int? enabled}) async =>
      await _repository.updateProfileDetails(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          enabled: enabled);
}
