import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../domain/entities/profile_details.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ProfileRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ProfileDetails>> getProfileDetails() async {
    if (await _networkInfo.isConnected) {
      try {
        ProfileDetails profileDetails =
            await _remoteDataSource.getProfileDetails();
        return Right(profileDetails);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ProfileDetails>> updateProfileDetails(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      int? enabled}) async {
    if (await _networkInfo.isConnected) {
      try {
        ProfileDetails profileDetails =
            await _remoteDataSource.updateProfileDetails(
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                enabled: enabled);
        return Right(profileDetails);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
