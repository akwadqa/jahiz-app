import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/features/notifications/application/notifications_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';

void main() {
  group("SelectedLanguageCubit", () {
    late SelectedLanguageCubit selectedLanguageCubit;
    late SharedPreferences sharedPreferences;
    late MockBuildContext mockBuildContext;

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      sharedPreferences = MockSharedPreferences();
      mockBuildContext = MockBuildContext();
      when(() => sharedPreferences.getString(AppConstants.languageKey))
          .thenReturn('en');
      selectedLanguageCubit = SelectedLanguageCubit(sharedPreferences);
    });

    test('emits [initialValue] when created', () {
      expect(selectedLanguageCubit.state, 'en');
    });
    test(
        'changing language in sharedPreferences and the state in selectedLanguageCubit',
        () {
      const String newValue = 'en';
      SelectedLanguageCubit(sharedPreferences)
          .setLanguage(newValue, mockBuildContext);
      expect(sharedPreferences.getString(AppConstants.languageKey), 'en');
      expect(selectedLanguageCubit.state, newValue);
    });
  });
}

class MockSharedPreferences extends Mock implements SharedPreferences {
  @override
  Future<bool> setString(String key, String value) {
    return Future.value(true);
  }
}

class MockBuildContext extends Mock implements BuildContext {}

class MockNotificationsService extends Mock implements NotificationsService {}
