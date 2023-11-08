import 'package:bloc/bloc.dart';
import '../app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedLanguageCubit extends Cubit<String> {
  SelectedLanguageCubit(this._sharedPreferences)
      : super(_sharedPreferences.getString(AppConstants.languageKey) ?? 'en');

  final SharedPreferences _sharedPreferences;

  set language(String value) {
    _sharedPreferences.setString(AppConstants.languageKey, value);
    emit(value);
  }
}
