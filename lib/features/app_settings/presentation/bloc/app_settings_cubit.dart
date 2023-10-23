import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:jahiz/features/app_settings/domain/entities/app_settings.dart';

import '../../domain/usecases/get_app_settings.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppSettingsCubit extends Cubit<AppSettings?> {
  AppSettingsCubit(this._getAppSettingsUseCase) : super(null) {
    initialize();
  }

  final GetAppSettingsUseCase _getAppSettingsUseCase;

  Future<void> initialize() async {
    await getAppSettings();
    if (state != null) {
      FlutterNativeSplash.remove();
    }
  }

  Future<void> getAppSettings() async {
    final failureOrAppSettings = await _getAppSettingsUseCase();
    failureOrAppSettings.fold((failure) {
      if (kDebugMode) {
        print(failure.message);
      }
    }, (appSettings) {
      emit(appSettings);
    });
  }

  Future<void> refresh() async {
    await getAppSettings();
  }
}
