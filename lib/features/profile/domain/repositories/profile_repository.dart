import 'package:dartz/dartz.dart';
import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/profile/domain/entities/profile_details.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileDetails>> getProfileDetails();

  Future<Either<Failure, ProfileDetails>> updateProfileDetails(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      int? enabled});
}
