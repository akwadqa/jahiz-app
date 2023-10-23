import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/app_settings_repository.dart';
import '../datasources/app_settings_remote_data_source.dart';

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  final AppSettingsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  AppSettingsRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    if (await _networkInfo.isConnected) {
      try {
        AppSettings appSettings = await _remoteDataSource.getAppSettings();
        return Right(appSettings);
      } on ServerException catch (e, stackTrace) {
        return Left(ServerFailure(e.message ?? e.toString(), stackTrace));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
