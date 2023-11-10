import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/profile_remote_data_source.dart';
import '../../domain/entities/profile_details.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends NetworkOperationHandler
    implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, ProfileDetails>> getProfileDetails() async {
    return await handleNetworkOperation<ProfileDetails>(() async {
      final response = await _remoteDataSource.getProfileDetails();
      return response;
    });
  }

  @override
  Future<Either<Failure, ProfileDetails>> updateProfileDetails(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      int? enabled}) async {
    return await handleNetworkOperation<ProfileDetails>(() async {
      final response = await _remoteDataSource.updateProfileDetails(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          enabled: enabled);
      return response;
    });
  }
}
