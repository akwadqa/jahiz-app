import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/domain/entities/app_response.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/auth.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends NetworkOperationHandler
    implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  AuthRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo)
      : super(networkInfo);

  @override
  Future<Either<Failure, bool>> checkUserValidation(String phoneNumber) async {
    return await handleNetworkOperation<bool>(() async {
      final response = await _remoteDataSource.checkUserValidation(phoneNumber);
      return response;
    });
  }

  @override
  Future<Either<Failure, AppResponse<Auth>>> login(
      String phoneNumber, String password) async {
    return await handleNetworkOperation<AppResponse<Auth>>(() async {
      AppResponse<Auth> authResponse =
          await _remoteDataSource.login(phoneNumber, password);
      return authResponse;
    });
  }

  @override
  Future<Either<Failure, AppResponse<Auth>>> register(String firstName,
      String lastName, String email, String phoneNumber, String password) async {
    return await handleNetworkOperation<AppResponse<Auth>>(() async {
      AppResponse<Auth> authResponse = await _remoteDataSource.register(
          firstName, lastName, email, phoneNumber, password);
      return authResponse;
    });
  }
}
