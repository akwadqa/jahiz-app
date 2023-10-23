import 'package:dartz/dartz.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';

import 'package:jahiz/core/error/failures.dart';
import 'package:jahiz/features/auth/domain/entities/auth.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  AuthRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, bool>> checkUserValidation(String phoneNumber) async {
    if (await _networkInfo.isConnected) {
      try {
        bool userIsExist =
            await _remoteDataSource.checkUserValidation(phoneNumber);
        return Right(userIsExist);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AppResponse<Auth>>> login(
      String phoneNumber, String password) async {
    return _handleAuthResponse(_remoteDataSource.login(phoneNumber, password));
  }

  @override
  Future<Either<Failure, AppResponse<Auth>>> register(String firstName,
      String lastName, String email, String phoneNumber, String password) {
    return _handleAuthResponse(_remoteDataSource.register(
        firstName, lastName, email, phoneNumber, password));
  }

  Future<Either<Failure, AppResponse<Auth>>> _handleAuthResponse(
      Future<AppResponse<Auth>> function) async {
    if (await _networkInfo.isConnected) {
      try {
        AppResponse<Auth> authResponse = await function;
        return Right(authResponse);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
