import 'package:bloc/bloc.dart';

class SelectedLanguageCubit extends Cubit<String> {
  SelectedLanguageCubit() : super('en');

  set language(String value) => emit(value);
}
