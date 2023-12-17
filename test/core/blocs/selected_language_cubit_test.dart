import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';

//Todo: There is an error on this test
void main() {
  late SelectedLanguageCubit selectedLanguageCubit;
  late SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();

    when(() => sharedPreferences.getString(AppConstants.languageKey))
        .thenReturn('en'); // Mock the behavior of SharedPreferences
    selectedLanguageCubit = SelectedLanguageCubit(sharedPreferences);
  });

  test('emits [initialValue] when created', () {
    expect(selectedLanguageCubit.state, 'en');
  });

  blocTest<SelectedLanguageCubit, String>(
    'emits ["value"] when setLanguage is called',
    build: () => selectedLanguageCubit,
    act: (cubit) => cubit.setLanguage("ar", MockBuildContext()),
    expect: () => ['ar'],
  );
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockBuildContext extends Mock implements BuildContext {}
