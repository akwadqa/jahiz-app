import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/app_constants.dart';
import '../../../app_settings/presentation/bloc/app_settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._sharedPreferences) : super(Unauthenticated()) {
    _initial();
  }

  final SharedPreferences _sharedPreferences;

  void _initial() {
    final bool isContainToken =
        _sharedPreferences.containsKey(AppConstants.tokenKey);
    if (isContainToken) {
      final String? token = _sharedPreferences.getString(AppConstants.tokenKey);
      emit(Authenticated(token!));
    }
  }

  Future<void> setAuthenticated(String token) async {
    await _sharedPreferences.setString(AppConstants.tokenKey, token);
    emit(Authenticated(token));
    await getIt<AppSettingsCubit>().getAppSettings();
  }

  Future<void> setUnauthenticated() async {
    await _sharedPreferences.remove(AppConstants.tokenKey);
    emit(Unauthenticated());
    await getIt<AppSettingsCubit>().getAppSettings();
  }
}
