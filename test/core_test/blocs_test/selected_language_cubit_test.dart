import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jahiz/core/blocs/selected_language_cubit.dart';

void main() {
  late SelectedLanguageCubit selectedLanguageCubit;
  late SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    selectedLanguageCubit = SelectedLanguageCubit(sharedPreferences);
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
