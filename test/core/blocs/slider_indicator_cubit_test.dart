import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jahiz/core/blocs/slider_indicator_cubit.dart';

void main() {
  late SliderIndicatorCubit sliderIndicatorCubit;

  setUp(() {
    sliderIndicatorCubit = SliderIndicatorCubit();
  });

  blocTest<SliderIndicatorCubit, int>(
    "set page to 0",
    build: () => sliderIndicatorCubit,
    act: (cubit) => cubit.page = 2,
    expect: () => [2],
  );
}
