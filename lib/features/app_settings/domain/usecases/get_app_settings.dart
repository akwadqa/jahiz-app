import 'package:dartz/dartz.dart';
import 'package:jahiz/features/app_settings/domain/entities/app_settings.dart';

import '../../../../core/error/failures.dart';
import '../repositories/app_settings_repository.dart';

class GetAppSettingsUseCase {
  final AppSettingsRepository _repository;

  GetAppSettingsUseCase(this._repository);

  Future<Either<Failure, AppSettings>> call() async =>
      await _repository.getAppSettings();
}
