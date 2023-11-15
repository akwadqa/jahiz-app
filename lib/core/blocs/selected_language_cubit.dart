import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jahiz/features/notifications/application/notifications_service.dart';
import 'package:jahiz/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_constants.dart';

class SelectedLanguageCubit extends Cubit<String> {
  SelectedLanguageCubit(this._sharedPreferences)
      : super(_sharedPreferences.getString(AppConstants.languageKey) ?? 'en');

  final SharedPreferences _sharedPreferences;

  void setLanguage(String value, BuildContext context) async {
    await _sharedPreferences.setString(AppConstants.languageKey, value);
    emit(value);
    await getIt.reset();
    await init();
    await getIt<NotificationsService>().init();
  }
}
