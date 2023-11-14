import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_constants.dart';

class SelectedLanguageCubit extends Cubit<String> {
  SelectedLanguageCubit(this._sharedPreferences)
      : super(_sharedPreferences.getString(AppConstants.languageKey) ?? 'en');

  final SharedPreferences _sharedPreferences;

  void setLanguage(String value) async {
    await _sharedPreferences.setString(AppConstants.languageKey, value);
    emit(value);
  }
}
