import 'package:dartz/dartz.dart';
import '../entities/app_settings.dart';

import '../../../../core/error/failures.dart';

abstract class AppSettingsRepository {
  Future<Either<Failure, AppSettings>> getAppSettings();
}
