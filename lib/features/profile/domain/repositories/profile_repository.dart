import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_details.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileDetails>> getProfileDetails();

  Future<Either<Failure, ProfileDetails>> updateProfileDetails(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      int? enabled});
}
