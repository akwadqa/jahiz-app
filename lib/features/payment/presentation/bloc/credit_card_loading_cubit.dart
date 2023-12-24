import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardLoadingCubit extends Cubit<bool> {
  CreditCardLoadingCubit() : super(true);

  void setLoadingValue(bool value) => emit(value);
}
