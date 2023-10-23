import 'package:bloc/bloc.dart';

class SliderIndicatorCubit extends Cubit<int> {
  SliderIndicatorCubit() : super(0);

  set page(int value) => emit(value);
}
