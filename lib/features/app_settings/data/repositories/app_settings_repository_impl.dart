import 'package:dartz/dartz.dart';
import 'package:jahiz/core/network/network_operation_handler_mixin.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/app_settings_repository.dart';
import '../datasources/app_settings_remote_data_source.dart';

class AppSettingsRepositoryImpl extends NetworkOperationHandler implements AppSettingsRepository {
  final AppSettingsRemoteDataSource _remoteDataSource;
  AppSettingsRepositoryImpl(this._remoteDataSource, NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    return await handleNetworkOperation<AppSettings>(() async {
      final response = await _remoteDataSource.getAppSettings();
      return response;
    });
  }
}
