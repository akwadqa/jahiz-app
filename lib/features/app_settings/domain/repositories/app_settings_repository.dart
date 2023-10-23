import 'package:dartz/dartz.dart';
import 'package:jahiz/features/app_settings/domain/entities/app_settings.dart';

import '../../../../core/error/failures.dart';

abstract class AppSettingsRepository {
  Future<Either<Failure, AppSettings>> getAppSettings();
}
